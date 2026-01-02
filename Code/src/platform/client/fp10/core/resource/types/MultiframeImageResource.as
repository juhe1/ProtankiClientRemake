package platform.client.fp10.core.resource.types
{
   import platform.client.fp10.core.resource.tara.TARAParser;
   import platform.core.general.resource.types.imageframe.ResourceImageFrameParams;
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
   
   public class MultiframeImageResource extends Resource
   {
      [Inject] // added
      public static var resourceLocalStorage:IResourceLocalStorage;
      
      private static const TARA_FILE_NAME:String = "image.tara";
      
      private static const DIFFUSE_FILE_KEY:String = "i";
      
      private static const ALPHA_FILE_KEY:String = "a";
      
      private static const MAGIC_BYTE_F:int = 70;
      
      private static const MAGIC_BYTE_R:int = 82;
      
      private static const MAGIC_BYTE_M:int = 77;
      
      private static const FORMAT_VERSION:int = 1;
      
      private var frameParams:ResourceImageFrameParams;
      
      private var loader:SafeURLLoader;
      
      private var rawImageData:ByteArray;
      
      private var bitmapData:BitmapData;
      
      public function MultiframeImageResource(param1:ResourceInfo, param2:ResourceImageFrameParams)
      {
         super(param1);
         if(param2 == null)
         {
            throw new Error("Parameter c3bffb77 is null");
         }
         this.frameParams = param2;
      }
      
      public function get frameWidth() : int
      {
         return this.frameParams.frameWidth;
      }
      
      public function get frameHeight() : int
      {
         return this.frameParams.frameHeight;
      }
      
      public function get numFrames() : int
      {
         return this.frameParams.numFrames;
      }
      
      public function get fps() : Number
      {
         return this.frameParams.fps;
      }
      
      public function get data() : BitmapData
      {
         return this.bitmapData;
      }
      
      override public function toString() : String
      {
         return "";
      }
      
      override public function get description() : String
      {
         return "Multiframe image";
      }
      
      override public function loadBytes(param1:ByteArray, param2:IResourceLoadingListener) : Boolean
      {
         if(param1.bytesAvailable < 4 || param1.readByte() != MAGIC_BYTE_F || param1.readByte() != MAGIC_BYTE_R || param1.readByte() != MAGIC_BYTE_M || param1.readByte() != FORMAT_VERSION)
         {
            return false;
         }
         this.listener = param2;
         var _loc3_:int = param1.readInt();
         var _loc4_:ByteArray = new ByteArray();
         param1.readBytes(_loc4_,0,_loc3_);
         this.parseImageData(_loc4_);
         return true;
      }
      
      override public function serialize(param1:IResourceSerializationListener) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeByte(MAGIC_BYTE_F);
         _loc2_.writeByte(MAGIC_BYTE_R);
         _loc2_.writeByte(MAGIC_BYTE_M);
         _loc2_.writeByte(FORMAT_VERSION);
         _loc2_.writeInt(this.rawImageData.length);
         _loc2_.writeBytes(this.rawImageData);
         this.rawImageData = null;
         param1.onSerializationComplete(this,_loc2_);
      }
      
      override public function load(param1:String, param2:IResourceLoadingListener) : void
      {
         super.load(param1,param2);
         this.startLoading();
      }
      
      override protected function doReload() : void
      {
         this.loader.close();
         this.startLoading();
      }
      
      override protected function completeLoading() : void
      {
         super.completeLoading();
         if(hasAllFlags(2) || !resourceLocalStorage.enabled)
         {
            this.rawImageData = null;
         }
      }
      
      private function startLoading() : void
      {
         this.loader = new SafeURLLoader();
         this.loader.dataFormat = "binary";
         this.loader.addEventListener("open",this.onLoadingStart);
         this.loader.addEventListener("complete",this.onLoadingComplete);
         this.loader.addEventListener("ioError",this.onLoadingError);
         this.loader.addEventListener("securityError",this.onLoadingError);
         this.loader.addEventListener("progress",this.onLoadingProgress);
         this.loader.load(new URLRequest(baseUrl + TARA_FILE_NAME));
         startTimeoutTracking();
         status = "Data requested";
      }
      
      private function onLoadingStart(param1:Event) : void
      {
         updateLastActivityTime();
         listener.onResourceLoadingStart(this);
      }
      
      private function onLoadingError(param1:ErrorEvent) : void
      {
         this.bitmapData = new StubBitmapData(16711935,this.frameWidth,this.frameHeight);
         listener.onResourceLoadingError(this,param1.text);
      }
      
      private function onLoadingProgress(param1:ProgressEvent) : void
      {
         updateLastActivityTime();
      }
      
      private function onLoadingComplete(param1:Event) : void
      {
         stopTimeoutTracking();
         this.rawImageData = this.loader.data;
         this.loader = null;
         this.parseImageData(this.rawImageData);
      }
      
      private function parseImageData(param1:ByteArray) : void
      {
         var _loc3_:TARAParser = new TARAParser(param1);
         var _loc2_:ImageByteData = new ImageByteData();
         _loc2_.diffuseBytes = _loc3_.getFileData(DIFFUSE_FILE_KEY);
         _loc2_.alphaBytes = _loc3_.getFileData(ALPHA_FILE_KEY);
         var _loc4_:ImageBuilder = new ImageBuilder();
         _loc4_.build(_loc2_,onImageBuilt);
      }
      
      private function onImageBuilt(param1:ImageBuilder) : void
      {
         this.bitmapData = param1.image;
         this.completeLoading();
      }
   }
}

