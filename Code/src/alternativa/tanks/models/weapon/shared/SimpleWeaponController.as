package alternativa.tanks.models.weapon.shared
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.PauseActivationEvent;
   import alternativa.tanks.battle.events.PauseDeactivationEvent;
   import alternativa.tanks.battle.events.TargetingInputModeChangedEvent;
   import alternativa.tanks.battle.events.TargetingModeChangedEvent;
   import alternativa.tanks.battle.objects.tank.LocalWeapon;
   import alternativa.tanks.battle.objects.tank.controllers.TargetingMode;
   import alternativa.tanks.models.battle.gui.chat.ChatEvent;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import alternativa.tanks.services.targeting.TargetingInputListener;
   import alternativa.tanks.services.targeting.TargetingInputManager;
   import alternativa.tanks.services.targeting.TargetingModeService;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   
   public class SimpleWeaponController implements BattleEventListener, TargetingInputListener
   {
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject] // added
      public static var inputManager:TargetingInputManager;
      
      [Inject] // added
      public static var targetingModeService:TargetingModeService;
      
      [Inject] // added
      public static var settingsService:ISettingsService;
      
      [Inject] // added
      public static var keysBindingService:KeysBindingService;
      
      private var weapon:LocalWeapon;
      
      private var triggerPulled:Boolean;
      
      private var wasTriggerPulled:Boolean;
      
      private var pullFromKeyboard:Boolean = false;
      
      private var pressedKeys:Vector.<Boolean> = new Vector.<Boolean>(255);
      
      private var pause:Boolean;
      
      private var targetingMode:int;
      
      public function SimpleWeaponController()
      {
         super();
      }
      
      public function setWeapon(param1:LocalWeapon) : void
      {
         this.weapon = param1;
      }
      
      public function wasActive() : Boolean
      {
         return this.triggerPulled || this.wasTriggerPulled;
      }
      
      public function isTriggerPulled() : Boolean
      {
         return this.triggerPulled;
      }
      
      public function discardStoredAction() : void
      {
         this.wasTriggerPulled = false;
      }
      
      public function init() : void
      {
         display.stage.addEventListener(Event.DEACTIVATE,this.onClientWindowDeactivate);
         display.stage.addEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
         display.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
         battleEventDispatcher.addBattleEventListener(PauseDeactivationEvent,this);
         battleEventDispatcher.addBattleEventListener(PauseActivationEvent,this);
         battleEventDispatcher.addBattleEventListener(TargetingModeChangedEvent,this);
         battleEventDispatcher.addBattleEventListener(TargetingInputModeChangedEvent,this);
         battleEventDispatcher.addBattleEventListener(ChatEvent,this);
         inputManager.addListener(this);
         this.pause = false;
      }
      
      public function destroy() : void
      {
         display.stage.removeEventListener(Event.DEACTIVATE,this.onClientWindowDeactivate);
         display.stage.removeEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
         display.stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
         battleEventDispatcher.removeBattleEventListener(PauseDeactivationEvent,this);
         battleEventDispatcher.removeBattleEventListener(PauseActivationEvent,this);
         battleEventDispatcher.removeBattleEventListener(TargetingModeChangedEvent,this);
         battleEventDispatcher.removeBattleEventListener(TargetingInputModeChangedEvent,this);
         battleEventDispatcher.removeBattleEventListener(ChatEvent,this);
         inputManager.removeListener(this);
      }
      
      private function onFullScreen(param1:FullScreenEvent) : void
      {
         this.releaseTrigger();
      }
      
      private function onMouseLeave(param1:Event) : void
      {
         this.releaseTrigger();
      }
      
      private function pullTrigger(param1:Boolean) : void
      {
         this.triggerPulled = true;
         this.wasTriggerPulled = true;
         targetingModeService.blockModeChange();
         if(this.weapon != null)
         {
            if(param1 && this.targetingMode == TargetingMode.KEYBOARD)
            {
               return;
            }
            this.weapon.pullTrigger();
         }
      }
      
      public function isKeyPressed(param1:uint) : Boolean
      {
         return param1 < 256 ? this.pressedKeys[param1] : false;
      }
      
      private function releaseTrigger() : void
      {
         var _loc1_:Boolean = this.triggerPulled;
         this.triggerPulled = false;
         if(_loc1_ && this.weapon != null)
         {
            this.weapon.releaseTrigger();
         }
         targetingModeService.unblockModeChange();
      }
      
      private function onClientWindowDeactivate(param1:Event) : void
      {
         this.triggerPulled = false;
         this.wasTriggerPulled = false;
         if(this.weapon != null)
         {
            this.weapon.releaseTrigger();
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.pressedKeys.length)
         {
            this.pressedKeys[_loc2_] = false;
            _loc2_++;
         }
         targetingModeService.unblockModeChange();
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         var _loc2_:TargetingInputModeChangedEvent = null;
         if(param1 is PauseDeactivationEvent)
         {
            this.pause = false;
         }
         else if(param1 is PauseActivationEvent)
         {
            this.pause = true;
         }
         else if(param1 is TargetingModeChangedEvent)
         {
            this.targetingMode = TargetingModeChangedEvent(param1).targetingMode;
         }
         else if(param1 is TargetingInputModeChangedEvent)
         {
            _loc2_ = TargetingInputModeChangedEvent(param1);
            if(this.triggerPulled && this.pullFromKeyboard && !_loc2_.allowKeyboard)
            {
               this.releaseTrigger();
            }
            this.pause = !TargetingInputModeChangedEvent(param1).enabled;
         }
         else if(param1 is ChatEvent)
         {
            if(this.triggerPulled)
            {
               this.releaseTrigger();
            }
         }
      }
      
      public function mouseAbsoluteMovement(param1:Number, param2:Number) : void
      {
      }
      
      public function mouseRelativeMovement(param1:Number, param2:Number) : void
      {
      }
      
      public function mouseLeftButton(param1:Boolean, param2:Boolean) : Boolean
      {
         if(!this.pause && Boolean(settingsService.mouseControl) && targetingModeService.getCurrentMode() == TargetingMode.MOUSE_LOOK)
         {
            if(!this.triggerPulled && param1)
            {
               this.pullTrigger(true);
               this.pullFromKeyboard = false;
            }
            else if(this.triggerPulled && !this.pullFromKeyboard && !param1)
            {
               this.releaseTrigger();
            }
         }
         return true;
      }
      
      public function mouseWheel(param1:int) : void
      {
      }
      
      public function mouseRightButton(param1:Boolean, param2:Boolean) : Boolean
      {
         return true;
      }
      
      public function keyboardButton(param1:uint, param2:Boolean) : Boolean
      {
         var _loc3_:GameActionEnum = keysBindingService.getBindingAction(param1);
         if(param2)
         {
            if(_loc3_ == GameActionEnum.SHOT && !this.triggerPulled)
            {
               this.pullTrigger(false);
               this.pullFromKeyboard = true;
            }
            if(param1 < 256)
            {
               this.pressedKeys[param1] = true;
            }
         }
         else
         {
            if(_loc3_ == GameActionEnum.SHOT && this.triggerPulled && this.pullFromKeyboard)
            {
               this.releaseTrigger();
            }
            if(param1 < 256)
            {
               this.pressedKeys[param1] = false;
            }
         }
         return true;
      }
      
      public function mouseLocked(param1:Boolean) : void
      {
         if(this.triggerPulled && this.pullFromKeyboard)
         {
            this.releaseTrigger();
         }
      }
   }
}

