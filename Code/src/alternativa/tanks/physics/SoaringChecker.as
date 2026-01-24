package alternativa.tanks.physics
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.PhysicsMaterial;
   import alternativa.physics.ShapeContact;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.TankConst;
   
   public class SoaringChecker
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const HALF_WHEEL_SIZE:Number = 12.5;
      
      private static const contacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();
      
      private var tank:Tank;
      
      private var testSoaringCollisionBox:CollisionBox;
      
      private var wasSoaring:Boolean;
      
      private var soaring:Boolean;
      
      private var staticIsNear:Boolean;
      
      public function SoaringChecker(param1:TankBody)
      {
         super();
         this.tank = param1.body.tank;
         var _loc2_:Vector3 = this.tank.getMainCollisionBox().hs.clone();
         _loc2_.z += HALF_WHEEL_SIZE;
         this.testSoaringCollisionBox = new CollisionBox(_loc2_,-1,PhysicsMaterial.DEFAULT_MATERIAL);
         this.testSoaringCollisionBox.body = this.tank.getBody();
      }
      
      public function updateSoaring() : void
      {
         var _loc3_:ShapeContact = null;
         var _loc4_:Number = NaN;
         this.wasSoaring = this.soaring;
         this.updateSoaringCollisionBox();
         var _loc1_:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         _loc1_.getShapeContactsWithStatic(this.testSoaringCollisionBox,contacts);
         var _loc2_:Number = 0;
         for each(_loc3_ in contacts)
         {
            if(_loc3_.shape1 == this.testSoaringCollisionBox)
            {
               _loc4_ = _loc3_.normal.dot(Vector3.Z_AXIS);
            }
            else
            {
               _loc4_ = _loc3_.normal.dot(Vector3.DOWN);
            }
            _loc2_ = Math.max(_loc2_,_loc4_);
            _loc3_.dispose();
         }
         this.staticIsNear = contacts.length > 0;
         contacts.length = 0;
         this.soaring = _loc2_ < TankConst.MAX_SLOPE_ANGLE_COS;
      }
      
      private function updateSoaringCollisionBox() : void
      {
         var _loc1_:CollisionBox = this.tank.getMainCollisionBox();
         var _loc2_:Matrix4 = this.testSoaringCollisionBox.transform;
         _loc2_.copy(_loc1_.transform);
         _loc2_.m03 -= _loc2_.m02 * HALF_WHEEL_SIZE;
         _loc2_.m13 -= _loc2_.m12 * HALF_WHEEL_SIZE;
         _loc2_.m23 -= _loc2_.m22 * HALF_WHEEL_SIZE;
         this.testSoaringCollisionBox.calculateAABB();
      }
      
      public function isSoaring() : Boolean
      {
         return this.soaring;
      }
      
      public function isJumpBegin() : Boolean
      {
         return this.soaring && !this.wasSoaring;
      }
      
      public function isJumpEnd() : Boolean
      {
         return this.wasSoaring && !this.soaring;
      }
      
      public function isElasticStaticCollisionWhenSoaring() : Boolean
      {
         return this.soaring && this.staticIsNear;
      }
   }
}

