package alternativa.tanks.battle
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import flash.geom.Vector3D;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class BattleUtils
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      public static const tmpVector:Vector3 = new Vector3();
      
      public static const tmpMatrix3:Matrix3 = new Matrix3();
      
      private static const hundred:EncryptedInt = new EncryptedIntImpl(100);
      
      private static const _direction:Vector3 = new Vector3();
      
      private static const _rayHit:RayHit = new RayHit();
      
      private static const TURN_THRESHOLD:Number = 0.22;
      
      public function BattleUtils()
      {
         super();
      }
      
      public static function toClientScale(param1:Number) : Number
      {
         return param1 * hundred.getInt();
      }
      
      public static function getOtherTeam(param1:BattleTeam) : BattleTeam
      {
         return param1 == BattleTeam.BLUE ? BattleTeam.RED : BattleTeam.BLUE;
      }
      
      public static function isFiniteVector3d(param1:Vector3d) : Boolean
      {
         return param1 != null && isFinite(param1.x) && isFinite(param1.y) && isFinite(param1.z);
      }
      
      public static function getVector3d(param1:Vector3) : Vector3d
      {
         return new Vector3d(param1.x,param1.y,param1.z);
      }
      
      public static function getVector3dOrNull(param1:Vector3) : Vector3d
      {
         return param1 == null ? null : new Vector3d(param1.x,param1.y,param1.z);
      }
      
      public static function copyToVector3d(param1:Vector3, param2:Vector3d) : void
      {
         param2.x = param1.x;
         param2.y = param1.y;
         param2.z = param1.z;
      }
      
      public static function copyVector3d(param1:Vector3d, param2:Vector3d) : void
      {
         param2.x = param1.x;
         param2.y = param1.y;
         param2.z = param1.z;
      }
      
      public static function getVector3(param1:Vector3d) : Vector3
      {
         return new Vector3(param1.x,param1.y,param1.z);
      }
      
      public static function getVector3OrNull(param1:Vector3d) : Vector3
      {
         return param1 == null ? null : new Vector3(param1.x,param1.y,param1.z);
      }
      
      public static function copyToVector3(param1:Vector3d, param2:Vector3) : void
      {
         param2.x = param1.x;
         param2.y = param1.y;
         param2.z = param1.z;
      }
      
      public static function copyToVector3D(param1:Vector3, param2:Vector3D) : void
      {
         param2.x = param1.x;
         param2.y = param1.y;
         param2.z = param1.z;
      }
      
      public static function globalToLocal(param1:Body, param2:Vector3) : void
      {
         param2.subtract(param1.state.position);
         param2.transformTransposed3(param1.baseMatrix);
      }
      
      public static function localToGlobal(param1:Body, param2:Vector3) : void
      {
         param2.transform3(param1.baseMatrix);
         param2.add(param1.state.position);
      }
      
      public static function parseNumber(param1:String, param2:Number = 0) : Number
      {
         var _loc3_:Number = Number(param1);
         return isNaN(_loc3_) ? param2 : _loc3_;
      }
      
      public static function traceObject(param1:Object, param2:Array) : String
      {
         return "";
      }
      
      public static function isTankBody(param1:Body) : Boolean
      {
         return param1 != null && param1.tank != null;
      }
      
      public static function isTurretAboveGround(param1:Body, param2:AllGlobalGunParams) : Boolean
      {
         var _loc4_:CollisionDetector = null;
         var _loc3_:Vector3 = param1.state.position;
         _direction.diff(param2.barrelOrigin,_loc3_);
         if(param1.scene != null)
         {
            _loc4_ = param1.scene.collisionDetector;
            return !_loc4_.raycastStatic(_loc3_,_direction,CollisionGroup.STATIC,1,null,_rayHit);
         }
         return false;
      }
      
      public static function barrelCollidesWithStatic(param1:AllGlobalGunParams) : Boolean
      {
         var _loc2_:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         var _loc3_:Number = Vector3.distanceBetween(param1.barrelOrigin,param1.muzzlePosition);
         return _loc2_.raycastStatic(param1.barrelOrigin,param1.direction,CollisionGroup.STATIC,_loc3_,null,_rayHit);
      }
      
      public static function getTargetPosition(param1:Tank) : TargetPosition
      {
         var _loc2_:TargetPosition = new TargetPosition();
         _loc2_.target = param1.getUser();
         _loc2_.position = BattleUtils.getVector3d(param1.getBody().state.position);
         param1.getBody().state.orientation.getEulerAngles(tmpVector);
         _loc2_.orientation = getVector3d(tmpVector);
         _loc2_.turretAngle = param1.getTurretDirection();
         return _loc2_;
      }
      
      public static function getTargetsPositions(param1:Vector.<Tank>) : Vector.<TargetPosition>
      {
         var _loc2_:Vector.<TargetPosition> = new Vector.<TargetPosition>(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_] = getTargetPosition(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function isVector3dNaN(param1:Vector3d) : Boolean
      {
         return isNaN(param1.x) || isNaN(param1.y) || isNaN(param1.z);
      }
      
      public static function isTurnedOver(param1:Body) : Boolean
      {
         return param1.baseMatrix.m22 < TURN_THRESHOLD;
      }
      
      public static function getVector3dVector(param1:Vector.<Vector3>) : Vector.<Vector3d>
      {
         var _loc2_:Vector.<Vector3d> = new Vector.<Vector3d>(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_] = getVector3d(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

