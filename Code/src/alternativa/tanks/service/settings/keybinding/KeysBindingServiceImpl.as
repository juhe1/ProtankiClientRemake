package alternativa.tanks.service.settings.keybinding
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.locale.ILocaleService;
   import flash.events.EventDispatcher;
   import flash.net.SharedObject;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.LocaleServiceLangValues;
   
   public class KeysBindingServiceImpl extends EventDispatcher implements KeysBindingService
   {
      
      public static const MAX_BINDING_KEY_ON_ACTION:int = 3;
      
      public static const BINDING_KEY_NOT_DEFINED:uint = 0;
      
      private var storageService:IStorageService;
      
      private var bindingsKeyToAction:Dictionary = new Dictionary();
      
      private var bindingsActionToKey:Dictionary = new Dictionary();
      
      private var defaultKeyLeft:uint;
      
      private var defaultBindings:Dictionary = new Dictionary();
      
      private var keyCodesConverter:KeyCodesConverter;
      
      public function KeysBindingServiceImpl()
      {
         super();
         var _loc1_:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
         this.storageService = IStorageService(OSGi.getInstance().getService(IStorageService));
         this.defaultKeyLeft = _loc1_.language == LocaleServiceLangValues.DE ? Keyboard.Y : Keyboard.Z;
         this.initDefaultBindings();
         this.restoreBindingsFromStorage();
      }
      
      private static function isNullKeyCode(param1:uint) : Boolean
      {
         return param1 == BINDING_KEY_NOT_DEFINED;
      }
      
      private static function initNewKeyBindingVector() : Vector.<uint>
      {
         return new Vector.<uint>(MAX_BINDING_KEY_ON_ACTION,true);
      }
      
      private function getKeyCodesConverter() : KeyCodesConverter
      {
         if(!this.keyCodesConverter)
         {
            this.keyCodesConverter = new KeyCodesConverter();
         }
         return this.keyCodesConverter;
      }
      
      public function isFreeKey(param1:uint) : Boolean
      {
         return this.bindingsKeyToAction[param1] == null;
      }
      
      public function setKeyBinding(param1:GameActionEnum, param2:uint, param3:int) : Boolean
      {
         var _loc5_:GameActionEnum = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:int = 0;
         if(param3 >= MAX_BINDING_KEY_ON_ACTION)
         {
            return false;
         }
         if(!this.isFreeKey(param2))
         {
            _loc5_ = this.bindingsKeyToAction[param2];
            _loc6_ = this.bindingsActionToKey[_loc5_];
            _loc7_ = int(_loc6_.indexOf(param2));
            delete this.bindingsKeyToAction[param2];
            _loc6_[_loc7_] = BINDING_KEY_NOT_DEFINED;
            this.storeKeyBinding(_loc5_,_loc6_);
            dispatchEvent(new KeyBindingChangeEvent(KeyBindingChangeEvent.KEY_BINDING_CHANGE + _loc5_.name,_loc5_));
         }
         var _loc4_:uint = this.getKeyBinding(param1,param3);
         if(!isNullKeyCode(_loc4_) && _loc4_ != param2)
         {
            delete this.bindingsKeyToAction[_loc4_];
         }
         this.bindingsKeyToAction[param2] = param1;
         this.bindingsActionToKey[param1][param3] = param2;
         this.storeKeyBinding(param1,this.bindingsActionToKey[param1]);
         return true;
      }
      
      private function storeKeyBinding(param1:GameActionEnum, param2:Vector.<uint> = null) : void
      {
         if(!param2)
         {
            param2 = initNewKeyBindingVector();
         }
         var _loc3_:SharedObject = this.storageService.getStorage();
         _loc3_.data[param1.name] = param2;
         _loc3_.flush();
      }
      
      public function getKeyBinding(param1:GameActionEnum, param2:uint) : uint
      {
         if(param2 >= MAX_BINDING_KEY_ON_ACTION)
         {
            return BINDING_KEY_NOT_DEFINED;
         }
         var _loc3_:Vector.<uint> = this.bindingsActionToKey[param1];
         if(Boolean(_loc3_))
         {
            return _loc3_[param2];
         }
         return BINDING_KEY_NOT_DEFINED;
      }
      
      public function getKeyBindings(param1:GameActionEnum) : Vector.<uint>
      {
         return this.bindingsActionToKey[param1];
      }
      
      public function getBindingAction(param1:uint) : GameActionEnum
      {
         return this.bindingsKeyToAction[param1];
      }
      
      private function initDefaultBindings() : void
      {
         this.defaultBindings[GameActionEnum.ROTATE_TURRET_LEFT] = Vector.<uint>([this.defaultKeyLeft,Keyboard.COMMA,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.ROTATE_TURRET_RIGHT] = Vector.<uint>([Keyboard.X,Keyboard.PERIOD,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.CENTER_TURRET] = Vector.<uint>([Keyboard.C,Keyboard.SLASH,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.CHASSIS_LEFT_MOVEMENT] = Vector.<uint>([Keyboard.LEFT,Keyboard.A,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.CHASSIS_RIGHT_MOVEMENT] = Vector.<uint>([Keyboard.RIGHT,Keyboard.D,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.CHASSIS_FORWARD_MOVEMENT] = Vector.<uint>([Keyboard.UP,Keyboard.W,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.CHASSIS_BACKWARD_MOVEMENT] = Vector.<uint>([Keyboard.DOWN,Keyboard.S,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.FOLLOW_CAMERA_UP] = Vector.<uint>([Keyboard.PAGE_UP,Keyboard.LEFTBRACKET,Keyboard.Q]);
         this.defaultBindings[GameActionEnum.FOLLOW_CAMERA_DOWN] = Vector.<uint>([Keyboard.PAGE_DOWN,Keyboard.RIGHTBRACKET,Keyboard.E]);
         this.defaultBindings[GameActionEnum.DROP_FLAG] = Vector.<uint>([Keyboard.F,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.BATTLE_PAUSE] = Vector.<uint>([Keyboard.P,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.BATTLE_VIEW_INCREASE] = Vector.<uint>([Keyboard.NUMPAD_ADD,Keyboard.EQUAL,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.BATTLE_VIEW_DECREASE] = Vector.<uint>([Keyboard.O,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.FULL_SCREEN] = Vector.<uint>([Keyboard.O,Keyboard.F11,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.BATTLE_VIEW_INCREASE] = Vector.<uint>([Keyboard.NUMPAD_ADD,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.BATTLE_VIEW_DECREASE] = Vector.<uint>([Keyboard.NUMPAD_SUBTRACT,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.SUICIDE] = Vector.<uint>([Keyboard.DELETE,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.SHOW_TANK_PARAMETERS] = Vector.<uint>([Keyboard.V,Keyboard.R,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.USE_FIRS_AID] = Vector.<uint>([Keyboard.NUMBER_1,Keyboard.NUMPAD_1,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.USE_DOUBLE_ARMOR] = Vector.<uint>([Keyboard.NUMBER_2,Keyboard.NUMPAD_2,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.USE_DOUBLE_DAMAGE] = Vector.<uint>([Keyboard.NUMBER_3,Keyboard.NUMPAD_3,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.USE_NITRO] = Vector.<uint>([Keyboard.NUMBER_4,Keyboard.NUMPAD_4,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.USE_MINE] = Vector.<uint>([Keyboard.NUMBER_5,Keyboard.NUMPAD_5,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.DROP_GOLD_BOX] = Vector.<uint>([Keyboard.NUMBER_6,Keyboard.NUMPAD_6,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.SHOT] = Vector.<uint>([Keyboard.SPACE,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.ULTIMATE] = Vector.<uint>([Keyboard.SHIFT,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
         this.defaultBindings[GameActionEnum.OPEN_GARAGE] = Vector.<uint>([Keyboard.G,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
      }
      
      private function internalSetKeyBinding(param1:GameActionEnum, param2:Vector.<uint>) : void
      {
         if(!param2)
         {
            param2 = this.defaultBindings[param1];
            if(!param2)
            {
               param2 = initNewKeyBindingVector();
            }
         }
         this.bindingsActionToKey[param1] = param2;
         var _loc3_:int = 0;
         while(_loc3_ < MAX_BINDING_KEY_ON_ACTION)
         {
            this.setKeyBinding(param1,param2[_loc3_],_loc3_);
            _loc3_++;
         }
      }
      
      public function restoreDefaultBindings() : void
      {
         var _loc1_:GameActionEnum = null;
         this.bindingsActionToKey = new Dictionary();
         this.bindingsKeyToAction = new Dictionary();
         for each(_loc1_ in GameActionEnum.values)
         {
            this.internalSetKeyBinding(_loc1_,this.defaultBindings[_loc1_].concat());
         }
      }
      
      private function restoreBindingsFromStorage() : void
      {
         var _loc2_:GameActionEnum = null;
         var _loc1_:SharedObject = this.storageService.getStorage();
         for each(_loc2_ in GameActionEnum.values)
         {
            this.internalSetKeyBinding(_loc2_,_loc1_.data[_loc2_.name]);
         }
      }
      
      public function getKeyCodeLabel(param1:uint) : String
      {
         return this.getKeyCodesConverter().keyCodeToString(param1);
      }
   }
}

