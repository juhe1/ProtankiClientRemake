package alternativa.tanks.models.battle.statistics.fps
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.LocalTankActivationEvent;
   import alternativa.tanks.battle.events.LocalTankKilledEvent;
   import alternativa.tanks.battle.events.PauseActivationEvent;
   import alternativa.tanks.battle.events.PauseDeactivationEvent;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.service.settings.ISettingsService;
   import flash.events.Event;
   import flash.utils.getTimer;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battlefield.models.statistics.fps.FpsStatisticsModelBase;
   import projects.tanks.client.battlefield.models.statistics.fps.IFpsStatisticsModelBase;
   import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
   import projects.tanks.clients.flash.commons.services.layout.LobbyLayoutService;
   
   [ModelInfo]
   public class FpsStatisticsModel extends FpsStatisticsModelBase implements IFpsStatisticsModelBase, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var settingsService:ISettingsService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var lobbyLayoutService:LobbyLayoutService;
      
      private const HARDWARE_BIT:int = 1 << 0;
      
      private const CONSTRAINT_BIT:int = 1 << 1;
      
      private const AUTO_QUALITY_BIT:int = 1 << 3;
      
      private const DYNAMIC_SHADOWS_BIT:int = 1 << 4;
      
      private const DEEP_SHADOWS_BIT:int = 1 << 5;
      
      private const SHADOW_UNDER_TANK:int = 1 << 6;
      
      private const FOG_BIT:int = 1 << 7;
      
      private const SOFT_PARTICLES_BIT:int = 1 << 8;
      
      private const DUST_BIT:int = 1 << 9;
      
      private const ANTIALIASING_BIT:int = 1 << 10;
      
      private const DYNAMIC_LIGHTING_BIT:int = 1 << 11;
      
      private const SECOND:int = 1000;
      
      private const MINIMAL_DURATION:int = 10000;
      
      private var duration:int;
      
      private var settings:int;
      
      private var lastTime:int;
      
      private var numTicks:int;
      
      private var autoSettingFeatures:Vector.<CameraStatisticFeature>;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var isTankSpawned:Boolean;
      
      private var isPauseEnabled:Boolean;
      
      public function FpsStatisticsModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         display.stage.addEventListener(Event.ENTER_FRAME,getFunctionWrapper(this.onEnterFrame));
         this.autoSettingFeatures = new Vector.<CameraStatisticFeature>();
         this.autoSettingFeatures.push(new CameraStatisticFeature("shadowMapStrength",this.DYNAMIC_SHADOWS_BIT),new CameraStatisticFeature("ssaoStrength",this.DEEP_SHADOWS_BIT),new CameraStatisticFeature("shadowsStrength",this.SHADOW_UNDER_TANK),new CameraStatisticFeature("fogStrength",this.FOG_BIT),new CameraStatisticFeature("softTransparencyStrength",this.SOFT_PARTICLES_BIT),new CameraStatisticFeature("deferredLightingStrength",this.DYNAMIC_LIGHTING_BIT));
         this.addEventListeners();
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         display.stage.removeEventListener(Event.ENTER_FRAME,getFunctionWrapper(this.onEnterFrame));
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = getTimer();
         if(!this.isPauseEnabled && this.isTankSpawned && !this.isAutoQualityInProgress())
         {
            _loc3_ = this.getSettings();
            if(this.settings != _loc3_)
            {
               this.sendStatisticsToServer();
               this.duration = 0;
               this.numTicks = 0;
               this.settings = _loc3_;
            }
            this.duration += _loc2_ - this.lastTime;
            ++this.numTicks;
         }
         this.sendStatisticsToServer();
         this.lastTime = _loc2_;
      }
      
      private function isAutoQualityInProgress() : Boolean
      {
         var _loc1_:CameraStatisticFeature = null;
         for each(_loc1_ in this.autoSettingFeatures)
         {
            if(_loc1_.isTesting())
            {
               return true;
            }
         }
         return false;
      }
      
      private function sendStatisticsToServer() : void
      {
         if(this.duration < this.MINIMAL_DURATION)
         {
            return;
         }
         server.collectStatistics(this.numTicks,this.duration,this.getSettings());
         this.numTicks = 0;
         this.duration = 0;
      }
      
      private function getSettings() : int
      {
         var _loc2_:CameraStatisticFeature = null;
         var _loc3_:BattleScene3D = null;
         var _loc4_:GameCamera = null;
         var _loc1_:int = 0;
         if(GPUCapabilities.gpuEnabled)
         {
            _loc1_ |= this.HARDWARE_BIT;
         }
         if(GPUCapabilities.constrained)
         {
            _loc1_ |= this.CONSTRAINT_BIT;
         }
         for each(_loc2_ in this.autoSettingFeatures)
         {
            _loc1_ |= _loc2_.getMask();
         }
         _loc3_ = battleService.getBattleScene3D();
         _loc4_ = _loc3_.getCamera();
         if(_loc4_.view.antiAliasEnabled)
         {
            _loc1_ |= this.ANTIALIASING_BIT;
         }
         if(_loc4_.softTransparencyStrength == 1 && _loc3_.getDustEngine().enabled)
         {
            _loc1_ |= this.DUST_BIT;
         }
         if(settingsService.graphicsAutoQuality)
         {
            _loc1_ |= this.AUTO_QUALITY_BIT;
         }
         return _loc1_;
      }
      
      private function addEventListeners() : void
      {
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
         this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.localTankActivation);
         this.battleEventSupport.addEventHandler(LocalTankKilledEvent,this.localTankKilled);
         this.battleEventSupport.addEventHandler(PauseActivationEvent,this.onPauseStarted);
         this.battleEventSupport.addEventHandler(PauseDeactivationEvent,this.onPauseFinished);
         this.battleEventSupport.activateHandlers();
      }
      
      private function localTankActivation(param1:Object) : void
      {
         this.isTankSpawned = true;
      }
      
      private function localTankKilled(param1:Object) : void
      {
         this.isTankSpawned = false;
      }
      
      private function onPauseStarted(param1:Object) : void
      {
         this.isPauseEnabled = true;
      }
      
      private function onPauseFinished(param1:Object) : void
      {
         this.isPauseEnabled = false;
      }
   }
}

