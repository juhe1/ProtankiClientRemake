package alternativa.physics
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.CollisionShape;
   
   public class ShapeContact
   {
      
      private static var poolSize:int;
      
      private static const pool:Vector.<ShapeContact> = new Vector.<ShapeContact>();
      
      public var position:Vector3 = new Vector3();
      
      public var penetration:Number;
      
      public var normal:Vector3 = new Vector3();
      
      public var tangent1:Vector3 = new Vector3();
      
      public var tangent2:Vector3 = new Vector3();
      
      public var collisionSpeed:Number;
      
      public var contactSeparationSpeed:Number;
      
      public var normalSpeedDelta:Number;
      
      public var tangentSpeedDelta1:Number;
      
      public var tangentSpeedDelta2:Number;
      
      public var normalAngularInertiaTerm1:Number;
      
      public var normalAngularInertiaTerm2:Number;
      
      public var tangentAngularInertiaTerm11:Number;
      
      public var tangentAngularInertiaTerm12:Number;
      
      public var tangentAngularInertiaTerm21:Number;
      
      public var tangentAngularInertiaTerm22:Number;
      
      public var r1:Vector3 = new Vector3();
      
      public var r2:Vector3 = new Vector3();
      
      public var normalImpulse:Number;
      
      public var tangentImpulse1:Number;
      
      public var tangentImpulse2:Number;
      
      public var satisfied:Boolean;
      
      public var restitution:Number;
      
      public var friction:Number;
      
      public var shape1:CollisionShape;
      
      public var shape2:CollisionShape;
      
      public function ShapeContact()
      {
         super();
      }
      
      public static function create() : ShapeContact
      {
         if(poolSize == 0)
         {
            return new ShapeContact();
         }
         --poolSize;
         var _loc1_:ShapeContact = pool[poolSize];
         pool[poolSize] = null;
         return _loc1_;
      }
      
      public function dispose() : void
      {
         this.shape1 = null;
         this.shape2 = null;
         pool[poolSize] = this;
         ++poolSize;
      }
      
      public function calculatePersistentFrameData() : void
      {
         var _loc1_:Body = this.shape1.body;
         var _loc2_:Body = this.shape2.body;
         this.restitution = this.shape1.material.restitution;
         var _loc3_:Number = this.shape2.material.restitution;
         if(_loc3_ < this.restitution)
         {
            this.restitution = _loc3_;
         }
         this.friction = this.shape1.material.friction;
         var _loc4_:Number = this.shape2.material.friction;
         if(_loc4_ < this.friction)
         {
            this.friction = _loc4_;
         }
         if(_loc1_.slipperyMode && !_loc2_.movable || _loc2_.slipperyMode && !_loc1_.movable)
         {
            this.friction = 0;
         }
         var _loc5_:Vector3 = this.shape1.body.state.position;
         this.r1.x = this.position.x - _loc5_.x;
         this.r1.y = this.position.y - _loc5_.y;
         this.r1.z = this.position.z - _loc5_.z;
         _loc5_ = this.shape2.body.state.position;
         this.r2.x = this.position.x - _loc5_.x;
         this.r2.y = this.position.y - _loc5_.y;
         this.r2.z = this.position.z - _loc5_.z;
         if(Math.abs(this.normal.x) < Math.abs(this.normal.y))
         {
            this.tangent1.cross2(this.normal,Vector3.X_AXIS).normalize();
         }
         else
         {
            this.tangent1.cross2(this.normal,Vector3.Y_AXIS).normalize();
         }
         this.tangent2.cross2(this.normal,this.tangent1);
         this.normalImpulse = 0;
         this.tangentImpulse1 = 0;
         this.tangentImpulse2 = 0;
         this.normalSpeedDelta = 0;
         this.tangentSpeedDelta1 = 0;
         this.tangentSpeedDelta2 = 0;
         if(_loc1_.movable)
         {
            this.normalAngularInertiaTerm1 = this.calculateAngularInertiaTerm(this.normal,this.r1,_loc1_.invInertiaWorld);
            this.tangentAngularInertiaTerm11 = this.calculateAngularInertiaTerm(this.tangent1,this.r1,_loc1_.invInertiaWorld);
            this.tangentAngularInertiaTerm12 = this.calculateAngularInertiaTerm(this.tangent2,this.r1,_loc1_.invInertiaWorld);
            this.normalSpeedDelta += _loc1_.invMass + this.normalAngularInertiaTerm1;
            this.tangentSpeedDelta1 += _loc1_.invMass + this.tangentAngularInertiaTerm11;
            this.tangentSpeedDelta2 += _loc1_.invMass + this.tangentAngularInertiaTerm12;
         }
         if(_loc2_.movable)
         {
            this.normalAngularInertiaTerm2 = this.calculateAngularInertiaTerm(this.normal,this.r2,_loc2_.invInertiaWorld);
            this.tangentAngularInertiaTerm21 = this.calculateAngularInertiaTerm(this.tangent1,this.r2,_loc2_.invInertiaWorld);
            this.tangentAngularInertiaTerm22 = this.calculateAngularInertiaTerm(this.tangent2,this.r2,_loc2_.invInertiaWorld);
            this.normalSpeedDelta += _loc2_.invMass + this.normalAngularInertiaTerm2;
            this.tangentSpeedDelta1 += _loc2_.invMass + this.tangentAngularInertiaTerm21;
            this.tangentSpeedDelta2 += _loc2_.invMass + this.tangentAngularInertiaTerm22;
         }
         this.collisionSpeed = this.getSeparationVelocity();
         if(this.collisionSpeed < 0)
         {
            this.collisionSpeed = -this.restitution * this.collisionSpeed;
         }
         else
         {
            this.collisionSpeed = 0;
         }
      }
      
      private function calculateAngularInertiaTerm(param1:Vector3, param2:Vector3, param3:Matrix3) : Number
      {
         var _loc4_:Number = param2.y * param1.z - param2.z * param1.y;
         var _loc5_:Number = param2.z * param1.x - param2.x * param1.z;
         var _loc6_:Number = param2.x * param1.y - param2.y * param1.x;
         var _loc7_:Number = param3.m00 * _loc4_ + param3.m01 * _loc5_ + param3.m02 * _loc6_;
         var _loc8_:Number = param3.m10 * _loc4_ + param3.m11 * _loc5_ + param3.m12 * _loc6_;
         var _loc9_:Number = param3.m20 * _loc4_ + param3.m21 * _loc5_ + param3.m22 * _loc6_;
         _loc4_ = _loc8_ * param2.z - _loc9_ * param2.y;
         _loc5_ = _loc9_ * param2.x - _loc7_ * param2.z;
         _loc6_ = _loc7_ * param2.y - _loc8_ * param2.x;
         return _loc4_ * param1.x + _loc5_ * param1.y + _loc6_ * param1.z;
      }
      
      public function getSeparationVelocity() : Number
      {
         var _loc1_:Vector3 = this.shape1.body.state.angularVelocity;
         var _loc2_:Number = _loc1_.y * this.r1.z - _loc1_.z * this.r1.y;
         var _loc3_:Number = _loc1_.z * this.r1.x - _loc1_.x * this.r1.z;
         var _loc4_:Number = _loc1_.x * this.r1.y - _loc1_.y * this.r1.x;
         var _loc5_:Vector3 = this.shape1.body.state.velocity;
         var _loc6_:Number = _loc5_.x + _loc2_;
         var _loc7_:Number = _loc5_.y + _loc3_;
         var _loc8_:Number = _loc5_.z + _loc4_;
         _loc1_ = this.shape2.body.state.angularVelocity;
         _loc2_ = _loc1_.y * this.r2.z - _loc1_.z * this.r2.y;
         _loc3_ = _loc1_.z * this.r2.x - _loc1_.x * this.r2.z;
         _loc4_ = _loc1_.x * this.r2.y - _loc1_.y * this.r2.x;
         _loc5_ = this.shape2.body.state.velocity;
         _loc6_ -= _loc5_.x + _loc2_;
         _loc7_ -= _loc5_.y + _loc3_;
         _loc8_ -= _loc5_.z + _loc4_;
         return _loc6_ * this.normal.x + _loc7_ * this.normal.y + _loc8_ * this.normal.z;
      }
      
      public function calcualteDynamicFrameData(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc7_:Number = NaN;
         var _loc5_:Body = this.shape1.body;
         var _loc6_:Body = this.shape2.body;
         this.normalSpeedDelta = 0;
         this.tangentSpeedDelta1 = 0;
         this.tangentSpeedDelta2 = 0;
         if(_loc5_.movable)
         {
            this.normalSpeedDelta += _loc5_.invMass + this.normalAngularInertiaTerm1;
            this.tangentSpeedDelta1 += _loc5_.invMass + this.tangentAngularInertiaTerm11;
            this.tangentSpeedDelta2 += _loc5_.invMass + this.tangentAngularInertiaTerm12;
         }
         if(_loc6_.movable)
         {
            this.normalSpeedDelta += _loc6_.invMass + this.normalAngularInertiaTerm2;
            this.tangentSpeedDelta1 += _loc6_.invMass + this.tangentAngularInertiaTerm21;
            this.tangentSpeedDelta2 += _loc6_.invMass + this.tangentAngularInertiaTerm22;
         }
         if(this.penetration > param1)
         {
            _loc7_ = this.penetration - param1;
            if(_loc7_ > param3)
            {
               _loc7_ = param3;
            }
            this.contactSeparationSpeed = param2 * _loc7_ / param4;
         }
         else
         {
            this.contactSeparationSpeed = 0;
         }
      }
   }
}

