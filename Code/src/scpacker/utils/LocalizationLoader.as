package scpacker.utils
{
   import platform.client.core.general.resourcelocale.format.ImagePair;
   import platform.client.core.general.resourcelocale.format.LocalizedFileFormat;
   import platform.client.core.general.resourcelocale.format.StringPair;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.locale.ILocaleService;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.BatchImageConstructor;
   
   public class LocalizationLoader
   {
      public static var localeService:ILocaleService;
      
      private var localizedData:LocalizedFileFormat;
      
      private var batchImageConstructor:BatchImageConstructor;
      
      private var completionCallback:Function;
      
      public function LocalizationLoader()
      {
         super();
         localeService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
      }
      
      public function load(param1:String, param2:Function) : void
      {
         this.completionCallback = param2;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.dataFormat = "binary";
         _loc3_.addEventListener("complete",this.onLoadComplete);
         _loc3_.load(new URLRequest(param1));
      }
      
      protected function onLoadComplete(param1:Event) : void
      {
         var _loc2_:ProtocolInitializer = ProtocolInitializer(OSGi.getInstance().getService(ProtocolInitializer));
         var _loc3_:ByteArray = URLLoader(param1.target).data;
         _loc3_.uncompress();
         this.localizedData = LocalizedFileFormat(_loc2_.getCodec("scpacker.networking.protocol.codec.custom.CodecLocalizedFileFormat").decode(_loc3_));
         this.processLocalizationData();
      }
      
      private function processLocalizationData() : void
      {
         var _loc1_:StringPair = null;
         if(this.localizedData.strings != null)
         {
            for each(_loc1_ in this.localizedData.strings)
            {
               localeService.setText(_loc1_.key,_loc1_.value);
            }
         }
         if(this.localizedData.images != null && this.localizedData.images.length > 0)
         {
            this.processImages();
         }
         this.completionCallback();
      }
      
      private function processImages() : void
      {
         var _loc1_:Vector.<ByteArray> = new Vector.<ByteArray>();
         for each(var _loc2_ in this.localizedData.images)
         {
            _loc1_[_loc1_.length] = _loc2_.value;
         }
         this.batchImageConstructor = new BatchImageConstructor();
         this.batchImageConstructor.addEventListener("complete",this.onImagesComplete);
         this.batchImageConstructor.buildImages(_loc1_,5);
      }
      
      private function onImagesComplete(param1:Event) : void
      {
         var _loc2_:Vector.<BitmapData> = this.batchImageConstructor.images;
         this.batchImageConstructor = null;
         var _loc3_:Vector.<ImagePair> = this.localizedData.images;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            localeService.setImage(_loc3_[_loc4_].key,_loc2_[_loc4_]);
            _loc4_++;
         }
      }
   }
}

