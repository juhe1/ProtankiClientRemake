package alternativa.tanks.models.battle.gui.drone
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.events.TankActivationEvent;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.battle.events.TankUnloadedEvent;
   import alternativa.tanks.battle.events.death.TankDeadEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
   import alternativa.tanks.models.battle.gui.inventory.InventoryItem;
   import alternativa.tanks.models.drones.Drone;
   import alternativa.tanks.models.inventory.IInventoryModel;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.inventory.InventoryLock;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.TankSet;
   import alternativa.tanks.models.tank.configuration.TankConfiguration;
   import alternativa.tanks.models.tank.event.TankEntityCreationListener;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.sfx.drone.DroneSFX;
   import alternativa.tanks.sfx.drone.DroneSFXData;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battlefield.models.drone.DroneIndicatorCC;
   import projects.tanks.client.battlefield.models.drone.DroneIndicatorModelBase;
   import projects.tanks.client.battlefield.models.drone.IDroneIndicatorModelBase;
   import projects.tanks.client.battlefield.models.user.tank.TankLogicState;
   import projects.tanks.clients.flash.commons.models.coloring.IColoring;
   import projects.tanks.clients.flash.resources.object3ds.IObject3DS;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedService;
   
   [ModelInfo]
   public class DroneIndicatorModel extends DroneIndicatorModelBase implements IDroneIndicatorModelBase, IDroneModel, TankEntityCreationListener, BattleEventListener, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject] // added
      public static var inventoryPanel:IInventoryPanel;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      [Inject] // added
      public static var settingsService:ISettingsService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject] // added
      public static var settingsChangedService:UserSettingsChangedService;
      
      private var localTank:Tank;
      
      private var droneIndicatorItem:InventoryItem;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var drones:Dictionary = new Dictionary();
      
      public function DroneIndicatorModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankActivationEvent,this.onTankActivation);
         this.battleEventSupport.addEventHandler(TankDeadEvent,this.onTankDeactivation);
         this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoad);
         this.battleEventSupport.activateHandlers();
      }
      
      public function onTankEntityCreated(param1:Tank, param2:Boolean, param3:TankLogicState) : void
      {
         var _loc4_:DroneIndicatorCC = this.getSavedState();
         if(_loc4_ == null)
         {
            putData(DroneIndicatorCC,getInitParam());
         }
         this.initDrones(param1,param2,param3);
         this.getSavedState().timeToReloadMs = 0;
         if(param2)
         {
            this.localTank = param1;
            this.updateBatteryIndicator();
         }
      }
      
      private function updateBatteryIndicator() : void
      {
         inventoryPanel.setVisible(InventoryItemType.BATTERY,this.hasDrone(),false);
      }
      
      public function initDrones(param1:Tank, param2:Boolean, param3:TankLogicState) : void
      {
         var _loc4_:DroneIndicatorCC = null;
         var _loc5_:IInventoryModel = null;
         if(this.hasDrone())
         {
            _loc4_ = DroneIndicatorCC(getData(DroneIndicatorCC));
            if(param2)
            {
               this.droneIndicatorItem = new InventoryItem(null,InventoryItemType.BATTERY,_loc4_.batteryAmount,null);
               inventoryPanel.assignItemToSlot(this.droneIndicatorItem,InventoryItemType.BATTERY);
               if(_loc4_.timeToReloadMs != 0)
               {
                  inventoryPanel.activateCooldown(InventoryItemType.BATTERY,_loc4_.timeToReloadMs);
               }
               _loc5_ = IInventoryModel(battleService.getBattle().adapt(IInventoryModel));
               _loc5_.lockItem(InventoryItemType.BATTERY,InventoryLock.FORCED,!_loc4_.droneReady);
            }
            this.initDrone(param1,param2);
            this.setCooldownState(param1,_loc4_.timeToReloadMs);
            this.setDroneState(param1,_loc4_.droneReady);
            if(!param2)
            {
               this.onTankActiveStateChanged(param1,param3 == TankLogicState.ACTIVE);
            }
         }
      }
      
      public function ready() : void
      {
         this.setDroneReadiness(true);
      }
      
      public function notReady() : void
      {
         this.setDroneReadiness(false);
      }
      
      public function reload(param1:int) : void
      {
         var _loc2_:Tank = object.adapt(ITankModel).getTank();
         this.cooldown(_loc2_,param1);
         if(_loc2_ == this.localTank)
         {
            inventoryPanel.activateCooldown(InventoryItemType.BATTERY,param1);
         }
      }
      
      public function setDroneReadiness(param1:Boolean) : void
      {
         var _loc3_:IInventoryModel = null;
         var _loc2_:Tank = object.adapt(ITankModel).getTank();
         this.setDroneState(_loc2_,param1);
         this.getSavedState().droneReady = param1;
         if(_loc2_ == this.localTank)
         {
            inventoryPanel.setVisible(InventoryItemType.BATTERY,this.hasDrone(),false);
            _loc3_ = IInventoryModel(battleService.getBattle().adapt(IInventoryModel));
            _loc3_.lockItem(InventoryItemType.BATTERY,InventoryLock.FORCED,!param1);
         }
      }
      
      public function setBatteriesAmount(param1:int) : void
      {
         this.droneIndicatorItem.count = param1;
         this.getSavedState().batteryAmount = param1;
         inventoryPanel.itemUpdateCount(this.droneIndicatorItem);
      }
      
      private function initDrone(param1:Tank, param2:Boolean) : void
      {
         var _loc3_:TankConfiguration = TankConfiguration(param1.user.adapt(TankConfiguration));
         var _loc4_:TankSet = ITankModel(object.adapt(ITankModel)).getTankSet();
         var _loc5_:Tanks3DSResource = IObject3DS(_loc4_.drone.adapt(IObject3DS)).getResource3DS();
         var _loc6_:DroneSFXData = DroneSFX(_loc4_.drone.adapt(DroneSFX)).getSfxData();
         var _loc7_:IColoring = IColoring(_loc3_.getColoringObject().adapt(IColoring));
         this.drones[param1] = new Drone(param1,param2,battleService,_loc5_,settingsService,textureMaterialRegistry,_loc7_,_loc6_);
      }
      
      private function cooldown(param1:Tank, param2:int) : void
      {
         var _loc3_:Drone = this.drones[param1];
         if(_loc3_ != null)
         {
            _loc3_.cooldown(param2);
         }
      }
      
      private function setDroneState(param1:Tank, param2:Boolean) : void
      {
         var _loc3_:Drone = this.drones[param1];
         if(_loc3_ != null)
         {
            _loc3_.setState(param2);
         }
      }
      
      private function setCooldownState(param1:Tank, param2:int) : void
      {
         var _loc3_:Drone = this.drones[param1];
         if(_loc3_ != null)
         {
            _loc3_.setInitialCooldownState(param2);
         }
      }
      
      private function hasDrone() : Boolean
      {
         return ITankModel(object.adapt(ITankModel)).getTankSet().drone != null;
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      private function onTankActivation(param1:TankActivationEvent) : void
      {
         this.onTankActiveStateChanged(param1.tank,true);
      }
      
      private function onTankDeactivation(param1:TankDeadEvent) : void
      {
         this.onTankActiveStateChanged(ITankModel(param1.victim.adapt(ITankModel)).getTank(),false);
      }
      
      private function onBattleFinish(param1:BattleFinishEvent) : void
      {
         var _loc2_:Drone = null;
         for each(_loc2_ in this.drones)
         {
            _loc2_.onTankActiveStateChanged(false);
         }
      }
      
      private function onTankActiveStateChanged(param1:Tank, param2:Boolean) : void
      {
         var _loc3_:Drone = this.drones[param1];
         if(_loc3_ != null)
         {
            _loc3_.onTankActiveStateChanged(param2);
         }
      }
      
      private function onSettingsChanged(param1:UserSettingsChangedEvent) : void
      {
         var _loc2_:Drone = null;
         for each(_loc2_ in this.drones)
         {
            _loc2_.updateGameSettings();
         }
      }
      
      public function objectLoaded() : void
      {
         settingsChangedService.addEventListener(UserSettingsChangedEvent.TYPE,this.onSettingsChanged);
      }
      
      public function objectUnloaded() : void
      {
         settingsChangedService.removeEventListener(UserSettingsChangedEvent.TYPE,this.onSettingsChanged);
         this.destroy();
      }
      
      private function destroy() : void
      {
         var _loc1_:Tank = ITankModel(object.adapt(ITankModel)).getTank();
         this.destroyDroneForTank(_loc1_);
      }
      
      private function destroyDroneForTank(param1:Tank) : void
      {
         var _loc2_:Drone = this.drones[param1];
         if(_loc2_ != null)
         {
            if(Boolean(_loc2_.getCurrentRenderer()))
            {
               _loc2_.getCurrentRenderer().stop();
            }
            _loc2_.destroy();
         }
         delete this.drones[param1];
      }
      
      private function getSavedState() : DroneIndicatorCC
      {
         return DroneIndicatorCC(getData(DroneIndicatorCC));
      }
      
      private function onTankLoad(param1:TankLoadedEvent) : void
      {
         if(param1.isLocal)
         {
            this.localTank = param1.tank;
            this.updateBatteryIndicator();
         }
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         //delete global[this.destroyDroneForTank(param1.tank)];
      }
      
      public function canOverheal() : Boolean
      {
         return getInitParam().canOverheal;
      }
   }
}

