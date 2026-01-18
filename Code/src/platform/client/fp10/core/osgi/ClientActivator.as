package platform.client.fp10.core.osgi
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.protocol.IProtocol;
   import flash.utils.setTimeout;
   import platform.client.fp10.core.network.connection.IConnection;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.registry.impl.GameTypeRegistryImpl;
   import platform.client.fp10.core.registry.impl.ModelsRegistryImpl;
   import platform.client.fp10.core.registry.impl.ResourceRegistryImpl;
   import platform.client.fp10.core.registry.impl.SpaceRegistryImpl;
   import platform.client.fp10.core.resource.IResourceLoader;
   import platform.client.fp10.core.resource.IResourceLocalStorageInternal;
   import platform.client.fp10.core.resource.ResourceLoader;
   import platform.client.fp10.core.resource.ResourceLocalStorage;
   import platform.client.fp10.core.resource.ResourceTimer;
   import platform.client.fp10.core.resource.ResourceType;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.resource.types.LocalizedImageResource;
   import platform.client.fp10.core.resource.types.SWFLibraryResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.service.IResourceTimer;
   import platform.client.fp10.core.service.address.AddressService;
   import platform.client.fp10.core.service.address.impl.AddressServiceFakeImpl;
   import platform.client.fp10.core.service.address.impl.AddressServiceImpl;
   import platform.client.fp10.core.service.errormessage.IErrorMessageService;
   import platform.client.fp10.core.service.errormessage.impl.MessageBoxService;
   import platform.client.fp10.core.service.loadingprogress.ILoadingProgressService;
   import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.CoreCommands;
   
   public class ClientActivator implements IBundleActivator
   {
      
      private var osgi:OSGi;
      
      private var controlChannelConnection:IConnection;
      
      public function ClientActivator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         this.osgi = param1;
         this.registerCodecs();
         this.registerServices();
         this.registerResources();
         setTimeout(this.completeInitialization,0);
      }
      
      public function stop(param1:OSGi) : void
      {
      }
      
      private function registerCodecs() : void
      {
         var _loc1_:IProtocol = IProtocol(this.osgi.getService(IProtocol));
      }

      private function registerServices() : void
      {
         this.osgi.registerService(GameTypeRegistry,new GameTypeRegistryImpl());
         this.osgi.registerService(SpaceRegistry,new SpaceRegistryImpl());
         this.osgi.registerService(ModelRegistry,new ModelsRegistryImpl(this.osgi));
         this.osgi.registerServiceMulti([IResourceLocalStorage,IResourceLocalStorageInternal],new ResourceLocalStorage(this.osgi));
         this.osgi.registerService(IResourceLoader,new ResourceLoader(this.osgi));
         this.osgi.registerServiceMulti([ResourceRegistry,ILoadingProgressService],new ResourceRegistryImpl(this.osgi));
         this.osgi.registerService(IErrorMessageService,new MessageBoxService(this.osgi));
         var _loc1_:ILauncherParams = ILauncherParams(this.osgi.getService(ILauncherParams));
         this.osgi.registerService(AddressService,Boolean(_loc1_.getParameter("noswfaddress")) ? new AddressServiceFakeImpl() : new AddressServiceImpl());
         this.osgi.registerService(IResourceTimer,new ResourceTimer(this.osgi));
      }
      
      private function registerResources() : void
      {
         var _loc1_:ResourceRegistry = ResourceRegistry(this.osgi.getService(ResourceRegistry));
         _loc1_.registerTypeClasses(ResourceType.SWF_LIBRARY,SWFLibraryResource);
         _loc1_.registerTypeClasses(ResourceType.IMAGE,ImageResource);
         _loc1_.registerTypeClasses(ResourceType.LOCALIZED_IMAGE,LocalizedImageResource);
         _loc1_.registerTypeClasses(ResourceType.MULTIFRAME_IMAGE,MultiframeImageResource);
         _loc1_.registerTypeClasses(ResourceType.SOUND,SoundResource);
      }

      private function completeInitialization() : void
      {
         this.registerCommmands();
      }

      private function registerCommmands() : void
      {
         new CoreCommands();
      }
   }
}

