package alternativa.startup
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundLoaderContext;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class SoundCacheLoader extends Sound
   {
       
      
      private var encodedUrl:String;
      
      private var cacheDirectory:Object;
      
      private var context:SoundLoaderContext;
      
      private var FileClass:Class;
      
      private var FileStreamClass:Class;
      
      private var FileModeClass:Class;
      
      public function SoundCacheLoader()
      {
         super();
         if(StartupSettings.isDesktop)
         {
            this.FileClass = getDefinitionByName("flash.filesystem.File") as Class;
            this.FileStreamClass = getDefinitionByName("flash.filesystem.FileStream") as Class;
            this.FileModeClass = getDefinitionByName("flash.filesystem.FileMode") as Class;
            this.cacheDirectory = this.FileClass.applicationStorageDirectory.resolvePath("cache");
            if(!this.cacheDirectory.exists)
            {
               this.cacheDirectory.createDirectory();
            }
            else if(!this.cacheDirectory.isDirectory)
            {
               throw new Error("Cannot create directory." + this.cacheDirectory.nativePath + " is already exists.");
            }
         }
      }
      
      override public function load(request:URLRequest, context:SoundLoaderContext = null) : void
      {
         if(!StartupSettings.isDesktop || request == null)
         {
            super.load(request,context);
            return;
         }
         this.context = context;
         this.encodedUrl = URLEncoder.encode(request.url);
         var cachedFile:Object = this.cacheDirectory.resolvePath(this.encodedUrl);
         if(Boolean(cachedFile.exists))
         {
            super.load(new URLRequest(cachedFile.url),context);
            return;
         }
         var urlLoader:URLLoader = new URLLoader();
         urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         urlLoader.addEventListener(Event.COMPLETE,this.onBytesLoaded,false,0,true);
         urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError,false,0,true);
         urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError,false,0,true);
         urlLoader.load(request);
      }
      
      private function onIOError(e:Event) : void
      {
         dispatchEvent(new IOErrorEvent("SoundCacheLoader: IOError!"));
      }
      
      private function onSecurityError(e:Event) : void
      {
         dispatchEvent(new SecurityErrorEvent("SoundCacheLoader: Security error!"));
      }
      
      private function onBytesLoaded(e:Event) : void
      {
         var bytes:ByteArray = URLLoader(e.target).data as ByteArray;
         var file:Object = new this.FileClass(this.cacheDirectory.resolvePath(this.encodedUrl).nativePath);
         var fileStream:Object = new this.FileStreamClass();
         try
         {
            fileStream.open(file,this.FileModeClass.WRITE);
            fileStream.writeBytes(bytes);
            fileStream.close();
         }
         catch(e:Error)
         {
            dispatchEvent(new IOErrorEvent("SoundCacheLoader error! " + e.message + "url: " + encodedUrl));
         }
         super.load(new URLRequest(file.url),this.context);
      }
   }
}
