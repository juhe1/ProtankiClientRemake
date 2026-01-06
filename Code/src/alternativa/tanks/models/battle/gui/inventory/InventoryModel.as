package alternativa.tanks.models.battle.gui.inventory
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.events.EffectActivatedEvent;
   import alternativa.tanks.battle.events.EffectStoppedEvent;
   import alternativa.tanks.battle.events.InventorySlotReadyToUseEvent;
   import alternativa.tanks.battle.events.LocalTankActivationEvent;
   import alternativa.tanks.battle.events.LocalTankKilledEvent;
   import alternativa.tanks.models.inventory.IInventoryModel;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.inventory.InventoryLock;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.tanks.services.battlegui.BattleGUIServiceEvent;
   import alternativa.tanks.services.battleinput.BattleInputLockEvent;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import alternativa.tanks.utils.KeyboardKeyLocker;
   import controls.InventoryIcon;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.registry.ModelRegistry;
   import projects.tanks.client.battlefield.models.battle.gui.inventory.IInventoryModelBase;
   import projects.tanks.client.battlefield.models.battle.gui.inventory.InventoryModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class InventoryModel extends InventoryModelBase implements IInventoryModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, IInventoryPanel, IInventoryModel, BattleEventListener
   {
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var battleInputService:BattleInputService;
      
      [Inject]
      public static var battleGuiService:BattleGUIService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      [Inject]
      public static var keysBindingService:KeysBindingService;
      
      [Inject]
      public static var tankUsersRegistry:TankUsersRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var inventorySoundService:InventorySoundService;
      
      [Inject]
      public static var modelRegistry:ModelRegistry;
      
      public static const PANEL_OFFSET_Y:int = 50;
      
      public static const GAP_BETWEEN_ITEM:int = 10;
      
      private var container:DisplayObjectContainer;
      
      private var inventorySlots:Dictionary;
      
      private var slotIndexByKeyCode:Dictionary = new Dictionary();
      
      private var battleEventSupport:BattleEventSupport;
      
      private var keyboardKeyLocker:KeyboardKeyLocker = new KeyboardKeyLocker();
      
      private var iconWithGapSize:int;
      
      public function InventoryModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.onLocalTankActivationEvent);
         this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
         this.battleEventSupport.addEventHandler(LocalTankKilledEvent,this.onLocalTankKilled);
         this.battleEventSupport.addEventHandler(EffectActivatedEvent,this.onEffectActivatedEvent);
         this.battleEventSupport.addEventHandler(EffectStoppedEvent,this.onEffectStoppedEvent);
         this.battleEventSupport.addEventHandler(InventorySlotReadyToUseEvent,this.onInventorySlotReadyToUseEvent);
      }
      
      private function onEffectActivatedEvent(param1:EffectActivatedEvent) : void
      {
         var _loc2_:ITankModel = null;
         var _loc3_:InventoryPanelSlot = null;
         if(!this.isUltimate(param1.effectId))
         {
            _loc2_ = ITankModel(tankUsersRegistry.getUser(param1.userId).adapt(ITankModel));
            if(_loc2_.isLocal())
            {
               _loc3_ = this.inventorySlots[param1.effectId];
               _loc3_.activeAfterDeath = param1.activeAfterDeath;
            }
         }
      }
      
      private function isUltimate(param1:int) : Boolean
      {
         return param1 == InventoryItemType.ULTIMATE;
      }
      
      private function onEffectStoppedEvent(param1:EffectStoppedEvent) : void
      {
         var _loc2_:InventoryPanelSlot = null;
         if(!this.isUltimate(param1.effectId))
         {
            if(ITankModel(tankUsersRegistry.getUser(param1.userId).adapt(ITankModel)).isLocal())
            {
               _loc2_ = this.inventorySlots[param1.effectId];
               if(_loc2_.activeAfterDeath)
               {
                  _loc2_.activeAfterDeath = false;
               }
            }
         }
      }
      
      private function onBattleFinish(param1:BattleFinishEvent) : void
      {
         this.lockItems(InventoryLock.PLAYER_INACTIVE,true);
         this.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,false);
      }
      
      private function onLocalTankKilled(param1:Object) : void
      {
         this.lockItemsAfterDeath();
      }
      
      public function lockItemsAfterDeath() : void
      {
         var _loc1_:InventoryPanelSlot = null;
         for each(_loc1_ in this.inventorySlots)
         {
            if(!_loc1_.activeAfterDeath)
            {
               _loc1_.setLockMask(InventoryLock.PLAYER_INACTIVE,true);
            }
         }
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         this.container = new Sprite();
         this.container.visible = false;
         battleGuiService.resetPositionXInventory();
         battleGuiService.getGuiContainer().addChild(this.container);
         this.battleEventSupport.activateHandlers();
         this.bindKeys();
      }
      
      public function objectLoadedPost() : void
      {
         this.initSlots();
         OSGi.getInstance().registerService(IInventoryPanel,this);
      }
      
      private function initSlots() : void
      {
         if(this.isDisableInventoryInBattle())
         {
            return;
         }
         this.iconWithGapSize = GAP_BETWEEN_ITEM + new InventoryIcon(InventoryIcon.EMPTY).width;
         this.inventorySlots = new Dictionary();
         if(!battleInfoService.withoutSupplies || !battleInfoService.withoutBonuses)
         {
            this.createSlot(InventoryItemType.FIRST_AID);
            this.createSlot(InventoryItemType.ARMOR);
            this.createSlot(InventoryItemType.DAMAGE);
            this.createSlot(InventoryItemType.NITRO);
            this.createSlot(InventoryItemType.MINE);
            this.createSlot(InventoryItemType.GOLD);
            this.inventorySlots[InventoryItemType.GOLD].getCanvas().visible = false;
         }
         this.createSlot(InventoryItemType.BATTERY);
         this.onResize();
         this.container.visible = true;
         battleInputService.addEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
         battleInputService.addEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
         display.stage.addEventListener(Event.RESIZE,this.onResize,false,-1);
         battleGuiService.addEventListener(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT,this.onChangePositionDefaultLayout);
         display.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function isDisableInventoryInBattle() : Boolean
      {
         return Boolean(battleInfoService.withoutSupplies) && Boolean(battleInfoService.withoutBonuses) && Boolean(battleInfoService.withoutDrones) || Boolean(battleInfoService.isSpectatorMode());
      }
      
      private function createSlot(param1:int) : void
      {
         var _loc2_:* = new InventoryPanelSlot(param1);
         this.inventorySlots[param1] = _loc2_;
         this.container.addChild(_loc2_.getCanvas());
      }
      
      private function onChangePositionDefaultLayout(param1:BattleGUIServiceEvent) : void
      {
         this.onResize();
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:* = undefined;
         OSGi.getInstance().unregisterService(IInventoryPanel);
         if(this.inventorySlots != null)
         {
            battleGuiService.removeEventListener(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT,this.onChangePositionDefaultLayout);
            display.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            display.stage.removeEventListener(Event.RESIZE,this.onResize);
            battleInputService.removeEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
            battleInputService.removeEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
            for(_loc1_ in this.inventorySlots)
            {
               this.clearSlot(int(_loc1_));
            }
            display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            this.inventorySlots = null;
         }
         battleGuiService.getGuiContainer().removeChild(this.container);
         this.container = null;
         this.battleEventSupport.deactivateHandlers();
      }
      
      public function assignItemToSlot(param1:InventoryItem, param2:int) : void
      {
         if(this.getActiveSlotsCount() == 0)
         {
            display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         }
         var _loc3_:InventoryPanelSlot = this.inventorySlots[param2];
         _loc3_.inventoryItem = param1;
         this.updateSlotCounter(_loc3_);
      }
      
      public function itemUpdateCount(param1:InventoryItem) : void
      {
         var _loc2_:InventoryPanelSlot = null;
         for each(_loc2_ in this.inventorySlots)
         {
            if(_loc2_.inventoryItem == param1)
            {
               this.updateSlotCounter(_loc2_);
            }
         }
      }
      
      private function updateSlotCounter(param1:InventoryPanelSlot) : void
      {
         var _loc2_:Boolean = false;
         param1.updateCounter();
         if(param1.getSlotNumber() == InventoryItemType.GOLD)
         {
            _loc2_ = param1.getInventoryCount() > 0;
            if(param1.getCanvas().visible == _loc2_)
            {
               return;
            }
            param1.getCanvas().visible = _loc2_;
            this.onResize();
         }
      }
      
      public function lockItem(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:InventoryPanelSlot = null;
         var _loc5_:InventoryItem = null;
         for each(_loc4_ in this.inventorySlots)
         {
            _loc5_ = _loc4_.inventoryItem;
            if(_loc5_ != null && _loc5_.getId() == param1)
            {
               _loc4_.setLockMask(param2,param3);
            }
         }
      }
      
      public function lockItems(param1:int, param2:Boolean) : void
      {
         var _loc3_:InventoryPanelSlot = null;
         for each(_loc3_ in this.inventorySlots)
         {
            _loc3_.setLockMask(param1,param2);
         }
      }
      
      public function lockItemsByMask(param1:Vector.<int>, param2:int, param3:Boolean) : void
      {
         var _loc4_:InventoryPanelSlot = null;
         var _loc5_:InventoryItem = null;
         for each(_loc4_ in this.inventorySlots)
         {
            _loc5_ = _loc4_.inventoryItem;
            if(_loc5_ != null && param1.indexOf(_loc5_.getId()) != -1)
            {
               _loc4_.setLockMask(param2,param3);
            }
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      private function onResize(param1:Event = null) : void
      {
         var _loc2_:int = this.getPanelWidth();
         var _loc3_:int = display.stage.stageWidth - _loc2_ >> 1;
         var _loc4_:int = _loc3_ + _loc2_ + GAP_BETWEEN_ITEM;
         var _loc5_:int = int(battleGuiService.getPositionXDefaultLayout());
         if(_loc4_ > _loc5_)
         {
            _loc3_ = _loc5_ - _loc2_ - GAP_BETWEEN_ITEM;
         }
         this.container.x = _loc3_;
         this.container.y = display.stage.stageHeight - PANEL_OFFSET_Y;
         battleGuiService.setPositionXInventory(_loc3_);
      }
      
      private function getPanelWidth() : int
      {
         var _loc2_:InventoryPanelSlot = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.inventorySlots)
         {
            _loc2_.getCanvas().x = _loc1_ * this.iconWithGapSize;
            if(_loc2_.getCanvas().visible)
            {
               _loc1_++;
            }
         }
         return _loc1_ * this.iconWithGapSize - GAP_BETWEEN_ITEM;
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc4_:InventoryPanelSlot = null;
         if(this.keyboardKeyLocker.isKeyLocked(param1.keyCode))
         {
            return;
         }
         var _loc2_:GameActionEnum = keysBindingService.getBindingAction(param1.keyCode);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:* = this.slotIndexByKeyCode[_loc2_];
         if(_loc3_ != null)
         {
            _loc4_ = this.inventorySlots[int(_loc3_)];
            if(_loc4_.isLocked() && _loc4_.getSlotNumber() == InventoryItemType.FIRST_AID)
            {
               inventorySoundService.playNotReadySound();
            }
            if(!_loc4_.isLocked())
            {
               if(_loc4_.inventoryItem != null && _loc4_.inventoryItem.count > 0 && _loc4_.cooldownItem.canActivate())
               {
                  this.keyboardKeyLocker.lockKey(param1.keyCode);
                  _loc4_.inventoryItem.requestActivation();
               }
               else
               {
                  inventorySoundService.playNotReadySound();
               }
            }
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(this.keyboardKeyLocker.isKeyLocked(param1.keyCode))
         {
            this.keyboardKeyLocker.unlockKey(param1.keyCode);
         }
      }
      
      private function getActiveSlotsCount() : int
      {
         var _loc2_:InventoryPanelSlot = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.inventorySlots)
         {
            if(_loc2_.inventoryItem != null)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      private function clearSlot(param1:int) : void
      {
         var _loc2_:InventoryPanelSlot = this.inventorySlots[param1];
         _loc2_.destroy();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc3_:InventoryPanelSlot = null;
         var _loc2_:int = getTimer();
         for each(_loc3_ in this.inventorySlots)
         {
            _loc3_.update(_loc2_);
         }
      }
      
      private function bindKeys() : void
      {
         this.slotIndexByKeyCode[GameActionEnum.USE_FIRS_AID] = InventoryItemType.FIRST_AID;
         this.slotIndexByKeyCode[GameActionEnum.USE_DOUBLE_ARMOR] = InventoryItemType.ARMOR;
         this.slotIndexByKeyCode[GameActionEnum.USE_DOUBLE_DAMAGE] = InventoryItemType.DAMAGE;
         this.slotIndexByKeyCode[GameActionEnum.USE_NITRO] = InventoryItemType.NITRO;
         this.slotIndexByKeyCode[GameActionEnum.USE_MINE] = InventoryItemType.MINE;
         this.slotIndexByKeyCode[GameActionEnum.DROP_GOLD_BOX] = InventoryItemType.GOLD;
      }
      
      private function onInputLocked(param1:BattleInputLockEvent) : void
      {
         this.lockItems(InventoryLock.GUI,true);
      }
      
      private function onInputUnlocked(param1:BattleInputLockEvent) : void
      {
         this.lockItems(InventoryLock.GUI,false);
      }
      
      private function onLocalTankActivationEvent(param1:Object) : void
      {
         var _loc2_:InventoryPanelSlot = null;
         for each(_loc2_ in this.inventorySlots)
         {
            if(!_loc2_.activeAfterDeath)
            {
               _loc2_.setLockMask(InventoryLock.PLAYER_INACTIVE,false);
            }
         }
      }
      
      public function changeEffectTime(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:InventoryPanelSlot = this.inventorySlots[param1];
         if(param4)
         {
            _loc5_.startInfiniteEffect(param3);
         }
         else
         {
            _loc5_.changeEffectTime(param2,param3);
         }
      }
      
      public function activateCooldown(param1:int, param2:int) : void
      {
         var _loc3_:InventoryPanelSlot = this.inventorySlots[param1];
         _loc3_.activateCooldown(param2);
      }
      
      public function activateDependedCooldown(param1:int, param2:int) : void
      {
         var _loc3_:InventoryPanelSlot = this.inventorySlots[param1];
         _loc3_.activateDependedCooldown(param2);
      }
      
      public function showInventory() : void
      {
         if(this.container != null && this.container.numChildren > 0)
         {
            this.onResize();
            this.container.visible = true;
         }
      }
      
      public function stopEffect(param1:int) : void
      {
         var _loc2_:InventoryPanelSlot = this.inventorySlots[param1];
         _loc2_.stopEffect();
      }
      
      private function onInventorySlotReadyToUseEvent(param1:InventorySlotReadyToUseEvent) : void
      {
         var _loc2_:InventoryPanelSlot = this.inventorySlots[param1.slotIndex];
         _loc2_.startReadyIndicator();
      }
      
      public function setCooldownDuration(param1:int, param2:int) : void
      {
         InventoryPanelSlot(this.inventorySlots[param1]).setCooldownDuration(param2);
      }
      
      public function setVisible(param1:int, param2:Boolean, param3:Boolean) : void
      {
         if(this.inventorySlots != null)
         {
            InventoryPanelSlot(this.inventorySlots[param1]).getCanvas().visible = param2;
            this.onResize();
         }
      }
      
      public function setEffectInfinite(param1:int, param2:Boolean) : void
      {
         var _loc3_:InventoryPanelSlot = this.inventorySlots[param1];
         if(_loc3_ != null)
         {
            this.changeEffectTime(param1,getTimer(),true,param2);
         }
      }
      
      public function ready(param1:int) : void
      {
         InventoryPanelSlot(this.inventorySlots[param1]).ready();
      }
   }
}

