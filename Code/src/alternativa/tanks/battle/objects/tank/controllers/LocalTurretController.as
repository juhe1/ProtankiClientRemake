package alternativa.tanks.battle.objects.tank.controllers
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.TargetingModeChangedEvent;
   import alternativa.tanks.battle.objects.tank.controllers.targetingstates.KeyboardTargetingState;
   import alternativa.tanks.battle.objects.tank.controllers.targetingstates.MouseTargetingState;
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import alternativa.tanks.services.targeting.TargetingModeService;
   import flash.events.Event;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class LocalTurretController implements BattleEventListener, Renderer, AutoClosable
   {
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var battleInputLockService:BattleInputService;
      
      [Inject] // added
      public static var localTankInfoService:LocalTankInfoService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject] // added
      public static var targetingService:TargetingModeService;
      
      private var lookAround:Boolean = false;
      
      private var ignoreFirstMovement:Boolean = false;
      
      private var keyboardState:KeyboardTargetingState;
      
      private var mouseState:MouseTargetingState;
      
      private var currentState:TargetingState = null;
      
      private var nextState:TargetingState = null;
      
      private var turretController:TurretController;
      
      private var resetState:Boolean;
      
      public function LocalTurretController(param1:TurretController)
      {
         super();
         this.turretController = param1;
         display.stage.addEventListener(Event.DEACTIVATE,this.onClientWindowDeactivate);
         battleEventDispatcher.addBattleEventListener(TargetingModeChangedEvent,this);
         this.keyboardState = new KeyboardTargetingState(param1);
         this.mouseState = this.createMouseTargetingState(param1);
         this.changeState(this.getNextTargetingState(targetingService.getCurrentMode()));
         battleService.getBattleScene3D().addRenderer(this);
      }
      
      protected function createMouseTargetingState(param1:TurretController) : MouseTargetingState
      {
         return new MouseTargetingState(param1);
      }
      
      public function render(param1:int, param2:int) : void
      {
         this.tick(param2 * 0.001);
      }
      
      public function tick(param1:Number) : void
      {
         if(this.nextState != null)
         {
            if(this.currentState != null)
            {
               this.currentState.exit();
            }
            this.turretController.stopCameraRotation();
            this.currentState = this.nextState;
            this.currentState.enter();
            this.nextState = null;
         }
         if(this.currentState != null)
         {
            if(this.resetState)
            {
               this.currentState.exit();
               this.currentState.enter();
               this.resetState = false;
            }
            this.currentState.tick(param1);
         }
      }
      
      private function onClientWindowDeactivate(param1:Event) : void
      {
         this.lookAround = false;
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         display.stage.removeEventListener(Event.DEACTIVATE,this.onClientWindowDeactivate);
         battleEventDispatcher.removeBattleEventListener(TargetingModeChangedEvent,this);
         battleService.getBattleScene3D().removeRenderer(this);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:TargetingModeChangedEvent = param1 as TargetingModeChangedEvent;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.targetingMode;
            this.changeState(this.getNextTargetingState(_loc3_));
         }
      }
      
      protected function changeState(param1:TargetingState) : void
      {
         this.nextState = param1;
      }
      
      protected function getNextTargetingState(param1:int) : TargetingState
      {
         switch(param1)
         {
            case TargetingMode.KEYBOARD:
               return this.keyboardState;
            case TargetingMode.MOUSE_LOOK:
               return this.mouseState;
            default:
               return null;
         }
      }
      
      public function getTurretController() : TurretController
      {
         return this.turretController;
      }
      
      public function resetSavedTurretState() : void
      {
         this.turretController.resetSavedKeyStates();
         this.turretController.setControlState(0);
      }
      
      public function reset() : void
      {
         this.resetSavedTurretState();
         this.resetState = true;
      }
   }
}

