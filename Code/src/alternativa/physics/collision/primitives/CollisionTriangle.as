package alternativa.physics.collision.primitives
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.PhysicsMaterial;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.physics.collision.types.AABB;
   
   public class CollisionTriangle extends CollisionShape
   {
      
      public var v0:Vector3 = new Vector3();
      
      public var v1:Vector3 = new Vector3();
      
      public var v2:Vector3 = new Vector3();
      
      public var e0:Vector3 = new Vector3();
      
      public var e1:Vector3 = new Vector3();
      
      public var e2:Vector3 = new Vector3();
      
      public function CollisionTriangle(param1:Vector3, param2:Vector3, param3:Vector3, param4:int, param5:PhysicsMaterial)
      {
         super(TRIANGLE,param4,param5);
         this.initVertices(param1,param2,param3);
      }
      
      override public function calculateAABB() : AABB
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:AABB = this.aabb;
         var _loc2_:Matrix4 = this.transform;
         var _loc3_:Number = 0.005;
         var _loc6_:Number = _loc3_ * _loc2_.m02;
         var _loc7_:Number = _loc3_ * _loc2_.m12;
         var _loc8_:Number = _loc3_ * _loc2_.m22;
         _loc4_ = this.v0.x * _loc2_.m00 + this.v0.y * _loc2_.m01;
         _loc1_.minX = _loc1_.maxX = _loc4_ + _loc6_;
         _loc5_ = _loc4_ - _loc6_;
         if(_loc5_ > _loc1_.maxX)
         {
            _loc1_.maxX = _loc5_;
         }
         else if(_loc5_ < _loc1_.minX)
         {
            _loc1_.minX = _loc5_;
         }
         _loc4_ = this.v0.x * _loc2_.m10 + this.v0.y * _loc2_.m11;
         _loc1_.minY = _loc1_.maxY = _loc4_ + _loc7_;
         _loc5_ = _loc4_ - _loc7_;
         if(_loc5_ > _loc1_.maxY)
         {
            _loc1_.maxY = _loc5_;
         }
         else if(_loc5_ < _loc1_.minY)
         {
            _loc1_.minY = _loc5_;
         }
         _loc4_ = this.v0.x * _loc2_.m20 + this.v0.y * _loc2_.m21;
         _loc1_.minZ = _loc1_.maxZ = _loc4_ + _loc8_;
         _loc5_ = _loc4_ - _loc8_;
         if(_loc5_ > _loc1_.maxZ)
         {
            _loc1_.maxZ = _loc5_;
         }
         else if(_loc5_ < _loc1_.minZ)
         {
            _loc1_.minZ = _loc5_;
         }
         _loc4_ = this.v1.x * _loc2_.m00 + this.v1.y * _loc2_.m01;
         _loc5_ = _loc4_ + _loc6_;
         if(_loc5_ > _loc1_.maxX)
         {
            _loc1_.maxX = _loc5_;
         }
         else if(_loc5_ < _loc1_.minX)
         {
            _loc1_.minX = _loc5_;
         }
         _loc5_ = _loc4_ - _loc6_;
         if(_loc5_ > _loc1_.maxX)
         {
            _loc1_.maxX = _loc5_;
         }
         else if(_loc5_ < _loc1_.minX)
         {
            _loc1_.minX = _loc5_;
         }
         _loc4_ = this.v1.x * _loc2_.m10 + this.v1.y * _loc2_.m11;
         _loc5_ = _loc4_ + _loc7_;
         if(_loc5_ > _loc1_.maxY)
         {
            _loc1_.maxY = _loc5_;
         }
         else if(_loc5_ < _loc1_.minY)
         {
            _loc1_.minY = _loc5_;
         }
         _loc5_ = _loc4_ - _loc7_;
         if(_loc5_ > _loc1_.maxY)
         {
            _loc1_.maxY = _loc5_;
         }
         else if(_loc5_ < _loc1_.minY)
         {
            _loc1_.minY = _loc5_;
         }
         _loc4_ = this.v1.x * _loc2_.m20 + this.v1.y * _loc2_.m21;
         _loc5_ = _loc4_ + _loc8_;
         if(_loc5_ > _loc1_.maxZ)
         {
            _loc1_.maxZ = _loc5_;
         }
         else if(_loc5_ < _loc1_.minZ)
         {
            _loc1_.minZ = _loc5_;
         }
         _loc5_ = _loc4_ - _loc8_;
         if(_loc5_ > _loc1_.maxZ)
         {
            _loc1_.maxZ = _loc5_;
         }
         else if(_loc5_ < _loc1_.minZ)
         {
            _loc1_.minZ = _loc5_;
         }
         _loc4_ = this.v2.x * _loc2_.m00 + this.v2.y * _loc2_.m01;
         _loc5_ = _loc4_ + _loc6_;
         if(_loc5_ > _loc1_.maxX)
         {
            _loc1_.maxX = _loc5_;
         }
         else if(_loc5_ < _loc1_.minX)
         {
            _loc1_.minX = _loc5_;
         }
         _loc5_ = _loc4_ - _loc6_;
         if(_loc5_ > _loc1_.maxX)
         {
            _loc1_.maxX = _loc5_;
         }
         else if(_loc5_ < _loc1_.minX)
         {
            _loc1_.minX = _loc5_;
         }
         _loc4_ = this.v2.x * _loc2_.m10 + this.v2.y * _loc2_.m11;
         _loc5_ = _loc4_ + _loc7_;
         if(_loc5_ > _loc1_.maxY)
         {
            _loc1_.maxY = _loc5_;
         }
         else if(_loc5_ < _loc1_.minY)
         {
            _loc1_.minY = _loc5_;
         }
         _loc5_ = _loc4_ - _loc7_;
         if(_loc5_ > _loc1_.maxY)
         {
            _loc1_.maxY = _loc5_;
         }
         else if(_loc5_ < _loc1_.minY)
         {
            _loc1_.minY = _loc5_;
         }
         _loc4_ = this.v2.x * _loc2_.m20 + this.v2.y * _loc2_.m21;
         _loc5_ = _loc4_ + _loc8_;
         if(_loc5_ > _loc1_.maxZ)
         {
            _loc1_.maxZ = _loc5_;
         }
         else if(_loc5_ < _loc1_.minZ)
         {
            _loc1_.minZ = _loc5_;
         }
         _loc5_ = _loc4_ - _loc8_;
         if(_loc5_ > _loc1_.maxZ)
         {
            _loc1_.maxZ = _loc5_;
         }
         else if(_loc5_ < _loc1_.minZ)
         {
            _loc1_.minZ = _loc5_;
         }
         _loc1_.minX += _loc2_.m03;
         _loc1_.maxX += _loc2_.m03;
         _loc1_.minY += _loc2_.m13;
         _loc1_.maxY += _loc2_.m13;
         _loc1_.minZ += _loc2_.m23;
         _loc1_.maxZ += _loc2_.m23;
         return _loc1_;
      }
      
      override public function raycast(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : Number
      {
         var _loc5_:Matrix4 = null;
         _loc5_ = this.transform;
         var _loc6_:Number = param2.x * _loc5_.m02 + param2.y * _loc5_.m12 + param2.z * _loc5_.m22;
         if(_loc6_ < param3 && _loc6_ > -param3)
         {
            return -1;
         }
         var _loc7_:Number = param1.x - _loc5_.m03;
         var _loc8_:Number = param1.y - _loc5_.m13;
         var _loc9_:Number = param1.z - _loc5_.m23;
         var _loc10_:Number = _loc7_ * _loc5_.m02 + _loc8_ * _loc5_.m12 + _loc9_ * _loc5_.m22;
         var _loc11_:Number = -_loc10_ / _loc6_;
         if(_loc11_ < 0)
         {
            return -1;
         }
         var _loc12_:Number = _loc7_ * _loc5_.m00 + _loc8_ * _loc5_.m10 + _loc9_ * _loc5_.m20;
         var _loc13_:Number = _loc7_ * _loc5_.m01 + _loc8_ * _loc5_.m11 + _loc9_ * _loc5_.m21;
         _loc7_ = _loc12_ + _loc11_ * (param2.x * _loc5_.m00 + param2.y * _loc5_.m10 + param2.z * _loc5_.m20);
         _loc8_ = _loc13_ + _loc11_ * (param2.x * _loc5_.m01 + param2.y * _loc5_.m11 + param2.z * _loc5_.m21);
         if(this.e0.x * (_loc8_ - this.v0.y) - this.e0.y * (_loc7_ - this.v0.x) < 0 || this.e1.x * (_loc8_ - this.v1.y) - this.e1.y * (_loc7_ - this.v1.x) < 0 || this.e2.x * (_loc8_ - this.v2.y) - this.e2.y * (_loc7_ - this.v2.x) < 0)
         {
            return -1;
         }
         if(param2.x * _loc5_.m02 + param2.y * _loc5_.m12 + param2.z * _loc5_.m22 > 0)
         {
            param4.x = -_loc5_.m02;
            param4.y = -_loc5_.m12;
            param4.z = -_loc5_.m22;
         }
         else
         {
            param4.x = _loc5_.m02;
            param4.y = _loc5_.m12;
            param4.z = _loc5_.m22;
         }
         return _loc11_;
      }
      
      override public function copyFrom(param1:CollisionShape) : CollisionShape
      {
         super.copyFrom(param1);
         var _loc2_:CollisionTriangle = param1 as CollisionTriangle;
         if(_loc2_ != null)
         {
            this.v0.copy(_loc2_.v0);
            this.v1.copy(_loc2_.v1);
            this.v2.copy(_loc2_.v2);
            this.e0.copy(_loc2_.e0);
            this.e1.copy(_loc2_.e1);
            this.e2.copy(_loc2_.e2);
         }
         return this;
      }
      
      override protected function createPrimitive() : CollisionShape
      {
         return new CollisionTriangle(this.v0,this.v1,this.v2,collisionGroup,material);
      }
      
      private function initVertices(param1:Vector3, param2:Vector3, param3:Vector3) : void
      {
         this.v0.copy(param1);
         this.v1.copy(param2);
         this.v2.copy(param3);
         this.e0.diff(param2,param1);
         this.e0.normalize();
         this.e1.diff(param3,param2);
         this.e1.normalize();
         this.e2.diff(param1,param3);
         this.e2.normalize();
      }
   }
}

