package alternativa.tanks.services.targeting
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.PauseActivationEvent;
   import alternativa.tanks.battle.events.PauseDeactivationEvent;
   import alternativa.tanks.battle.events.TargetingInputModeChangedEvent;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import flash.display.Stage;
   import flash.display.StageDisplayState;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   
   public class TargetingInputManagerImpl implements TargetingInputManager, BattleEventListener
   {
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var lobbyLayout:ILobbyLayoutService;
      
      [Inject] // added
      public static var battleInputService:BattleInputService;
      
      [Inject] // added
      public static var fullScreenService:FullscreenService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private static const MOVEMENT_X:String = "movementX";
      
      private static const MOVEMENT_Y:String = "movementY";
      
      private static const RIGHT_MOUSE_DOWN:String = "rightMouseDown";
      
      private static const RIGHT_MOUSE_UP:String = "rightMouseUp";
      
      private static const FULL_SCREEN_INTERACTIVE_ACCEPTED:String = "fullScreenInteractiveAccepted";
      
      private static const MOUSE_LOCK:String = "mouseLock";
      
      private var listeners:Vector.<TargetingInputListener> = new Vector.<TargetingInputListener>();
      
      private var dialogCount:int = 0;
      
      private var active:Boolean = true;
      
      private var firstRelativeMove:Boolean = false;
      
      private var mouseWasLocked:Boolean = false;
      
      private var somethingWasOnScreen:Boolean = false;
      
      private var ignoreEvents:int = 0;
      
      private var inFullScreenDialog:Boolean = false;
      
      private var storedMouseButtonState:Boolean = false;
      
      private var currentMouseButtonState:Boolean = false;
      
      private var pause:Boolean = false;
      
      private var activate:Boolean = false;
      
      private var initied:Boolean = false;
      
      private var allowKeyboard:Boolean = false;
      
      public function TargetingInputManagerImpl()
      {
         super();
      }
      
      public function init() : void
      {
         if(!this.initied)
         {
            display.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
            display.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            display.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
            display.stage.addEventListener(RIGHT_MOUSE_DOWN,this.onRightMouseDown);
            display.stage.addEventListener(RIGHT_MOUSE_UP,this.onRightMouseUp);
            display.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            display.stage.addEventListener(Event.ACTIVATE,this.onActivate);
            display.stage.addEventListener(Event.DEACTIVATE,this.onDeactivate);
            display.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
            display.stage.addEventListener(FULL_SCREEN_INTERACTIVE_ACCEPTED,this.onFullScreenAccepted);
            battleEventDispatcher.addBattleEventListener(PauseActivationEvent,this);
            battleEventDispatcher.addBattleEventListener(PauseDeactivationEvent,this);
            this.listeners.length = 0;
            this.dialogCount = 0;
            this.active = true;
            this.activate = false;
            this.pause = false;
            this.inFullScreenDialog = false;
            this.ignoreEvents = 0;
            this.mouseWasLocked = false;
            this.firstRelativeMove = false;
            this.allowKeyboard = false;
            this.initied = true;
         }
      }
      
      public function initForSpectator() : void
      {
         if(!this.initied)
         {
            display.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            this.listeners.length = 0;
            this.dialogCount = 0;
            this.active = true;
            this.activate = false;
            this.pause = false;
            this.inFullScreenDialog = false;
            this.ignoreEvents = 0;
            this.mouseWasLocked = false;
            this.firstRelativeMove = false;
            this.allowKeyboard = false;
            this.initied = true;
         }
      }
      
      public function close() : void
      {
         if(this.initied)
         {
            display.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
            display.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            display.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
            display.stage.removeEventListener(RIGHT_MOUSE_DOWN,this.onRightMouseDown);
            display.stage.removeEventListener(RIGHT_MOUSE_UP,this.onRightMouseUp);
            display.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            display.stage.removeEventListener(Event.ACTIVATE,this.onActivate);
            display.stage.removeEventListener(Event.DEACTIVATE,this.onDeactivate);
            display.stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
            display.stage.removeEventListener(FULL_SCREEN_INTERACTIVE_ACCEPTED,this.onFullScreenAccepted);
            battleEventDispatcher.removeBattleEventListener(PauseActivationEvent,this);
            battleEventDispatcher.removeBattleEventListener(PauseDeactivationEvent,this);
            this.listeners.length = 0;
            this.initied = false;
         }
      }
      
      private function onFullScreenAccepted(param1:FullScreenEvent) : void
      {
         if(param1.fullScreen)
         {
            this.ignoreInput();
         }
         this.inFullScreenDialog = false;
      }
      
      private function onFullScreen(param1:FullScreenEvent) : void
      {
         if(param1.fullScreen)
         {
            this.ignoreInput();
         }
         this.inFullScreenDialog = param1.fullScreen && !fullScreenService.isStandAlone();
      }
      
      private function onRightMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.canHandleMouseInput(param1))
         {
            _loc2_ = 0;
            while(_loc2_ < this.listeners.length)
            {
               if(!TargetingInputListener(this.listeners[_loc2_]).mouseRightButton(true,true))
               {
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      private function onRightMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.canHandleMouseInput(param1) && this.ignoreEvents == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.listeners.length)
            {
               if(!TargetingInputListener(this.listeners[_loc2_]).mouseRightButton(false,true))
               {
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.canHandleMouseInput(param1) && this.ignoreEvents == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.listeners.length)
            {
               TargetingInputListener(this.listeners[_loc2_]).mouseWheel(param1.delta);
               _loc2_++;
            }
         }
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.canHandleMouseInput(param1) && this.ignoreEvents == 0)
         {
            if(this.firstRelativeMove)
            {
               this.firstRelativeMove = false;
               return;
            }
            if(fullScreenService.isMouseLocked())
            {
               _loc2_ = 0;
               while(_loc2_ < this.listeners.length)
               {
                  TargetingInputListener(this.listeners[_loc2_]).mouseRelativeMovement(param1[MOVEMENT_X],param1[MOVEMENT_Y]);
                  _loc2_++;
               }
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < this.listeners.length)
               {
                  TargetingInputListener(this.listeners[_loc2_]).mouseAbsoluteMovement(param1.stageX,param1.stageY);
                  _loc2_++;
               }
            }
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this.currentMouseButtonState = true;
         if(this.canHandleMouseInput(param1) && this.ignoreEvents == 0)
         {
            this.storedMouseButtonState = true;
            this.broadcastMouseButtonEvent(true,true);
         }
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         this.currentMouseButtonState = false;
         if(this.canHandleMouseInput(param1) && this.ignoreEvents == 0)
         {
            this.storedMouseButtonState = false;
            this.broadcastMouseButtonEvent(false,true);
         }
      }
      
      private function broadcastMouseButtonEvent(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < this.listeners.length)
         {
            if(!TargetingInputListener(this.listeners[_loc3_]).mouseLeftButton(param1,param2))
            {
               return;
            }
            _loc3_++;
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         if(this.canHandleKeyboardInput(param1) && this.ignoreEvents == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.listeners.length)
            {
               if(!TargetingInputListener(this.listeners[_loc2_]).keyboardButton(param1.keyCode,true))
               {
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         if(this.canHandleKeyboardInput(param1) && this.ignoreEvents == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.listeners.length)
            {
               if(!TargetingInputListener(this.listeners[_loc2_]).keyboardButton(param1.keyCode,false))
               {
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      private function onActivate(param1:Event) : void
      {
         if(!this.active)
         {
            this.activate = true;
            this.ignoreInput();
         }
      }
      
      private function onDeactivate(param1:Event) : void
      {
         this.active = false;
      }
      
      public function tick() : void
      {
         if(this.initied && this.active)
         {
            if(this.somethingWasOnScreen && !this.isSomethingOnScreen())
            {
               if(this.mouseWasLocked)
               {
                  this.requestMouseLock();
               }
            }
            else if(!this.somethingWasOnScreen && this.isSomethingOnScreen())
            {
               if(this.isInFullscreen())
               {
                  display.stage[MOUSE_LOCK] = false;
               }
            }
            this.somethingWasOnScreen = this.isSomethingOnScreen();
            if(this.ignoreEvents > 0)
            {
               --this.ignoreEvents;
            }
         }
         if(this.activate)
         {
            this.active = true;
            this.activate = false;
            if(this.isInFullscreen() && this.mouseWasLocked)
            {
               this.requestMouseLock();
            }
         }
      }
      
      public function addListener(param1:TargetingInputListener) : void
      {
         if(this.listeners.indexOf(param1) < 0)
         {
            this.listeners.push(param1);
         }
      }
      
      public function removeListener(param1:TargetingInputListener) : void
      {
         this.listeners.splice(this.listeners.indexOf(param1),1);
      }
      
      public function startDialog() : void
      {
         this.doStartDialog(false);
      }
      
      public function startDialogWithAllowedKeyboardInput() : void
      {
         this.doStartDialog(true);
      }
      
      private function doStartDialog(param1:Boolean) : void
      {
         if(this.initied)
         {
            this.allowKeyboard = param1;
            ++this.dialogCount;
            if(this.dialogCount == 1)
            {
               battleEventDispatcher.dispatchEvent(new TargetingInputModeChangedEvent(false,param1));
            }
         }
      }
      
      private function isInFullscreen() : Boolean
      {
         return display.stage.displayState != StageDisplayState.NORMAL;
      }
      
      public function endDialog() : void
      {
         if(this.initied)
         {
            --this.dialogCount;
            if(this.dialogCount <= 0)
            {
               this.dialogCount = 0;
               battleEventDispatcher.dispatchEvent(new TargetingInputModeChangedEvent(true,this.allowKeyboard));
               this.allowKeyboard = false;
               if(this.currentMouseButtonState != this.storedMouseButtonState)
               {
                  if(!this.isSomethingOnScreen())
                  {
                     this.broadcastMouseButtonEvent(this.currentMouseButtonState,false);
                  }
                  this.storedMouseButtonState = this.currentMouseButtonState;
               }
            }
         }
      }
      
      public function requestMouseLock() : void
      {
         if(this.initied)
         {
            if(!this.isSomethingOnScreen())
            {
               fullScreenService.requestMouseLock();
            }
            else
            {
               this.mouseWasLocked = true;
            }
            if(fullScreenService.isMouseLocked())
            {
               this.broadcastMouseLock(true);
               this.firstRelativeMove = true;
               this.mouseWasLocked = true;
            }
         }
      }
      
      private function isSomethingOnScreen() : Boolean
      {
         return this.dialogCount > 0 || this.isOtherWindowOnScreen();
      }
      
      private function isOtherWindowOnScreen() : Boolean
      {
         return !lobbyLayout.inBattle() || Boolean(lobbyLayout.isSwitchInProgress()) || Boolean(lobbyLayout.isWindowOpenOverBattle()) || this.inFullScreenDialog;
      }
      
      private function canHandleMouseInput(param1:MouseEvent) : Boolean
      {
         return !battleInputService.isInputLocked() && this.canAcceptMouseEvent(param1);
      }
      
      private function canHandleKeyboardInput(param1:KeyboardEvent) : Boolean
      {
         return !battleInputService.isInputLocked() && !this.pause && (!this.isOtherWindowOnScreen() || this.allowKeyboard);
      }
      
      private function canAcceptMouseEvent(param1:MouseEvent) : Boolean
      {
         var _loc2_:Boolean = !(param1.target is Stage);
         return this.active && !this.pause && !_loc2_ && !this.isSomethingOnScreen();
      }
      
      public function unlockMouse() : void
      {
         if(this.isInFullscreen())
         {
            display.stage[MOUSE_LOCK] = false;
            this.broadcastMouseLock(false);
            this.mouseWasLocked = false;
         }
      }
      
      private function broadcastMouseLock(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.listeners.length)
         {
            TargetingInputListener(this.listeners[_loc2_]).mouseLocked(param1);
            _loc2_++;
         }
      }
      
      public function ignoreInput(param1:int = 1) : void
      {
         this.ignoreEvents = param1;
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         if(param1 is PauseActivationEvent)
         {
            this.pause = true;
         }
         else if(param1 is PauseDeactivationEvent)
         {
            this.pause = false;
         }
      }
   }
}

