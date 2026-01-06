package alternativa.tanks.battle.objects.tank.controllers.targetingstates
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.controllers.AimController;
   import alternativa.tanks.battle.objects.tank.controllers.TargetingState;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.services.targeting.TargetingInputListener;
   import alternativa.tanks.services.targeting.TargetingInputManager;
   import alternativa.tanks.utils.MathUtils;
   
   public class ShaftMouseAimTargetingState implements TargetingState, TargetingInputListener, AimController
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var inputManager:TargetingInputManager;
      
      [Inject]
      public static var localTankInfoService:LocalTankInfoService;
      
      private var haltAim:Boolean = false;
      
      private var turretController:TurretController;
      
      private var maxElevationSpeedPerSec:Number;
      
      private var speed:Number;
      
      private var aimDirection:Vector3 = new Vector3();
      
      private var aimAngle:Number;
      
      private var turretRotationMatrix:Matrix3 = new Matrix3();
      
      private var camera:GameCamera;
      
      public function ShaftMouseAimTargetingState(param1:TurretController, param2:Number)
      {
         super();
         this.turretController = param1;
         this.maxElevationSpeedPerSec = param2;
         this.speed = this.maxElevationSpeedPerSec;
         this.camera = battleService.getBattleScene3D().getCamera();
      }
      
      public function tick(param1:Number) : void
      {
         var _loc2_:Object3D = null;
         var _loc3_:Vector3 = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this.haltAim)
         {
            this.turretController.setControlState(0);
         }
         else
         {
            _loc2_ = localTankInfoService.getTurret3D();
            this.turretRotationMatrix = BattleUtils.tmpMatrix3;
            this.turretRotationMatrix.setRotationMatrixForObject3D(_loc2_);
            _loc3_ = BattleUtils.tmpVector;
            this.turretRotationMatrix.transformVectorInverse(this.camera.zAxis,_loc3_);
            _loc4_ = Math.atan2(-_loc3_.x,_loc3_.y) + this.turretController.getDirection();
            this.turretController.setTargetDirection(_loc4_);
            _loc5_ = Math.atan2(_loc3_.z,_loc3_.y);
            if(Math.abs(_loc5_ - this.aimAngle) > 0.0001)
            {
               _loc6_ = this.speed * param1;
               this.aimAngle = MathUtils.clamp(_loc5_,this.aimAngle - _loc6_,this.aimAngle + _loc6_);
            }
            this.calculateAimDirection();
         }
      }
      
      public function enter() : void
      {
         inputManager.addListener(this);
         this.aimAngle = 0;
         this.haltAim = false;
         this.calculateAimDirection();
      }
      
      public function exit() : void
      {
         inputManager.removeListener(this);
         this.aimAngle = -Math.PI / 2;
         this.aimDirection.x = 0;
         this.aimDirection.y = 0;
         this.aimDirection.z = -1;
      }
      
      public function mouseRightButton(param1:Boolean, param2:Boolean) : Boolean
      {
         this.haltAim = param1;
         return true;
      }
      
      public function getAimDirection(param1:Vector3) : void
      {
         param1.copy(this.aimDirection);
      }
      
      public function recalculateSpeed(param1:Number) : void
      {
         this.speed = this.maxElevationSpeedPerSec * param1;
      }
      
      private function calculateAimDirection() : void
      {
         var _loc1_:Vector3 = BattleUtils.tmpVector;
         _loc1_.reset(0,Math.cos(this.aimAngle),Math.sin(this.aimAngle));
         this.turretRotationMatrix.transformVector(_loc1_,this.aimDirection);
      }
      
      public function mouseAbsoluteMovement(param1:Number, param2:Number) : void
      {
      }
      
      public function mouseRelativeMovement(param1:Number, param2:Number) : void
      {
      }
      
      public function mouseLeftButton(param1:Boolean, param2:Boolean) : Boolean
      {
         return true;
      }
      
      public function mouseWheel(param1:int) : void
      {
      }
      
      public function keyboardButton(param1:uint, param2:Boolean) : Boolean
      {
         return true;
      }
      
      public function mouseLocked(param1:Boolean) : void
      {
      }
   }
}

