package platform.client.fp10.core.resource.types
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.BundleDescriptor;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.startup.StartupSettings;
   import alternativa.utils.Properties;
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.logging.serverlog.UncaughtErrorServerLog;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.registry.impl.ResourceRegistryImpl;
   import platform.client.fp10.core.resource.ILockableResource;
   import platform.client.fp10.core.resource.IResourceLoadingListener;
   import platform.client.fp10.core.resource.IResourceSerializationListener;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.ResourceFlags;
   import platform.client.fp10.core.resource.ResourceInfo;
   import platform.client.fp10.core.resource.ResourceStatus;
   import platform.client.fp10.core.resource.SafeURLLoader;
   import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
   
   public class SWFLibraryResource extends Resource implements ILockableResource
   {
      
      [Inject] // added
      public static var launcherParams:ILauncherParams;
      
      [Inject] // added
      public static var resourceLocalStorage:IResourceLocalStorage;
      
      [Inject] // added
      public static var resourceRegistry:ResourceRegistry;
      
      [Inject] // added
      public static var uncaughtErrorServerLog:UncaughtErrorServerLog;
      
      private static const BASE_FILE_NAME:String = "library";
      
      private static const BASE_FILE_NAME_DEBUG:String = "debug";
      
      private var urlLoader:SafeURLLoader;
      
      private var bytesLoader:Loader;
      
      private var resourceRegistryImpl:ResourceRegistryImpl;
      
      private var manifestParams:Properties;
      
      private var data:ByteArray;
      
      public function SWFLibraryResource(param1:ResourceInfo)
      {
         super(param1);
         this.resourceRegistryImpl = resourceRegistry as ResourceRegistryImpl;
      }
      
      override public function get description() : String
      {
         return "Library";
      }
      
      override public function get classifier() : String
      {
         if(launcherParams.isDebug)
         {
            return "-d";
         }
         return "-r";
      }
      
      override public function load(param1:String, param2:IResourceLoadingListener) : void
      {
         super.load(param1,param2);
         this.loadSwf();
      }
      
      protected function loadSwf() : void
      {
         var _loc1_:String = baseUrl + this.getFileName() + getReloadURLPostfix();
         this.urlLoader = new SafeURLLoader();
         this.urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         this.urlLoader.addEventListener(Event.OPEN,this.onLoadingOpen);
         this.urlLoader.addEventListener(ProgressEvent.PROGRESS,this.onLoadingProgress);
         this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
         this.urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
         this.urlLoader.addEventListener(Event.COMPLETE,this.onSwfLoadingComplete);
         this.urlLoader.load(new URLRequest(_loc1_));
         status = ResourceStatus.REQUESTED;
         startTimeoutTracking();
      }
      
      override public function loadBytes(param1:ByteArray, param2:IResourceLoadingListener) : Boolean
      {
         this.listener = param2;
         this.loadLibraryBytes(param1);
         return true;
      }
      
      override public function serialize(param1:IResourceSerializationListener) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(this.data);
         param1.onSerializationComplete(this,_loc2_);
         this.data = null;
      }
      
      override protected function doReload() : void
      {
         this.urlLoader.close();
         this.loadSwf();
      }
      
      override protected function completeLoading() : void
      {
         super.completeLoading();
         if(hasAllFlags(ResourceFlags.LOCAL) || !resourceLocalStorage.enabled)
         {
            this.data = null;
         }
      }
      
      private function getFileName() : String
      {
         var _loc1_:String = ".bin";
         if(launcherParams.isDebug)
         {
            return BASE_FILE_NAME_DEBUG + _loc1_;
         }
         return BASE_FILE_NAME + _loc1_;
      }
      
      private function onLoadingOpen(param1:Event) : void
      {
         updateLastActivityTime();
         listener.onResourceLoadingStart(this);
      }
      
      private function onSwfLoadingComplete(param1:Event) : void
      {
         stopTimeoutTracking();
         this.data = this.urlLoader.data;
         this.parseManifest();
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(this.data,this.data.position,this.data.bytesAvailable);
         this.urlLoader = null;
         this.loadLibraryBytes(_loc2_);
      }
      
      private function parseManifest() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc1_:String = this.data.readUTF();
         this.manifestParams = new Properties();
         if(_loc1_.length > 0)
         {
            _loc2_ = _loc1_.split(/[=&]/);
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               this.manifestParams.setProperty(_loc2_[_loc3_],_loc2_[_loc3_ + 1]);
               _loc3_ += 2;
            }
         }
      }
      
      private function loadLibraryBytes(param1:ByteArray) : void
      {
         this.bytesLoader = new Loader();
         uncaughtErrorServerLog.addLoader(this.bytesLoader);
         this.bytesLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onBytesLoaded);
         var _loc2_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         if(StartupSettings.isDesktop)
         {
            _loc2_.allowCodeImport = true;
         }
         this.bytesLoader.loadBytes(param1,_loc2_);
      }
      
      private function onBytesLoaded(param1:Event) : void
      {
         var event:Event = param1;
         try
         {
            this.installLibrary();
            if(!this.resourceRegistryImpl.isLocked())
            {
               this.completeLoading();
            }
            else
            {
               this.resourceRegistryImpl.addLockedResource(this);
            }
         }
         catch(e:Error)
         {
            listener.onResourceLoadingFatalError(this,e.getStackTrace() + ", message=" + e.message);
         }
      }
      
      private function installLibrary() : void
      {
         OSGi.getInstance().installBundle(new BundleDescriptor(this.manifestParams));
      }
      
      private function onLoadingProgress(param1:ProgressEvent) : void
      {
         updateLastActivityTime();
      }
      
      protected function onLoadingError(param1:ErrorEvent) : void
      {
         stopTimeoutTracking();
         reload();
      }
      
      public function unlockResourceLoading() : void
      {
         this.completeLoading();
      }
      
      override public function toString() : String
      {
         var _loc1_:String = null;
         if(this.manifestParams != null)
         {
            _loc1_ = this.manifestParams.getProperty("Bundle-Name");
         }
         return "[" + super.toString() + ", name = " + _loc1_ + "]";
      }
   }
}

