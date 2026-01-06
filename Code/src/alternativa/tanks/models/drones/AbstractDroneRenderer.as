package alternativa.tanks.models.drones
{
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.utils.MathUtils;
   import flash.utils.getTimer;
   
   public class AbstractDroneRenderer implements DroneRenderer
   {
      
      private var rotationSpeed:Number;
      
      private var settings:ISettingsService;
      
      protected var isLocal:Boolean;
      
      protected var battleService:BattleService;
      
      protected var drone:Drone;
      
      protected var tankSkin:TankSkin;
      
      protected var turretSkin:Object3D;
      
      protected var basePosition:Vector3;
      
      protected var targetAlpha:* = 1;
      
      protected var alpha:* = 0;
      
      protected var startTime:* = 0;
      
      private const MAX_ANGLE:* = 2.356194490192345;
      
      private var rayHit:* = new RayHit();
      
      private var direction:* = new Vector3();
      
      private var normalizedDirection:* = new Vector3();
      
      private var matrix4:* = new Matrix4();
      
      private var LOCAL_DRONE_OFFSET:* = new Vector3(100,-100,100);
      
      private var POSITION_FOR_REMOTE_DRONE:* = new Vector3(0,0,300);
      
      public function AbstractDroneRenderer(param1:Boolean, param2:TankSkin, param3:Drone, param4:BattleService, param5:ISettingsService)
      {
         super();
         this.isLocal = param1;
         this.drone = param3;
         this.battleService = param4;
         this.settings = param5;
         this.tankSkin = param2;
         this.turretSkin = param2.getTurret3D();
         this.basePosition = param1 ? param2.getTurretDescriptor().flagMountPoint.clone().add(this.LOCAL_DRONE_OFFSET) : this.POSITION_FOR_REMOTE_DRONE;
      }
      
      public function start() : void
      {
         this.stop();
         this.startTime = getTimer();
         this.drone.setCurrentRenderer(this);
         this.battleService.getBattleScene3D().addRenderer(this);
      }
      
      public function stop() : void
      {
         if(Boolean(this.drone.getCurrentRenderer()))
         {
            this.battleService.getBattleScene3D().removeRenderer(this.drone.getCurrentRenderer());
            this.drone.setCurrentRenderer(null);
         }
      }
      
      internal function updateVisibility() : void
      {
         var _loc1_:* = !this.isTankOccluded() && this.drone.isTankActive() ? 1 : -1;
         this.alpha += 0.1 * _loc1_;
         if(this.alpha > 1)
         {
            this.alpha = 1;
         }
         else if(this.alpha < 0.1)
         {
            this.alpha = 0;
         }
         var _loc2_:Object3D = this.drone.getObject3D();
         _loc2_.alpha = this.targetAlpha * this.alpha;
         _loc2_.visible = _loc2_.alpha > 0.1;
         if(!this.drone.isTankActive() && !_loc2_.visible)
         {
            this.stop();
         }
      }
      
      private function isTankOccluded() : Boolean
      {
         if(this.isLocal)
         {
            return false;
         }
         var _loc1_:* = this.battleService.getBattleScene3D().getCamera().position;
         var _loc2_:* = this.tankSkin.getTurretSkin().getTurret3D();
         this.direction.reset(_loc2_.x,_loc2_.y,_loc2_.z);
         this.direction.subtract(_loc1_);
         this.normalizedDirection.copy(this.direction).normalize();
         var _loc3_:TanksCollisionDetector = this.battleService.getBattleRunner().getCollisionDetector();
         return _loc3_.raycastStatic(_loc1_,this.normalizedDirection,CollisionGroup.STATIC,this.direction.length(),null,this.rayHit);
      }
      
      internal function setPositionAndRotation(param1:int, param2:int) : *
      {
         var _loc5_:* = undefined;
         var _loc8_:* = undefined;
         var _loc3_:* = this.battleService.getBattleScene3D().getCamera();
         var _loc4_:Object3D = this.drone.getObject3D();
         _loc4_.x = this.drone.getPosition().x;
         _loc4_.y = this.drone.getPosition().y;
         _loc4_.z = this.drone.getPosition().z;
         _loc4_.rotationX = 0;
         _loc4_.rotationY = 0;
         if(this.isLocal)
         {
            _loc5_ = _loc3_.rotationZ;
         }
         else
         {
            _loc8_ = this.tankSkin.getHullMesh();
            this.matrix4.setRotationMatrix(_loc8_.rotationX,_loc8_.rotationY,_loc8_.rotationZ);
            _loc5_ = -Math.atan2(this.matrix4.m01,this.matrix4.m11);
         }
         var _loc6_:* = this.normalizeAngle(_loc4_.rotationZ,_loc5_) - _loc5_;
         if(Math.abs(_loc6_) < 0.1)
         {
            this.rotationSpeed = 0;
            return;
         }
         if(Math.abs(_loc6_) > this.MAX_ANGLE)
         {
            _loc6_ = MathUtils.sign(_loc6_) * this.MAX_ANGLE;
            _loc4_.rotationZ = _loc5_ + _loc6_;
            return;
         }
         if(Math.abs(_loc6_) > 0.1)
         {
            this.rotationSpeed = 0.008 * _loc6_ / this.MAX_ANGLE;
         }
         var _loc7_:* = this.rotationSpeed * param2;
         _loc4_.rotationZ -= _loc7_;
      }
      
      private function setObjectLookAtCamera(param1:Camera3D) : *
      {
         var _loc2_:Object3D = this.drone.getObject3D();
         var _loc3_:Number = param1.x - _loc2_.x;
         var _loc4_:Number = param1.y - _loc2_.y;
         _loc2_.rotationZ = -Math.atan2(_loc3_,_loc4_);
      }
      
      internal function getTurretMatrix() : Matrix4
      {
         var _loc1_:* = 0;
         if(this.isLocal)
         {
            _loc1_ = this.battleService.getBattleScene3D().getCamera().rotationZ;
            return this.matrix4.setMatrix(this.turretSkin.x,this.turretSkin.y,this.turretSkin.z,0,0,_loc1_);
         }
         return this.matrix4.setMatrix(this.turretSkin.x,this.turretSkin.y,this.turretSkin.z,0,0,0);
      }
      
      private function normalizeAngle(param1:Number, param2:Number) : Number
      {
         return param1 - 2 * Math.PI * Math.floor((param1 + Math.PI - param2) / (2 * Math.PI));
      }
      
      public function render(param1:int, param2:int) : void
      {
      }
   }
}

