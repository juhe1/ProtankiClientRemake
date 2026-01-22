package alternativa.tanks.gui.settings.tabs.control
{
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeyBindingChangeEvent;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import alternativa.tanks.service.settings.keybinding.KeysBindingServiceImpl;
   import base.DiscreteSprite;
   import controls.base.LabelBase;
   import controls.base.TankInput;
   import controls.containers.HorizontalStackPanel;
   import flash.events.KeyboardEvent;
   import flash.text.TextFormatAlign;
   import flash.ui.Keyboard;
   
   public class KeyBinding extends DiscreteSprite
   {
      
      [Inject]
      public static var keysBindingService:KeysBindingService;
      
      public static const KEY_INPUT_WIDTH:int = 120;
      
      private var keyInputs:Vector.<TankInput> = new Vector.<TankInput>(3,true);
      
      private var action:GameActionEnum;
      
      public function KeyBinding(param1:GameActionEnum, param2:String, param3:int, param4:int)
      {
         super();
         this.action = param1;
         var _loc5_:int = param4 - 6 * param3 - KEY_INPUT_WIDTH * 3;
         var _loc6_:HorizontalStackPanel = new HorizontalStackPanel();
         _loc6_.setMargin(param3);
         _loc6_.x = _loc5_ + param3;
         var _loc7_:int = 0;
         while(_loc7_ < 3)
         {
            _loc6_.addItem(this.createKeyInput(_loc7_));
            _loc7_++;
         }
         var _loc8_:LabelBase = new LabelBase();
         _loc8_.text = param2;
         _loc8_.x = 0;
         _loc8_.y = Math.round((this.keyInputs[0].height - _loc8_.textHeight) * 0.5) - 2;
         addChild(_loc8_);
         addChild(_loc6_);
         keysBindingService.addEventListener(KeyBindingChangeEvent.KEY_BINDING_CHANGE + param1.name,this.keyChanged);
      }
      
      private function keyChanged(param1:KeyBindingChangeEvent) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.keyInputs.length)
         {
            this.keyInputs[_loc2_].value = this.getKeyBindingStringFromService(_loc2_);
            _loc2_++;
         }
      }
      
      private function getKeyBindingStringFromService(param1:uint) : String
      {
         var _loc2_:uint = uint(keysBindingService.getKeyBinding(this.action,param1));
         return keysBindingService.getKeyCodeLabel(_loc2_);
      }
      
      public function getAction() : GameActionEnum
      {
         return this.action;
      }
      
      private function createKeyInput(param1:int) : TankInput
      {
         var _loc2_:TankInput = new TankInput();
         _loc2_.addEventListener(KeyboardEvent.KEY_UP,this.onKeyDown);
         _loc2_.maxChars = 1;
         _loc2_.width = KEY_INPUT_WIDTH;
         _loc2_.align = TextFormatAlign.CENTER;
         _loc2_.value = this.getKeyBindingStringFromService(param1);
         this.keyInputs[param1] = _loc2_;
         return _loc2_;
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc2_:TankInput = TankInput(param1.currentTarget);
         if(param1.keyCode == Keyboard.BACKSPACE || param1.keyCode == Keyboard.DELETE)
         {
            if(keysBindingService.setKeyBinding(this.action,KeysBindingServiceImpl.BINDING_KEY_NOT_DEFINED,this.keyInputs.indexOf(_loc2_)))
            {
               _loc2_.value = "";
            }
            else
            {
               _loc2_.value = this.getKeyBindingStringFromService(this.keyInputs.indexOf(_loc2_));
            }
            return;
         }
         var _loc3_:String = keysBindingService.getKeyCodeLabel(param1.keyCode);
         if(_loc3_ != "")
         {
            _loc4_ = Boolean(keysBindingService.setKeyBinding(this.action,param1.keyCode,this.keyInputs.indexOf(_loc2_)));
            _loc2_.value = _loc4_ ? _loc3_ : "";
         }
         else
         {
            _loc2_.value = this.getKeyBindingStringFromService(this.keyInputs.indexOf(_loc2_));
         }
      }
      
      public function restoreDefaultBinding() : void
      {
         var _loc1_:Vector.<uint> = keysBindingService.getKeyBindings(this.action);
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            this.keyInputs[_loc2_].value = keysBindingService.getKeyCodeLabel(_loc1_[_loc2_]);
            _loc2_++;
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:TankInput = null;
         for each(_loc1_ in this.keyInputs)
         {
            _loc1_.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
         this.keyInputs = null;
         keysBindingService.removeEventListener(KeyBindingChangeEvent.KEY_BINDING_CHANGE + this.action.name,this.keyChanged);
      }
   }
}

