package alternativa.init
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventDispatcherImpl;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.objects.tank.skintexturesregistry.DefaultTankSkinTextureRegistry;
   import alternativa.tanks.battle.objects.tank.skintexturesregistry.TankSkinTextureRegistry;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkinTextureRegistryCleaner;
   import alternativa.tanks.engine3d.ColorCorrectedTextureRegistry;
   import alternativa.tanks.engine3d.DefaultColorCorrectedTextureRegistry;
   import alternativa.tanks.engine3d.DefaultEffectsMaterialRegistry;
   import alternativa.tanks.engine3d.DefaultTextureMaterialFactory;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.MutableTextureMaterialRegistry;
   import alternativa.tanks.engine3d.MutableTextureRegistryCleaner;
   import alternativa.tanks.engine3d.TextureMaterialRegistryCleaner;
   import alternativa.tanks.models.battle.battlefield.BattleUnloadEvent;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.tanks.services.battlegui.BattleGUIServiceImpl;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import alternativa.tanks.services.battleinput.BattleInputServiceImpl;
   import alternativa.tanks.services.battlereadiness.BattleReadinessService;
   import alternativa.tanks.services.battlereadiness.BattleReadinessServiceImpl;
   import alternativa.tanks.services.bonusregion.BonusRegionService;
   import alternativa.tanks.services.bonusregion.IBonusRegionService;
   import alternativa.tanks.services.colortransform.ColorTransformService;
   import alternativa.tanks.services.colortransform.impl.HardwareColorTransformService;
   import alternativa.tanks.services.colortransform.impl.SoftwareColorTransformService;
   import alternativa.tanks.services.initialeffects.IInitialEffectsService;
   import alternativa.tanks.services.initialeffects.InitialEffectsService;
   import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
   import alternativa.tanks.services.lightingeffects.LightingEffectsService;
   import alternativa.tanks.services.mipmapping.MipMappingService;
   import alternativa.tanks.services.mipmapping.impl.DefaultMipMappingService;
   import alternativa.tanks.services.ping.PingService;
   import alternativa.tanks.services.ping.PingServiceImpl;
   import alternativa.tanks.services.spectatorservice.SpectatorService;
   import alternativa.tanks.services.spectatorservice.SpectatorServiceImpl;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import alternativa.tanks.services.tankregistry.TankUsersRegistryServiceImpl;
   import alternativa.tanks.services.targeting.TargetingInputManager;
   import alternativa.tanks.services.targeting.TargetingInputManagerImpl;
   import alternativa.tanks.services.targeting.TargetingModeService;
   import alternativa.tanks.services.targeting.TargetingModeServiceImpl;
   import alternativa.tanks.utils.DataValidator;
   import alternativa.tanks.utils.DataValidatorImpl;
   import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
   import alternativa.utils.TextureMaterialRegistry;
   import alternativa.osgi.service.command.CommandService;
   import alternativa.tanks.engine3d.TextureMaterialRegistryBase;
   import alternativa.osgi.service.command.FormattedOutput;
   import alternativa.tanks.services.memoryleakguard.MemoryLeakTrackerService;
   import alternativa.tanks.services.performance.PerformanceDataServiceImpl;
   import alternativa.tanks.services.performance.PerformanceDataService;
   
   [Obfuscation(rename="false")]
   public class BattlefieldModelActivator implements IBundleActivator
   {
      
      private var osgi:OSGi;
      
      public function BattlefieldModelActivator()
      {
         super();
      }
      
      private static function bytesToMegabytes(param1:Number) : int
      {
         return param1 / (1024 * 1024);
      }
      
      [Obfuscation(rename="false")]
      public function start(param1:OSGi) : void
      {
         this.osgi = param1;
         param1.registerService(MemoryLeakTrackerService,new MemoryLeakTrackerService(param1));
         param1.registerService(IInitialEffectsService,new InitialEffectsService());
         var _loc2_:BattleEventDispatcher = new BattleEventDispatcherImpl();
         param1.registerService(BattleEventDispatcher,_loc2_);
         param1.registerService(BattleReadinessService,new BattleReadinessServiceImpl());
         param1.registerService(BattleInputService,new BattleInputServiceImpl());
         param1.registerService(SpectatorService,new SpectatorServiceImpl());
         param1.registerService(BattleGUIService,new BattleGUIServiceImpl());
         param1.registerService(PingService,new PingServiceImpl());
         param1.registerService(PerformanceDataService,new PerformanceDataServiceImpl());
         param1.registerService(TankUsersRegistry,new TankUsersRegistryServiceImpl());
         param1.registerService(IBonusRegionService,new BonusRegionService(_loc2_));
         param1.registerService(ILightingEffectsService,new LightingEffectsService());
         param1.registerService(TargetingInputManager,new TargetingInputManagerImpl());
         param1.registerService(TargetingModeService,new TargetingModeServiceImpl());
         this.registerMipMappingService();
         this.registerColorTransformService();
         this.registerEffectsMaterialService();
         this.registerColorCorrectedTextureService();
         this.registerTextureMaterialService();
         this.registerTankSkinTextureService();
         param1.registerService(DataValidator,new DataValidatorImpl(param1));
      }
      
      private function registerMipMappingService() : void
      {
         this.osgi.registerService(MipMappingService,new DefaultMipMappingService());
      }
      
      private function registerColorTransformService() : void
      {
         if(!GPUCapabilities.gpuEnabled || Boolean(GPUCapabilities.constrained))
         {
            this.osgi.registerService(ColorTransformService,new SoftwareColorTransformService());
         }
         else
         {
            this.osgi.registerService(ColorTransformService,new HardwareColorTransformService());
         }
      }
      
      private function registerEffectsMaterialService() : void
      {
         var _loc1_:DefaultEffectsMaterialRegistry = new DefaultEffectsMaterialRegistry();
         this.osgi.registerService(EffectsMaterialRegistry,_loc1_);
         this.enableMipMappingControl(_loc1_);
         this.registerBattleEventListener(BattleUnloadEvent,new TextureMaterialRegistryCleaner(_loc1_));
      }
      
      private function _showMaterialRegistryStat(param1:TextureMaterialRegistryBase) : Function
      {
         var materialRegistry:TextureMaterialRegistryBase = param1;
         return function(param1:FormattedOutput):void
         {
         };
      }
      
      private function getCommandService() : CommandService
      {
         return CommandService(this.osgi.getService(CommandService));
      }
      
      private function registerColorCorrectedTextureService() : void
      {
         var _loc1_:ColorCorrectedTextureRegistry = new DefaultColorCorrectedTextureRegistry();
         this.osgi.registerService(ColorCorrectedTextureRegistry,_loc1_);
         this.registerBattleEventListener(BattleUnloadEvent,new MutableTextureRegistryCleaner(_loc1_));
         var _loc2_:ColorTransformService = ColorTransformService(this.osgi.getService(ColorTransformService));
         _loc2_.addColorTransformer(_loc1_);
      }
      
      private function registerTextureMaterialService() : void
      {
         var _loc1_:ColorCorrectedTextureRegistry = ColorCorrectedTextureRegistry(this.osgi.getService(ColorCorrectedTextureRegistry));
         var _loc2_:MutableTextureMaterialRegistry = new MutableTextureMaterialRegistry(new DefaultTextureMaterialFactory(),_loc1_);
         this.osgi.registerService(TextureMaterialRegistry,_loc2_);
         this.enableMipMappingControl(_loc2_);
         this.registerBattleEventListener(BattleUnloadEvent,new TextureMaterialRegistryCleaner(_loc2_));
      }
      
      private function registerTankSkinTextureService() : void
      {
         var _loc1_:TankSkinTextureRegistry = new DefaultTankSkinTextureRegistry();
         this.osgi.registerService(TankSkinTextureRegistry,_loc1_);
         this.registerBattleEventListener(BattleUnloadEvent,new TankSkinTextureRegistryCleaner(_loc1_));
      }
      
      private function registerBattleEventListener(param1:Class, param2:BattleEventListener) : void
      {
         var _loc3_:BattleEventDispatcher = BattleEventDispatcher(this.osgi.getService(BattleEventDispatcher));
         _loc3_.addBattleEventListener(param1,param2);
      }
      
      private function enableMipMappingControl(param1:TextureMaterialRegistry) : void
      {
         var _loc2_:MipMappingService = MipMappingService(this.osgi.getService(MipMappingService));
         _loc2_.addMaterialRegistry(param1);
      }
      
      private function traceMemory() : void
      {
      }
      
      [Obfuscation(rename="false")]
      public function stop(param1:OSGi) : void
      {
      }
   }
}

