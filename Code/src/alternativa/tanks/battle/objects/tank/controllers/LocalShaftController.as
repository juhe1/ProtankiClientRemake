package alternativa.tanks.battle.objects.tank.controllers
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.objects.tank.controllers.targetingstates.ShaftKeyboardAimTargetingState;
   import alternativa.tanks.battle.objects.tank.controllers.targetingstates.ShaftMouseAimTargetingState;
   import alternativa.tanks.models.weapon.shaft.ReticleDisplay;
   import alternativa.tanks.services.targeting.TargetingInputManager;
   import alternativa.tanks.services.targeting.TargetingModeService;
   
   public class LocalShaftController extends LocalTurretController
   {
      
      [Inject] // added
      public static var inputManager:TargetingInputManager;
      
      [Inject] // added
      public static var targetingModeService:TargetingModeService;
      
      private var isAimMode:Boolean = false;
      
      private var aimMouseState:ShaftMouseAimTargetingState;
      
      private var reticleDisplayController:ShaftReticleDisplayController;
      
      private var aimDirection:Vector3 = new Vector3();
      
      private var reticleDisplay:ReticleDisplay;
      
      private var aimKeyboardState:ShaftKeyboardAimTargetingState;
      
      private var aimController:AimController;
      
      public function LocalShaftController(param1:TurretController, param2:ReticleDisplay, param3:Number)
      {
         super(param1);
         this.aimMouseState = new ShaftMouseAimTargetingState(param1,param3);
         this.aimKeyboardState = new ShaftKeyboardAimTargetingState(param1);
         this.reticleDisplayController = new ShaftReticleDisplayController(param2);
         this.reticleDisplay = param2;
      }
      
      public function startAim() : void
      {
         var _loc1_:int = 0;
         if(!this.isAimMode)
         {
            this.isAimMode = true;
            _loc1_ = int(targetingModeService.getCurrentMode());
            targetingModeService.blockModeChange();
            switch(_loc1_)
            {
               case TargetingMode.MOUSE_LOOK:
                  changeState(this.aimMouseState);
                  this.aimController = this.aimMouseState;
                  break;
               case TargetingMode.KEYBOARD:
                  changeState(this.aimKeyboardState);
                  this.aimController = this.aimKeyboardState;
            }
         }
      }
      
      public function stopAim() : void
      {
         if(this.isAimMode)
         {
            this.isAimMode = false;
            targetingModeService.unblockModeChange();
            changeState(getNextTargetingState(targetingModeService.getCurrentMode()));
         }
      }
      
      public function finishAim() : void
      {
         resetSavedTurretState();
      }
      
      override public function tick(param1:Number) : void
      {
         super.tick(param1);
         if(this.isAimMode)
         {
            this.aimController.getAimDirection(this.aimDirection);
            this.reticleDisplayController.update(this.aimDirection);
         }
      }
      
      public function recalculateSpeed(param1:Number) : void
      {
         this.aimMouseState.recalculateSpeed(param1);
      }
      
      public function getAimDirection(param1:Vector3) : void
      {
         this.aimController.getAimDirection(param1);
      }
      
      public function getReticleDisplay() : ReticleDisplay
      {
         return this.reticleDisplay;
      }
   }
}

