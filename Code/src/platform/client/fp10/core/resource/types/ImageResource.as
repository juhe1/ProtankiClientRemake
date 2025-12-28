package platform.client.fp10.core.resource.types
{
   import flash.display.BitmapData;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.resource.IResourceSerializationListener;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.ResourceInfo;
   import platform.client.fp10.core.resource.SafeURLLoader;
   import platform.client.fp10.core.resource.IResourceLoadingListener;
   import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
   import scpacker.resource.ResourceImageParams;

   public class ImageResource extends Resource
   {
      public static var localStorage:IResourceLocalStorage;

      private static const DIFFUSE_FILENAME:String = "image.jpg";
      private static const ALPHA_FILENAME:String   = "alpha.jpg";

      private static const STATE_DIFFUSE:int = 0;
      private static const STATE_ALPHA:int   = 1;

      private static const SIGN_I:int = 73; // I
      private static const SIGN_M:int = 77; // M
      private static const SIGN_G:int = 71; // G
      private static const SIGN_V:int = 1;

      private var state:int;
      private var loader:SafeURLLoader;

      private var imageBytes:ImageByteData;
      private var imageBuilder:ImageBuilder;
      private var bitmap:BitmapData;
      private var imageParams:ResourceImageParams;

      public function ImageResource(info:ResourceInfo, params:ResourceImageParams = null)
      {
         super(info);
         this.imageParams = params;
      }

      public function get data():BitmapData
      {
         return this.bitmap;
      }

      override public function get description():String
      {
         return "Image";
      }

      protected function getImageFileName() : String
      {
         return DIFFUSE_FILENAME;
      }

      protected function getAlphaImageFileName() : String
      {
         return ALPHA_FILENAME;
      }

      override public function loadBytes(bytes:ByteArray, listener:IResourceLoadingListener):Boolean
      {
         if(bytes.bytesAvailable < 4 ||
            bytes.readByte() != SIGN_I ||
            bytes.readByte() != SIGN_M ||
            bytes.readByte() != SIGN_G ||
            bytes.readByte() != SIGN_V)
         {
            return false;
         }

         this.listener = listener;

         var imageData:ImageByteData = new ImageByteData();

         var diffuseSize:int = bytes.readInt();
         imageData.diffuseBytes = new ByteArray();
         bytes.readBytes(imageData.diffuseBytes, 0, diffuseSize);

         var alphaSize:int = bytes.readInt();
         if(alphaSize > 0)
         {
            imageData.alphaBytes = new ByteArray();
            bytes.readBytes(imageData.alphaBytes, 0, alphaSize);
         }

         this.imageBuilder = new ImageBuilder();
         this.imageBuilder.build(imageData, this.onBuildComplete);

         return true;
      }

      override public function serialize(listener:IResourceSerializationListener):void
      {
         var bytes:ByteArray = new ByteArray();

         bytes.writeByte(SIGN_I);
         bytes.writeByte(SIGN_M);
         bytes.writeByte(SIGN_G);
         bytes.writeByte(SIGN_V);

         bytes.writeInt(this.imageBytes.diffuseBytes.length);
         bytes.writeBytes(this.imageBytes.diffuseBytes);

         if(this.imageBytes.alphaBytes != null)
         {
            bytes.writeInt(this.imageBytes.alphaBytes.length);
            bytes.writeBytes(this.imageBytes.alphaBytes);
         }
         else
         {
            bytes.writeInt(0);
         }

         this.imageBytes = null;
         listener.onSerializationComplete(this, bytes);
      }

      override public function load(baseUrl:String, listener:IResourceLoadingListener):void
      {
         super.load(baseUrl, listener);
         this.requestDiffuse();
      }

      override protected function doReload():void
      {
         this.loader.close();

         switch(this.state)
         {
            case STATE_DIFFUSE:
               this.requestDiffuse();
               break;

            case STATE_ALPHA:
               this.requestAlpha();
               break;
         }
      }

      override protected function createDummyData():Boolean
      {
         this.bitmap = new StubBitmapData(0xFF0000);
         return true;
      }

      private function onLoadingComplete(e:Event):void
      {
         stopTimeoutTracking();

         switch(this.state)
         {
            case STATE_DIFFUSE:
               this.onDiffuseLoaded(this.loader.data);
               break;

            case STATE_ALPHA:
               this.onAlphaLoaded(this.loader.data);
               break;
         }
      }

      private function requestDiffuse():void
      {
         this.state = STATE_DIFFUSE;
         this.loader = this.createLoader(true);
         this.loader.load(new URLRequest(baseUrl + this.getImageFileName()));

         status = "Diffuse map requested";
         startTimeoutTracking();
      }

      private function requestAlpha():void
      {
         this.state = STATE_ALPHA;
         this.loader = this.createLoader(false);
         this.loader.load(new URLRequest(baseUrl + this.getAlphaImageFileName()));

         status = "Opacity map requested";
         startTimeoutTracking();
      }

      private function onDiffuseLoaded(bytes:ByteArray):void
      {
         this.imageBytes = new ImageByteData();
         this.imageBytes.diffuseBytes = bytes;

         if(this.imageParams != null && this.imageParams.alpha)
         {
            this.requestAlpha();
         }
         else
         {
            this.buildImage();
         }
      }

      private function onAlphaLoaded(bytes:ByteArray):void
      {
         this.imageBytes.alphaBytes = bytes;
         this.buildImage();
      }

      private function buildImage():void
      {
         this.loader = null;

         this.imageBuilder = new ImageBuilder();
         this.imageBuilder.build(this.imageBytes, this.onBuildComplete);
      }

      private function onBuildComplete(builder:ImageBuilder):void
      {
         this.bitmap = builder.image;

         if(hasAllFlags(2) || !localStorage.enabled)
         {
            this.imageBytes = null;
         }

         this.completeLoading();
      }

      override protected function completeLoading():void
      {
         super.completeLoading();
         this.imageBuilder = null;
         baseUrl = null;
      }

      private function onLoadingStart(e:Event):void
      {
         updateLastActivityTime();
         listener.onResourceLoadingStart(this);
      }

      private function onLoadingError(e:ErrorEvent):void
      {
         stopTimeoutTracking();

         if(this.state == STATE_DIFFUSE)
         {
            this.bitmap = new StubBitmapData(0xFF0000);
            setFlags(1);

            baseUrl = null;
            this.imageBytes = null;

            listener.onResourceLoadingError(this, e.toString());
         }
         else
         {
            this.buildImage();
         }
      }

      private function onProgress(e:ProgressEvent):void
      {
         updateLastActivityTime();
      }

      private function createLoader(trackStart:Boolean):SafeURLLoader
      {
         var loader:SafeURLLoader = new SafeURLLoader();
         loader.dataFormat = "binary";

         if(trackStart)
         {
            loader.addEventListener("open", this.onLoadingStart);
         }

         loader.addEventListener("progress", this.onProgress);
         loader.addEventListener("complete", this.onLoadingComplete);
         loader.addEventListener("ioError", this.onLoadingError);
         loader.addEventListener("securityError", this.onLoadingError);

         return loader;
      }
   }
}
