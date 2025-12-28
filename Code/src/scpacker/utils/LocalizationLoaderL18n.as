package scpacker.utils
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.osgi.service.locale.LocaleService;
   import alternativa.osgi.service.logging.LogService;
   import alternativa.osgi.service.logging.Logger;
   import alternativa.protocol.IProtocol;
   import alternativa.startup.CacheURLLoader;
   //import alternativa.types.URL;
   import flash.display.BitmapData;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import platform.client.core.general.resourcelocale.format.ImagePair;
   import platform.client.core.general.resourcelocale.format.LocalizedFileFormat;
   import platform.client.core.general.resourcelocale.format.StringPair;
   import platform.client.fp10.core.resource.BatchImageConstructor;
   
   public class LocalizationLoaderL18n
   {
      
      private var localeService:ILocaleService;
      
      private var localeStruct:LocalizedFileFormat;
      
      private var batchImageConstructor:BatchImageConstructor;

      protected var loadCompleteHandler:Function;
      
      private var urlParams:ILauncherParams;
      
      public function LocalizationLoaderL18n()
      {
         super();
         localeService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
      }
      
      public function load(param1:String, param2:Function) : void
      {
         this.loadCompleteHandler = param2;
         loadData(param1);
      }

      private function loadData(param1:String) : void
      {
         var _loc2_:CacheURLLoader = new CacheURLLoader();
         _loc2_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc2_.addEventListener(Event.COMPLETE,this.onLoadingComplete);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
         _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
         _loc2_.load(new URLRequest(param1));
      }
      
      protected function onLoadingComplete(param1:Event) : void
      {
         var _loc2_:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.localeStruct = _loc2_.decode(LocalizedFileFormat,URLLoader(param1.target).data);
         this.registerValues();
      }
      
      private function onLoadingError(param1:ErrorEvent) : void
      {
         OSGi.clientLog.log("er", "Localization not loaded: " + param1.errorID + ", " + param1.text);
      }
      
      private function registerValues() : void
      {
         var _loc1_:StringPair = null;
         if(this.localeStruct.strings != null)
         {
            for each(_loc1_ in this.localeStruct.strings)
            {
               this.localeService.setText(_loc1_.key,_loc1_.value);
            }
         }
         if(this.localeStruct.images != null && this.localeStruct.images.length > 0)
         {
            this.createImages();
         }
         this.loadCompleteHandler();
      }
      
      private function createImages() : void
      {
         var _loc2_:ImagePair = null;
         var _loc1_:Vector.<ByteArray> = new Vector.<ByteArray>();
         for each(_loc2_ in this.localeStruct.images)
         {
            _loc1_.push(_loc2_.value);
         }
         this.batchImageConstructor = new BatchImageConstructor();
         this.batchImageConstructor.addEventListener(Event.COMPLETE,this.onImagesComplete);
         this.batchImageConstructor.buildImages(_loc1_,5);
      }
      
      private function onImagesComplete(param1:Event) : void
      {
         var _loc2_:Vector.<BitmapData> = this.batchImageConstructor.images;
         this.batchImageConstructor = null;
         var _loc3_:Vector.<ImagePair> = this.localeStruct.images;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            this.localeService.setImage(_loc3_[_loc4_].key,_loc2_[_loc4_]);
            _loc4_++;
         }
      }
   }
}

