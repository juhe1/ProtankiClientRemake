package alternativa.startup
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class CacheLoader extends Loader
   {
       
      
      private var encodedUrl:String;
      
      private var cacheDirectory:Object;
      
      private var context:LoaderContext;
      
      private var cached:Boolean;
      
      private var FileClass:Class;
      
      private var FileStreamClass:Class;
      
      private var FileModeClass:Class;
      
      public function CacheLoader()
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
      
      override public function load(request:URLRequest, context:LoaderContext = null) : void
      {
         if(!StartupSettings.isDesktop)
         {
            super.load(request,context);
            return;
         }
         var urlRequest:URLRequest = request;
         this.context = context;
         this.encodedUrl = URLEncoder.encode(request.url);
         var cachedFile:* = this.cacheDirectory.resolvePath(this.encodedUrl);
         if(Boolean(cachedFile.exists))
         {
            urlRequest = new URLRequest(cachedFile.nativePath);
            this.cached = true;
         }
         var urlLoader:URLLoader = new URLLoader();
         urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         urlLoader.addEventListener(Event.COMPLETE,this.onBytesLoaded,false,0,true);
         urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError,false,0,true);
         urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError,false,0,true);
         urlLoader.load(urlRequest);
      }
      
      private function onIOError(e:Event) : void
      {
         dispatchEvent(new IOErrorEvent("CacheLoader: IOError!"));
      }
      
      private function onSecurityError(e:Event) : void
      {
         dispatchEvent(new SecurityErrorEvent("CacheLoader: Security error!"));
      }
      
      private function onBytesLoaded(e:Event) : void
      {
         var file:Object = null;
         var fileStream:Object = null;
         var bytes:ByteArray = URLLoader(e.target).data as ByteArray;
         if(!this.cached)
         {
            file = new this.FileClass(this.cacheDirectory.resolvePath(this.encodedUrl).nativePath);
            fileStream = new this.FileStreamClass();
            try
            {
               fileStream.open(file,this.FileModeClass.WRITE);
               fileStream.writeBytes(URLLoader(e.target).data as ByteArray);
               fileStream.close();
            }
            catch(e:Error)
            {
               dispatchEvent(new IOErrorEvent("CacheLoader error! " + e.message + "url: " + encodedUrl));
            }
         }
         super.loadBytes(bytes,this.context);
      }
   }
}
