package platform.client.fp10.core.resource.types
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.resource.ResourceUtils;
   
   internal class ImageBuilder
   {
      public var image:BitmapData;
      
      private var newname_3197__END:ImageByteData;
      
      private var callback:Function;
      
      private var loader:Loader;
      
      public function ImageBuilder()
      {
         super();
      }
      
      public function build(param1:ImageByteData, param2:Function) : void
      {
         this.newname_3197__END = param1;
         this.callback = param2;
         this.load(param1.diffuseBytes,this.c67bf9f4);
      }
      
      private function c67bf9f4(param1:Event) : void
      {
         this.image = Bitmap(this.loader.content).bitmapData;
         if(this.newname_3197__END.alphaBytes != null)
         {
            this.load(this.newname_3197__END.alphaBytes,this.a25ccdb9);
         }
         else
         {
            this.complete();
         }
      }
      
      private function a25ccdb9(param1:Event) : void
      {
         var _loc2_:BitmapData = Bitmap(this.loader.content).bitmapData;
         this.image = ResourceUtils.mergeBitmapAlpha(this.image,_loc2_,true);
         this.complete();
      }
      
      private function a1f8c58a(param1:BitmapData) : void
      {
         this.image = param1;
         this.complete();
      }
      
      private function load(param1:ByteArray, param2:Function) : void
      {
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener("complete",param2);
         this.loader.loadBytes(param1);
      }
      
      private function complete() : void
      {
         this.loader = null;
         this.callback.call(null,this);
      }
   }
}

