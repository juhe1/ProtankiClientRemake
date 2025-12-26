package
{
   import scpacker.networking.Connector;
   import alternativa.types.Long;
   import alternativa.ClientConfigurator;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.osgi.service.locale.LocaleService;
   import alternativa.startup.ConnectionParameters;
   import alternativa.startup.StartupSettings;
   import alternativa.tanks.loader.ILoaderWindowService;
   import scpacker.utils.LocalizationLoader;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import scpacker.utils.CoreUtils;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.type.impl.Space;
   import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
   import alternativa.osgi.service.launcherparams.LauncherParams;
   import scpacker.networking.Network;
   
   public class Game extends Sprite
   {
      private var container:DisplayObjectContainer;
      
      public function Game()
      {
         super();
         if(numChildren > 1)
         {
            removeChildAt(0);
            removeChildAt(0);
         }
      }
      
      public function activateAllModels(param1:LoaderInfo) : void
      {
         new ClientConfigurator().start(this.container,new LauncherParams(),new ConnectionParameters(param1.parameters["ip"],new <int>[param1.parameters["port"]],param1.parameters["resources"]),param1);
         var _loc2_:ILocaleService = new LocaleService(param1.parameters["lang"],"en");
         OSGi.getInstance().registerService(ILocaleService,_loc2_);
         new LocalizationLoader().load(param1.parameters["resources"] + "/localized.data_" + _loc2_.language,this.activate);
      }
      
      private function activate() : void
      {
         var _loc1_:OSGi = OSGi.getInstance();
         new EntranceActivator().start(_loc1_);
         ILoaderWindowService(_loc1_.getService(ILoaderWindowService)).show();
         //new GameActivator().start(_loc1_);
         StartupSettings.preLauncher = Sprite(parent.parent.parent);
         this.b629458b();
         CoreUtils.init();
         var _loc2_:GPUCapabilities = new GPUCapabilities(IDisplay(_loc1_.getService(IDisplay)).stage,loaderInfo.parameters["gpuEnabled"],loaderInfo.parameters["constrained"]);
         _loc2_.addEventListener("complete",this.connectToServer,false,0,true);
         _loc2_.detect();
      }
      
      public function SUPER(param1:Stage, param2:DisplayObjectContainer, param3:LoaderInfo = null) : void
      {
         this.container = param2;
         param1.dispatchEvent(new Event("EntranceModel.objectLoaded",true));
         OSGi.getInstance().registerService(Network,new Network());
         this.activateAllModels(param3);
      }
      
      private function connectToServer() : void
      {
         new Connector().connectToServer();
      }
      
      private function b629458b() : void
      {
         var _loc1_:SpaceRegistry = SpaceRegistry(OSGi.getInstance().getService(SpaceRegistry));
         _loc1_.addSpace(new Space(Long.getLong(10568210,51255591),null,null,false));
         _loc1_.addSpace(new Space(Long.getLong(52835823,6349643),null,null,false));
         _loc1_.addSpace(new Space(Long.getLong(59235923,646943),null,null,false));
         _loc1_.addSpace(new Space(Long.getLong(884380667,214),null,null,false));
      }
   }
}

