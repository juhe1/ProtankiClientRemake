package alternativa.tanks.models.tank.ultimate
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.events.BattleRestartEvent;
   import alternativa.tanks.battle.events.EffectActivatedEvent;
   import alternativa.tanks.battle.events.EffectStoppedEvent;
   import alternativa.tanks.battle.events.LocalTankActivationEvent;
   import alternativa.tanks.battle.events.LocalTankKilledEvent;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
   import alternativa.tanks.models.battle.gui.ultimate.UltimateIndicator;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.models.tank.event.LocalTankLoadListener;
   import alternativa.tanks.models.tank.event.LocalTankUnloadListener;
   import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.TankSpawnListener;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.ultimate.common.IUltimateModelBase;
   import projects.tanks.client.battlefield.models.ultimate.common.UltimateModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class UltimateModel extends UltimateModelBase implements IUltimateModelBase, IUltimateModel, BattleEventListener, LocalTankLoadListener, LocalTankUnloadListener, ObjectLoadPostListener, ObjectUnloadListener, TankSpawnListener
   {
      
      [Inject] // added
      public static var inventorySoundService:InventorySoundService;
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var battleGuiService:BattleGUIService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject] // added
      public static var battleInputService:BattleInputService;
      
      [Inject] // added
      public static var localTankInfoService:LocalTankInfoService;
      
      [Inject] // added
      public static var tankUsersRegistry:TankUsersRegistry;
      
      [Inject] // added
      public static var keysBindingService:KeysBindingService;
      
      [Inject] // added
      public static var battleInfoService:IBattleInfoService;
      
      private static const CHARGE_TIME_PERIOD_MILLIS:int = 100;
      
      private static const FULL_CHARGE:int = 100;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var chargeTimer:Timer;
      
      private var chargePercentPerSecond:Number;
      
      private var chargeInPercent:Number = 0;
      
      private var localTankSpawned:Boolean;
      
      private var ultimateBlocked:Boolean = true;
      
      private var indicator:UltimateIndicator;
      
      private var activeUltimates:Dictionary = new Dictionary();
      
      public function UltimateModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.onLocalTankActivationEvent);
         this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
         this.battleEventSupport.addEventHandler(LocalTankKilledEvent,this.onLocalTankKilled);
         this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestarted);
      }
      
      public static function parseColorTransform(param1:String) : ColorTransform
      {
         if(param1 == null || param1.length != 6)
         {
            return null;
         }
         var _loc2_:Number = parseInt(param1.substr(0,2),16) / 255;
         var _loc3_:Number = parseInt(param1.substr(2,2),16) / 255;
         var _loc4_:Number = parseInt(param1.substr(4,2),16) / 255;
         return new ColorTransform(_loc2_,_loc3_,_loc4_);
      }
      
      public function updateCharge(param1:int) : void
      {
         if(!battleInfoService.isSpectatorMode() && object == localTankInfoService.getLocalTankObject())
         {
            this.setCharge(param1);
         }
      }
      
      private function onLocalTankActivationEvent(param1:Object) : void
      {
         this.markInventoryIndicatorDisabled(false);
         if(this.charged())
         {
            this.indicator.onCharged();
         }
      }
      
      private function onBattleFinish(param1:BattleFinishEvent) : void
      {
         this.resetCharge();
         this.markInventoryIndicatorDisabled(true);
      }
      
      private function onLocalTankKilled(param1:Object) : void
      {
         this.markInventoryIndicatorDisabled(true);
      }
      
      private function onBattleRestarted(param1:Object) : void
      {
         this.activeUltimates = new Dictionary();
         this.resetCharge();
         this.localTankSpawned = true;
      }
      
      private function markInventoryIndicatorDisabled(param1:Boolean) : void
      {
         this.ultimateBlocked = param1;
         this.indicator.markDisabled(param1);
      }
      
      private function addChargeTimer() : void
      {
         this.chargeTimer = new Timer(CHARGE_TIME_PERIOD_MILLIS);
         this.chargeTimer.addEventListener(TimerEvent.TIMER,getFunctionWrapper(this.onChargeTick));
         this.chargeTimer.start();
      }
      
      public function ultimateUsed(param1:IGameObject) : void
      {
         delete this.activeUltimates[param1];
         if(!battleInfoService.isSpectatorMode() && param1 == localTankInfoService.getLocalTankObject())
         {
            this.setCharge(0);
         }
         //battleEventDispatcher.dispatchEvent(new EffectStoppedEvent(param1.id,InventoryItemType.ULTIMATE));
      }
      
      private function onChargeTick(param1:TimerEvent) : void
      {
         if(Boolean(battleService.isBattleActive()) && this.localTankSpawned)
         {
            this.addCharge(this.chargePercentPerSecond / 10);
         }
      }
      
      private function removeChargeTimer() : void
      {
         this.chargeTimer.stop();
         this.chargeTimer.removeEventListener(TimerEvent.TIMER,getFunctionWrapper(this.onChargeTick));
         this.chargeTimer = null;
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:GameActionEnum = keysBindingService.getBindingAction(param1.keyCode);
         if(_loc2_ == GameActionEnum.ULTIMATE && !battleInputService.isInputLocked())
         {
            if(this.canActivate())
            {
               server.activateUltimate();
            }
            else
            {
               inventorySoundService.playNotReadySound();
            }
         }
      }
      
      private function canActivate() : Boolean
      {
         return !this.ultimateBlocked && this.charged() && this.isInActiveState();
      }
      
      private function isInActiveState() : Boolean
      {
         return ITankModel(object.adapt(ITankModel)).getTank().state == ClientTankState.ACTIVE;
      }
      
      private function charged() : Boolean
      {
         return this.chargeInPercent >= FULL_CHARGE;
      }
      
      public function resetCharge() : void
      {
         this.localTankSpawned = false;
         this.setCharge(0);
      }
      
      public function addCharge(param1:Number) : void
      {
         if(this.charged())
         {
            return;
         }
         var _loc2_:Number = this.chargeInPercent + param1;
         if(_loc2_ > 99)
         {
            _loc2_ = 99;
         }
         this.setCharge(_loc2_);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function showUltimateCharged() : void
      {
         this.activeUltimates[object] = true;
         if(!battleInfoService.isSpectatorMode() && object == localTankInfoService.getLocalTankObject())
         {
            this.setCharge(FULL_CHARGE);
            if(this.isInActiveState())
            {
               this.indicator.onCharged();
            }
         }
         this.showTitleIcon();
      }
      
      public function objectLoadedPost() : void
      {
         if(getInitParam().enabled && getInitParam().charged)
         {
            this.activeUltimates[object] = true;
            this.showTitleIcon();
         }
      }
      
      private function setCharge(param1:Number) : void
      {
         if(Boolean(localTankInfoService.isLocalTankLoaded()) && object == localTankInfoService.getLocalTankObject() && this.indicator != null)
         {
            this.chargeInPercent = param1;
            this.indicator.updateCharge(param1);
         }
      }
      
      public function objectUnloaded() : void
      {
         delete this.activeUltimates[object];
      }
      
      public function localTankLoaded(param1:Boolean) : void
      {
         if(getInitParam().enabled && !param1)
         {
            this.localTankSpawned = true;
            this.chargePercentPerSecond = getInitParam().chargePercentPerSecond;
            this.addChargeTimer();
            display.stage.addEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKeyDown));
         }
      }
      
      public function initIndicator() : void
      {
         if(Boolean(localTankInfoService.isLocalTankLoaded()) && object == localTankInfoService.getLocalTankObject())
         {
            if(this.indicator != null)
            {
               this.indicator.destroy();
            }
            this.indicator = new UltimateIndicator();
            this.setCharge(0);
            this.battleEventSupport.activateHandlers();
         }
      }
      
      public function localTankUnloaded(param1:Boolean) : void
      {
         if(getInitParam().enabled && !param1)
         {
            display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKeyDown));
            this.removeChargeTimer();
            this.battleEventSupport.deactivateHandlers();
            this.indicator.destroy();
            this.indicator = null;
         }
      }
      
      public function updateChargeRate(param1:Number) : void
      {
         this.chargePercentPerSecond = param1;
      }
      
      public function onTankSpawn() : void
      {
         if(getInitParam().enabled)
         {
            if(Boolean(this.activeUltimates[object]))
            {
               this.showTitleIcon();
            }
         }
      }
      
      private function showTitleIcon() : void
      {
         //battleEventDispatcher.dispatchEvent(new EffectActivatedEvent(object.id,InventoryItemType.ULTIMATE,int.MAX_VALUE));
      }
      
      public function isUltimateEnabled() : Boolean
      {
         return getInitParam().enabled;
      }
   }
}

