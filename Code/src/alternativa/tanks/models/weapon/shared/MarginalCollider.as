package alternativa.tanks.models.weapon.shared
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.PhysicsMaterial;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.physics.TanksCollisionDetector;
   
   public class MarginalCollider
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const BOX_HALFSIZE:Number = 6.5;
      
      private static const midPoint:Vector3 = new Vector3();
      
      private static const halfSize:Vector3 = new Vector3();
      
      private static const direction:Vector3 = new Vector3();
      
      private static const axis:Vector3 = new Vector3();
      
      private static const COS_ONE_DEGREE:Number = Math.cos(Math.PI / 180);
      
      private static const collisionBox:CollisionBox = new CollisionBox(new Vector3(1,1,1),CollisionGroup.STATIC,PhysicsMaterial.DEFAULT_MATERIAL);
      
      public function MarginalCollider()
      {
         super();
      }
      
      public static function segmentWithStaticIntersection(param1:Vector3, param2:Vector3) : Boolean
      {
         setupCollisionBox(param1,param2);
         var _loc3_:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         return _loc3_.testStaticCollision(collisionBox);
      }
      
      private static function setupCollisionBox(param1:Vector3, param2:Vector3) : void
      {
         halfSize.diff(param1,param2);
         halfSize.y = halfSize.length() / 2;
         halfSize.x = BOX_HALFSIZE;
         halfSize.z = BOX_HALFSIZE;
         collisionBox.hs.copy(halfSize);
         midPoint.sum(param1,param2);
         midPoint.scale(0.5);
         var _loc3_:Matrix4 = collisionBox.transform;
         _loc3_.toIdentity();
         _loc3_.setPosition(midPoint);
         direction.diff(param2,param1);
         direction.normalize();
         var _loc4_:Number = direction.dot(Vector3.Y_AXIS);
         if(Math.abs(direction.y) < COS_ONE_DEGREE)
         {
            axis.cross2(Vector3.Y_AXIS,direction);
            axis.normalize();
            _loc3_.fromAxisAngle(axis,Math.acos(_loc4_));
         }
         collisionBox.calculateAABB();
      }
   }
}

