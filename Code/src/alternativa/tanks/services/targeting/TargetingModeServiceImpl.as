package alternativa.tanks.services.targeting
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.logging.LogService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.TargetingModeChangedEvent;
   import alternativa.tanks.battle.objects.tank.controllers.TargetingMode;
   import alternativa.tanks.battle.objects.tank.controllers.TurretControlActionMap;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import flash.display.StageDisplayState;
   import flash.events.FullScreenEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenStateService;
   
   public class TargetingModeServiceImpl implements TargetingModeService, TargetingInputListener
   {
      
      [Inject]
      public static var inputManager:TargetingInputManager;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var logService:LogService;
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var fullScreenState:FullscreenStateService;
      
      [Inject]
      public static var fullScreenService:FullscreenService;
      
      [Inject]
      public static var settingsService:ISettingsService;
      
      [Inject]
      public static var keysBindingService:KeysBindingService;
      
      private static const FULL_SCREEN_INTERACTIVE_ACCEPTED:String = "fullScreenInteractiveAccepted";
      
      private static const MOUSE_LOCK:String = "mouseLock";
      
      private var currentTargetingMode:int;
      
      private var nextTargetingMode:int;
      
      private var keyMap:TurretControlActionMap;
      
      private var modeChangeBlocks:int;
      
      public function TargetingModeServiceImpl()
      {
         super();
      }
      
      public function init() : void
      {
         this.currentTargetingMode = TargetingMode.REMOTE;
         this.nextTargetingMode = TargetingMode.KEYBOARD;
         inputManager.addListener(this);
         display.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
         display.stage.addEventListener(FULL_SCREEN_INTERACTIVE_ACCEPTED,this.onFullScreen);
         this.modeChangeBlocks = 0;
         if(fullScreenState.isFullscreen())
         {
            inputManager.requestMouseLock();
         }
      }
      
      public function close() : void
      {
         display.stage.removeEventListener(FULL_SCREEN_INTERACTIVE_ACCEPTED,this.onFullScreen);
         display.stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
         inputManager.removeListener(this);
      }
      
      private function onFullScreen(param1:FullScreenEvent) : void
      {
         if(param1.fullScreen && (param1.type == FULL_SCREEN_INTERACTIVE_ACCEPTED || Boolean(fullScreenService.isStandAlone())) && Boolean(settingsService.mouseControl))
         {
            inputManager.requestMouseLock();
            inputManager.ignoreInput();
         }
         else if(!param1.fullScreen && this.currentTargetingMode == TargetingMode.MOUSE_LOOK)
         {
            this.setTargetingMode(TargetingMode.KEYBOARD);
         }
      }
      
      public function tick() : void
      {
         if(this.currentTargetingMode == TargetingMode.MOUSE_LOOK && !settingsService.mouseControl)
         {
            this.setTargetingMode(TargetingMode.KEYBOARD);
         }
         if(this.nextTargetingMode != this.currentTargetingMode)
         {
            if(this.currentTargetingMode == TargetingMode.MOUSE_LOOK)
            {
               inputManager.unlockMouse();
            }
            this.currentTargetingMode = this.nextTargetingMode;
            battleEventDispatcher.dispatchEvent(new TargetingModeChangedEvent(this.currentTargetingMode));
         }
      }
      
      public function getCurrentMode() : int
      {
         return this.currentTargetingMode;
      }
      
      public function mouseAbsoluteMovement(param1:Number, param2:Number) : void
      {
      }
      
      public function mouseRelativeMovement(param1:Number, param2:Number) : void
      {
      }
      
      public function mouseLeftButton(param1:Boolean, param2:Boolean) : Boolean
      {
         if(!fullScreenService.isMouseLockDisabled() && Boolean(settingsService.mouseControl) && this.modeChangeBlocks == 0 && param1)
         {
            if(this.isInFullscreen() && !fullScreenService.isMouseLocked())
            {
               inputManager.requestMouseLock();
               return false;
            }
            if(param2 && !this.isInFullscreen())
            {
               fullScreenService.switchFullscreen();
               return false;
            }
         }
         return true;
      }
      
      private function isInFullscreen() : Boolean
      {
         return display.stage.displayState != StageDisplayState.NORMAL;
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
         var _loc3_:Boolean = false;
         if(param2 && this.currentTargetingMode != TargetingMode.KEYBOARD && this.keyMap != null)
         {
            _loc3_ = keysBindingService.getBindingAction(param1) == this.keyMap.actionCenter;
            _loc3_ ||= keysBindingService.getBindingAction(param1) == this.keyMap.actionLeft;
            _loc3_ ||= keysBindingService.getBindingAction(param1) == this.keyMap.actionRight;
            if(_loc3_)
            {
               this.setTargetingMode(TargetingMode.KEYBOARD);
               return false;
            }
         }
         return true;
      }
      
      private function checkKey(param1:uint, param2:Vector.<uint>) : Boolean
      {
         return param2 != null ? param2.indexOf(param1) >= 0 : false;
      }
      
      public function mouseLocked(param1:Boolean) : void
      {
         this.setTargetingMode(TargetingMode.MOUSE_LOOK);
         inputManager.ignoreInput();
      }
      
      private function setTargetingMode(param1:int) : void
      {
         if(param1 != this.currentTargetingMode && this.modeChangeBlocks == 0)
         {
            this.nextTargetingMode = param1;
         }
      }
      
      public function setKeyMap(param1:TurretControlActionMap) : void
      {
         this.keyMap = param1;
      }
      
      public function getKeyMap() : TurretControlActionMap
      {
         return this.keyMap;
      }
      
      public function blockModeChange() : void
      {
         ++this.modeChangeBlocks;
      }
      
      public function unblockModeChange() : void
      {
         --this.modeChangeBlocks;
         if(this.modeChangeBlocks < 0)
         {
            this.modeChangeBlocks = 0;
         }
      }
   }
}

