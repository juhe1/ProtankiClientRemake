package alternativa.physics.collision.primitives
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.PhysicsMaterial;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.physics.collision.types.AABB;
   
   public class CollisionSphere extends CollisionShape
   {
      
      public var r:Number = 0;
      
      public function CollisionSphere(param1:Number, param2:int, param3:PhysicsMaterial)
      {
         super(SPHERE,param2,param3);
         this.r = param1;
      }
      
      override public function calculateAABB() : AABB
      {
         var _loc1_:AABB = null;
         var _loc2_:Matrix4 = null;
         _loc1_ = this.aabb;
         _loc2_ = this.transform;
         _loc1_.maxX = _loc2_.m03 + this.r;
         _loc1_.minX = _loc2_.m03 - this.r;
         _loc1_.maxY = _loc2_.m13 + this.r;
         _loc1_.minY = _loc2_.m13 - this.r;
         _loc1_.maxZ = _loc2_.m23 + this.r;
         _loc1_.minZ = _loc2_.m23 - this.r;
         return _loc1_;
      }
      
      override public function raycast(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : Number
      {
         var _loc5_:Matrix4 = this.transform;
         var _loc6_:Number = param1.x - _loc5_.m03;
         var _loc7_:Number = param1.y - _loc5_.m13;
         var _loc8_:Number = param1.z - _loc5_.m23;
         var _loc9_:Number = param2.x * _loc6_ + param2.y * _loc7_ + param2.z * _loc8_;
         if(_loc9_ > 0)
         {
            return -1;
         }
         var _loc10_:Number = param2.x * param2.x + param2.y * param2.y + param2.z * param2.z;
         var _loc11_:Number = _loc9_ * _loc9_ - _loc10_ * (_loc6_ * _loc6_ + _loc7_ * _loc7_ + _loc8_ * _loc8_ - this.r * this.r);
         if(_loc11_ < 0)
         {
            return -1;
         }
         return -(_loc9_ + Math.sqrt(_loc11_)) / _loc10_;
      }
      
      override public function copyFrom(param1:CollisionShape) : CollisionShape
      {
         var _loc2_:CollisionSphere = param1 as CollisionSphere;
         if(_loc2_ == null)
         {
            return this;
         }
         super.copyFrom(_loc2_);
         this.r = _loc2_.r;
         return this;
      }
      
      override protected function createPrimitive() : CollisionShape
      {
         return new CollisionSphere(this.r,collisionGroup,material);
      }
   }
}

