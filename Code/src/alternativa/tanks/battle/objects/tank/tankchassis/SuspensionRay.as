package alternativa.tanks.battle.objects.tank.tankchassis
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.objects.tank.TankConst;
   
   public class SuspensionRay
   {
      
      public var collisionGroup:int;
      
      public var hasCollision:Boolean = false;
      
      public var rayHit:RayHit = new RayHit();
      
      public var springForce:Number = 0;
      
      public const contactVelocity:Vector3 = new Vector3();
      
      public var speed:Number = 0;
      
      private var body:Body;
      
      private var origin:Vector3 = new Vector3();
      
      private var direction:Vector3 = new Vector3();
      
      private var suspensionParams:SuspensionParams;
      
      private var globalOrigin:Vector3 = new Vector3();
      
      private var globalDirection:Vector3 = new Vector3();
      
      private var prevCompression:Number = 0;
      
      private var collisionFilter:RayCollisionFilter;
      
      public function SuspensionRay(param1:Body, param2:Vector3, param3:Vector3, param4:SuspensionParams)
      {
         super();
         this.body = param1;
         this.origin.copy(param2);
         this.direction.copy(param3);
         this.suspensionParams = param4;
         this.collisionFilter = new RayCollisionFilter(param1);
      }
      
      public function update(param1:Number) : void
      {
         this.raycast();
         if(this.hasCollision)
         {
            this.calculateSpringForce(param1);
            this.calculateContactVelocity();
         }
      }
      
      private function raycast() : void
      {
         var _loc1_:Matrix3 = this.body.baseMatrix;
         this.globalDirection.x = _loc1_.m00 * this.direction.x + _loc1_.m01 * this.direction.y + _loc1_.m02 * this.direction.z;
         this.globalDirection.y = _loc1_.m10 * this.direction.x + _loc1_.m11 * this.direction.y + _loc1_.m12 * this.direction.z;
         this.globalDirection.z = _loc1_.m20 * this.direction.x + _loc1_.m21 * this.direction.y + _loc1_.m22 * this.direction.z;
         var _loc2_:Vector3 = this.body.state.position;
         this.globalOrigin.x = _loc1_.m00 * this.origin.x + _loc1_.m01 * this.origin.y + _loc1_.m02 * this.origin.z;
         this.globalOrigin.y = _loc1_.m10 * this.origin.x + _loc1_.m11 * this.origin.y + _loc1_.m12 * this.origin.z;
         this.globalOrigin.z = _loc1_.m20 * this.origin.x + _loc1_.m21 * this.origin.y + _loc1_.m22 * this.origin.z;
         this.globalOrigin.x += _loc2_.x;
         this.globalOrigin.y += _loc2_.y;
         this.globalOrigin.z += _loc2_.z;
         if(this.hasCollision)
         {
            this.prevCompression = this.suspensionParams.maxRayLength - this.rayHit.t;
         }
         this.hasCollision = this.body.scene.collisionDetector.raycast(this.globalOrigin,this.globalDirection,this.collisionGroup,this.suspensionParams.maxRayLength,this.collisionFilter,this.rayHit);
         if(this.hasCollision)
         {
            this.hasCollision = this.rayHit.normal.z > TankConst.MAX_SLOPE_ANGLE_COS;
         }
      }
      
      public function calculateSpringForce(param1:Number) : void
      {
         var _loc2_:Number = this.suspensionParams.maxRayLength - this.rayHit.t;
         this.springForce = this.suspensionParams.springCoeff * _loc2_;
         var _loc3_:Number = (_loc2_ - this.prevCompression) / param1;
         this.springForce += _loc3_ * this.suspensionParams.dampingCoeff;
         if(this.springForce < 0)
         {
            this.springForce = 0;
         }
      }
      
      private function calculateContactVelocity() : void
      {
         var _loc2_:Vector3 = null;
         var _loc3_:Vector3 = null;
         var _loc4_:Vector3 = null;
         var _loc5_:Vector3 = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc1_:Body = this.rayHit.shape.body;
         if(_loc1_.tank != null)
         {
            _loc2_ = _loc1_.state.position;
            _loc3_ = _loc1_.state.velocity;
            _loc4_ = _loc1_.state.angularVelocity;
            _loc5_ = this.rayHit.position;
            _loc6_ = _loc5_.x - _loc2_.x;
            _loc7_ = _loc5_.y - _loc2_.y;
            _loc8_ = _loc5_.z - _loc2_.z;
            this.contactVelocity.x = _loc4_.y * _loc8_ - _loc4_.z * _loc7_;
            this.contactVelocity.y = _loc4_.z * _loc6_ - _loc4_.x * _loc8_;
            this.contactVelocity.z = _loc4_.x * _loc7_ - _loc4_.y * _loc6_;
            this.contactVelocity.x += _loc3_.x;
            this.contactVelocity.y += _loc3_.y;
            this.contactVelocity.z += _loc3_.z;
         }
         else
         {
            this.contactVelocity.x = 0;
            this.contactVelocity.y = 0;
            this.contactVelocity.z = 0;
         }
      }
      
      public function getGlobalOrigin() : Vector3
      {
         return this.globalOrigin;
      }
      
      public function getGlobalDirection() : Vector3
      {
         return this.globalDirection;
      }
      
      public function getOrigin() : Vector3
      {
         return this.origin;
      }
   }
}

