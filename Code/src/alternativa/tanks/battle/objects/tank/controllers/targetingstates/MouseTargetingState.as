package alternativa.tanks.battle.objects.tank.controllers.targetingstates
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.controllers.TargetingState;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.services.targeting.TargetingInputListener;
   import alternativa.tanks.services.targeting.TargetingInputManager;
   import alternativa.tanks.utils.MathUtils;
   import flash.events.Event;
   
   public class MouseTargetingState implements TargetingState, TargetingInputListener
   {
      
      [Inject] // added
      public static var inputService:TargetingInputManager;
      
      [Inject] // added
      public static var localTankInfoService:LocalTankInfoService;
      
      [Inject] // added
      public static var settingsService:ISettingsService;
      
      [Inject] // added
      public static var display:IDisplay;
      
      private static const MOUSE_SENS_MUL:Number = 0.0001;
      
      private static var mouseSensitivity:int = 0;
      
      protected var turretController:TurretController;
      
      private var freeRotation:Number;
      
      private var tankDirection:Number;
      
      private var lookAround:Boolean;
      
      public function MouseTargetingState(param1:TurretController)
      {
         super();
         this.turretController = param1;
         this.freeRotation = 0;
         mouseSensitivity = settingsService.mouseSensitivity;
      }
      
      public function mouseRelativeMovement(param1:Number, param2:Number) : void
      {
         this.freeRotation -= param1 * mouseSensitivity * MOUSE_SENS_MUL;
         this.freeRotation = MathUtils.clampAngle(this.freeRotation);
      }
      
      public function keyboardButton(param1:uint, param2:Boolean) : Boolean
      {
         return true;
      }
      
      public function tick(param1:Number) : void
      {
         var _loc2_:Tank = localTankInfoService.getLocalTank();
         this.tankDirection = _loc2_.getTankDirection();
         if(!this.lookAround)
         {
            this.setTargetDirection();
         }
         this.turretController.setCameraRotation(this.freeRotation);
      }
      
      protected function setTargetDirection() : void
      {
         this.turretController.setTargetDirection(this.freeRotation - this.tankDirection);
      }
      
      public function enter() : void
      {
         inputService.addListener(this);
         display.stage.addEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
         mouseSensitivity = settingsService.mouseSensitivity;
         var _loc1_:Tank = localTankInfoService.getLocalTank();
         this.tankDirection = _loc1_.getTankDirection();
         this.freeRotation = MathUtils.clampAngle(this.tankDirection + this.getTurretZRotation());
         this.setTargetDirection();
         this.turretController.setCameraRotation(this.freeRotation);
         this.lookAround = false;
      }
      
      protected function getTurretZRotation() : Number
      {
         return this.turretController.getDirection();
      }
      
      public function exit() : void
      {
         display.stage.removeEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
         inputService.removeListener(this);
         this.turretController.resetCameraRotation();
         this.turretController.resetSavedKeyStates();
      }
      
      private function onMouseLeave(param1:Event) : void
      {
         this.lookAround = false;
      }
      
      public function mouseAbsoluteMovement(param1:Number, param2:Number) : void
      {
      }
      
      public function mouseLeftButton(param1:Boolean, param2:Boolean) : Boolean
      {
         return true;
      }
      
      public function mouseWheel(param1:int) : void
      {
      }
      
      public function mouseRightButton(param1:Boolean, param2:Boolean) : Boolean
      {
         this.lookAround = param1;
         this.turretController.stopCameraRotation();
         return true;
      }
      
      public function mouseLocked(param1:Boolean) : void
      {
      }
   }
}

