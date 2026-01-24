package alternativa.tanks.models.battle.battlefield.keyboard
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.display.usertitle.UserTitle;
   import alternativa.tanks.model.garage.resistance.ResistancesIcons;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.models.tank.device.TankDevice;
   import alternativa.tanks.models.tank.resistance.TankResistances;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.tanks.services.battlegui.BattleGUIServiceEvent;
   import alternativa.tanks.services.battleinput.BattleInputLockEvent;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import alternativa.utils.removeDisplayObject;
   import base.DiscreteSprite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.user.resistance.TankResistance;
   
   public class AdditionUserTitleSwitcher extends AbstractKeyboardHandler implements BattleEventListener
   {
      
      [Inject] // added
      public static var battleInputService:BattleInputService;
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject] // added
      public static var battleGuiService:BattleGUIService;
      
      [Inject] // added
      public static var localTankService:LocalTankInfoService;
      
      [Inject] // added
      public static var keysBindingService:KeysBindingService;
      
      private static var RESISTANCE_ICON_SIZE:int = 34;
      
      private var keyboardMask:int;
      
      private var ownResistances:Bitmap;
      
      private var ownDevice:Bitmap;
      
      public function AdditionUserTitleSwitcher()
      {
         super();
         battleEventDispatcher.addBattleEventListener(TankLoadedEvent,this);
         this.handleLock();
      }
      
      override protected function handleLock(param1:BattleInputLockEvent = null) : void
      {
         UserTitle.showAddition = false;
         this.keyboardMask = 0;
         if(this.ownResistances != null)
         {
            this.ownResistances.visible = false;
         }
         if(this.ownDevice != null)
         {
            this.ownDevice.visible = false;
         }
      }
      
      override protected function handleKeyboardEvent(param1:KeyboardEvent = null) : void
      {
         if(battleInputService.isInputLocked())
         {
            return;
         }
         var _loc2_:Boolean = param1.type == KeyboardEvent.KEY_DOWN;
         var _loc3_:GameActionEnum = keysBindingService.getBindingAction(param1.keyCode);
         if(_loc3_ == GameActionEnum.SHOW_TANK_PARAMETERS)
         {
            if(_loc2_)
            {
               this.keyboardMask |= 1;
            }
            else
            {
               this.keyboardMask &= ~1;
            }
         }
         UserTitle.showAddition = this.keyboardMask != 0;
         if(this.ownResistances != null)
         {
            this.ownResistances.visible = UserTitle.showAddition;
         }
         if(this.ownDevice != null)
         {
            this.ownDevice.visible = UserTitle.showAddition;
         }
      }
      
      private function onResize(param1:Event = null) : void
      {
         if(this.ownResistances != null)
         {
            this.ownResistances.x = display.stage.stageWidth - this.ownResistances.width >> 1;
            this.ownResistances.y = display.stage.stageHeight - 103;
         }
         if(this.ownDevice != null)
         {
            this.ownDevice.x = display.stage.stageWidth - this.ownDevice.width >> 1;
            this.ownDevice.y = display.stage.stageHeight - (this.ownResistances == null ? 123 : 163);
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         var _loc2_:TankLoadedEvent = TankLoadedEvent(param1);
         if(_loc2_.isLocal)
         {
            this.clearOwnResistances();
            this.clearOwnDevice();
            display.stage.addEventListener(Event.RESIZE,this.onResize,false,-1);
            battleGuiService.addEventListener(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT,this.onResize);
            this.createOwnResistances();
            this.createOwnDevice();
         }
      }
      
      private function createOwnResistances() : void
      {
         var _loc1_:DiscreteSprite = null;
         var _loc6_:TankResistance = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Bitmap = null;
         var _loc9_:BitmapData = null;
         _loc1_ = new DiscreteSprite();
         _loc1_.visible = false;
         battleGuiService.getGuiContainer().addChild(_loc1_);
         var _loc2_:IGameObject = localTankService.getLocalTankObject();
         var _loc3_:TankResistances = TankResistances(_loc2_.adapt(TankResistances));
         var _loc4_:Vector.<TankResistance> = _loc3_.getResistances();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc7_ = new ResistancesIcons.resistanceIconClass();
            _loc7_.x = RESISTANCE_ICON_SIZE * _loc5_;
            _loc1_.addChild(_loc7_);
            _loc8_ = new Bitmap(ResistancesIcons.getBitmapDataByName(_loc6_.resistanceProperty.name));
            _loc8_.x = (_loc7_.width - _loc8_.width >> 1) + _loc7_.x;
            _loc8_.y = (_loc7_.height - _loc8_.height >> 1) + _loc7_.y;
            _loc1_.addChild(_loc8_);
            _loc5_++;
         }
         if(_loc1_.width != 0)
         {
            _loc9_ = new BitmapData(_loc4_.length * RESISTANCE_ICON_SIZE,RESISTANCE_ICON_SIZE,true,0);
            _loc9_.draw(_loc1_);
            this.ownResistances = new Bitmap(_loc9_);
            battleGuiService.getGuiContainer().addChild(this.ownResistances);
            this.ownResistances.visible = UserTitle.showAddition;
            this.onResize();
         }
      }
      
      private function createOwnDevice() : void
      {
         var _loc1_:IGameObject = localTankService.getLocalTankObject();
         var _loc2_:TankDevice = TankDevice(_loc1_.adapt(TankDevice));
         var _loc3_:BitmapData = DeviceIcons.getByDeviceId(_loc2_.getDevice());
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:DiscreteSprite = new DiscreteSprite();
         _loc4_.visible = false;
         battleGuiService.getGuiContainer().addChild(_loc4_);
         var _loc5_:Bitmap = new Bitmap(DeviceIcons.backgroundIcon);
         var _loc6_:Bitmap = new Bitmap(_loc3_);
         _loc6_.x = (_loc5_.width - _loc6_.width >> 1) + _loc5_.x;
         _loc6_.y = (_loc5_.height - _loc6_.height >> 1) + _loc5_.y;
         _loc4_.addChild(_loc5_);
         _loc4_.addChild(_loc6_);
         var _loc7_:BitmapData = new BitmapData(_loc4_.width,_loc4_.height,true,0);
         _loc7_.draw(_loc4_);
         this.ownDevice = new Bitmap(_loc7_);
         battleGuiService.getGuiContainer().addChild(this.ownDevice);
         this.ownDevice.visible = UserTitle.showAddition;
         this.onResize();
      }
      
      [Obfuscation(rename="false")]
      override public function close() : void
      {
         super.close();
         battleEventDispatcher.removeBattleEventListener(TankLoadedEvent,this);
         this.clearOwnResistances();
         this.clearOwnDevice();
      }
      
      private function clearOwnResistances() : void
      {
         if(this.ownResistances != null)
         {
            display.stage.removeEventListener(Event.RESIZE,this.onResize);
            battleGuiService.removeEventListener(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT,this.onResize);
            removeDisplayObject(this.ownResistances);
            this.ownResistances.bitmapData.dispose();
            this.ownResistances = null;
         }
      }
      
      private function clearOwnDevice() : void
      {
         if(this.ownDevice != null)
         {
            display.stage.removeEventListener(Event.RESIZE,this.onResize);
            battleGuiService.removeEventListener(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT,this.onResize);
            removeDisplayObject(this.ownDevice);
            this.ownDevice.bitmapData.dispose();
            this.ownDevice = null;
         }
      }
   }
}

