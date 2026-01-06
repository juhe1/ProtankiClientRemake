package alternativa.physics
{
   import alternativa.math.Matrix3;
   import alternativa.math.Matrix4;
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.BodyCollisionFilter;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.physics.collision.types.AABB;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.utils.EncryptedNumber;
   import alternativa.tanks.utils.EncryptedNumberImpl;
   
   public class Body
   {
      
      public static var linearDamping:Number = 0.997;
      
      public static var rotationalDamping:Number = 0.997;
      
      private static const MAX_SPEED_Z:Number = 1500;
      
      private static const _r:Vector3 = new Vector3();
      
      private static const _f:Vector3 = new Vector3();
      
      public var id:int;
      
      public var tank:Tank;
      
      public var scene:PhysicsScene;
      
      public var movable:Boolean = true;
      
      public var canFreeze:Boolean = false;
      
      public var freezeCounter:int;
      
      public var frozen:Boolean = false;
      
      public var slipperyMode:Boolean = false;
      
      public var aabb:AABB = new AABB();
      
      public var postCollisionFilter:BodyCollisionFilter;
      
      public var acceleration:Vector3 = new Vector3();
      
      public var angularAcceleration:Vector3 = new Vector3();
      
      public var prevState:BodyState = new BodyState();
      
      public var mass:Number = 1;
      
      public var invMass:Number = 1;
      
      public var invInertia:Matrix3 = new Matrix3();
      
      public var invInertiaWorld:Matrix3 = new Matrix3();
      
      public var baseMatrix:Matrix3 = new Matrix3();
      
      public var previousVelocity:Vector3 = new Vector3();
      
      public var state:BodyState = new BodyState();
      
      private var maxSpeedXY:EncryptedNumber = new EncryptedNumberImpl(0);
      
      private var maxZSpeedDelta:Number = 600;
      
      private var minZAcceleration:Number = -1100;
      
      public var collisionShapes:Vector.<CollisionShape>;
      
      public var numCollisionShapes:int;
      
      public var forceAccum:Vector3 = new Vector3();
      
      public var torqueAccum:Vector3 = new Vector3();
      
      public var pseudoVelocity:Vector3 = new Vector3();
      
      public var pseudoAngularVelocity:Vector3 = new Vector3();
      
      public function Body(param1:Number, param2:Matrix3, param3:Number)
      {
         super();
         this.mass = param1;
         this.invMass = 1 / param1;
         this.invInertia.copy(param2);
         this.maxSpeedXY.setNumber(param3);
      }
      
      public function addCollisionShape(param1:CollisionShape, param2:Matrix4 = null) : void
      {
         if(param1 == null)
         {
            throw new ArgumentError("Parameter is null");
         }
         if(this.collisionShapes == null)
         {
            this.collisionShapes = new Vector.<CollisionShape>();
            this.numCollisionShapes = 0;
         }
         this.collisionShapes.push(param1);
         this.numCollisionShapes = this.collisionShapes.length;
         param1.setBody(this,param2);
      }
      
      public function removeCollisionShape(param1:CollisionShape) : void
      {
         var _loc2_:int = 0;
         if(this.collisionShapes != null)
         {
            if(this.numCollisionShapes > 0)
            {
               _loc2_ = int(this.collisionShapes.indexOf(param1));
               if(_loc2_ >= 0)
               {
                  param1.setBody(null);
                  this.collisionShapes[_loc2_] = this.collisionShapes[--this.numCollisionShapes];
                  if(this.numCollisionShapes == 0)
                  {
                     this.collisionShapes = null;
                  }
                  else
                  {
                     this.collisionShapes.length = this.numCollisionShapes;
                  }
               }
            }
         }
      }
      
      public function interpolate(param1:Number, param2:Vector3, param3:Quaternion) : void
      {
         var _loc4_:Number = NaN;
         _loc4_ = 1 - param1;
         param2.x = this.prevState.position.x * _loc4_ + this.state.position.x * param1;
         param2.y = this.prevState.position.y * _loc4_ + this.state.position.y * param1;
         param2.z = this.prevState.position.z * _loc4_ + this.state.position.z * param1;
         param3.w = this.prevState.orientation.w * _loc4_ + this.state.orientation.w * param1;
         param3.x = this.prevState.orientation.x * _loc4_ + this.state.orientation.x * param1;
         param3.y = this.prevState.orientation.y * _loc4_ + this.state.orientation.y * param1;
         param3.z = this.prevState.orientation.z * _loc4_ + this.state.orientation.z * param1;
      }
      
      public function setPosition(param1:Vector3) : void
      {
         this.state.position.copy(param1);
      }
      
      public function setPositionXYZ(param1:Number, param2:Number, param3:Number) : void
      {
         this.state.position.reset(param1,param2,param3);
      }
      
      public function setVelocity(param1:Vector3) : void
      {
         this.state.velocity.copy(param1);
      }
      
      public function setVelocityXYZ(param1:Number, param2:Number, param3:Number) : void
      {
         this.state.velocity.reset(param1,param2,param3);
      }
      
      public function setRotation(param1:Vector3) : void
      {
         this.state.angularVelocity.copy(param1);
      }
      
      public function setRotationXYZ(param1:Number, param2:Number, param3:Number) : void
      {
         this.state.angularVelocity.reset(param1,param2,param3);
      }
      
      public function setOrientation(param1:Quaternion) : void
      {
         this.state.orientation.copy(param1);
      }
      
      public function setMaxSpeedXY(param1:Number) : void
      {
         this.maxSpeedXY.setNumber(param1);
      }
      
      public function applyWorldImpulseAtLocalPoint(param1:Vector3, param2:Vector3, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc4_:Number = param3 * this.invMass;
         this.state.velocity.x += _loc4_ * param2.x;
         this.state.velocity.y += _loc4_ * param2.y;
         this.state.velocity.z += _loc4_ * param2.z;
         _loc5_ = (param1.y * param2.z - param1.z * param2.y) * param3;
         _loc6_ = (param1.z * param2.x - param1.x * param2.z) * param3;
         var _loc7_:Number = (param1.x * param2.y - param1.y * param2.x) * param3;
         this.state.angularVelocity.x += this.invInertiaWorld.m00 * _loc5_ + this.invInertiaWorld.m01 * _loc6_ + this.invInertiaWorld.m02 * _loc7_;
         this.state.angularVelocity.y += this.invInertiaWorld.m10 * _loc5_ + this.invInertiaWorld.m11 * _loc6_ + this.invInertiaWorld.m12 * _loc7_;
         this.state.angularVelocity.z += this.invInertiaWorld.m20 * _loc5_ + this.invInertiaWorld.m21 * _loc6_ + this.invInertiaWorld.m22 * _loc7_;
      }
      
      public function applyWorldPseudoImpulseAtLocalPoint(param1:Vector3, param2:Vector3, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:Number = param3 * this.invMass;
         this.pseudoVelocity.x += _loc4_ * param2.x;
         this.pseudoVelocity.y += _loc4_ * param2.y;
         this.pseudoVelocity.z += _loc4_ * param2.z;
         _loc5_ = (param1.y * param2.z - param1.z * param2.y) * param3;
         var _loc6_:Number = (param1.z * param2.x - param1.x * param2.z) * param3;
         _loc7_ = (param1.x * param2.y - param1.y * param2.x) * param3;
         this.pseudoAngularVelocity.x += this.invInertiaWorld.m00 * _loc5_ + this.invInertiaWorld.m01 * _loc6_ + this.invInertiaWorld.m02 * _loc7_;
         this.pseudoAngularVelocity.y += this.invInertiaWorld.m10 * _loc5_ + this.invInertiaWorld.m11 * _loc6_ + this.invInertiaWorld.m12 * _loc7_;
         this.pseudoAngularVelocity.z += this.invInertiaWorld.m20 * _loc5_ + this.invInertiaWorld.m21 * _loc6_ + this.invInertiaWorld.m22 * _loc7_;
      }
      
      public function applyImpulse(param1:Vector3, param2:Number) : void
      {
         var _loc3_:Number = param2 * this.invMass;
         this.state.velocity.x += _loc3_ * param1.x;
         this.state.velocity.y += _loc3_ * param1.y;
         this.state.velocity.z += _loc3_ * param1.z;
      }
      
      public function addForce(param1:Vector3) : void
      {
         this.forceAccum.add(param1);
      }
      
      public function addScaledForce(param1:Vector3, param2:Number) : void
      {
         this.forceAccum.addScaled(param2,param1);
      }
      
      public function addForceXYZ(param1:Number, param2:Number, param3:Number) : void
      {
         this.forceAccum.x += param1;
         this.forceAccum.y += param2;
         this.forceAccum.z += param3;
      }
      
      public function addWorldForceXYZ(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.forceAccum.x += param4;
         this.forceAccum.y += param5;
         this.forceAccum.z += param6;
         var _loc7_:Vector3 = this.state.position;
         var _loc8_:Number = param1 - _loc7_.x;
         var _loc9_:Number = param2 - _loc7_.y;
         var _loc10_:Number = param3 - _loc7_.z;
         this.torqueAccum.x += _loc9_ * param6 - _loc10_ * param5;
         this.torqueAccum.y += _loc10_ * param4 - _loc8_ * param6;
         this.torqueAccum.z += _loc8_ * param5 - _loc9_ * param4;
      }
      
      public function addWorldForce(param1:Vector3, param2:Vector3) : void
      {
         this.forceAccum.add(param2);
         this.torqueAccum.add(_r.diff(param1,this.state.position).cross(param2));
      }
      
      public function addWorldForceScaled(param1:Vector3, param2:Vector3, param3:Number) : void
      {
         var _loc10_:Number = NaN;
         var _loc4_:Number = param3 * param2.x;
         var _loc5_:Number = param3 * param2.y;
         var _loc6_:Number = param3 * param2.z;
         this.forceAccum.x += _loc4_;
         this.forceAccum.y += _loc5_;
         this.forceAccum.z += _loc6_;
         var _loc7_:Vector3 = this.state.position;
         var _loc8_:Number = param1.x - _loc7_.x;
         var _loc9_:Number = param1.y - _loc7_.y;
         _loc10_ = param1.z - _loc7_.z;
         this.torqueAccum.x += _loc9_ * _loc6_ - _loc10_ * _loc5_;
         this.torqueAccum.y += _loc10_ * _loc4_ - _loc8_ * _loc6_;
         this.torqueAccum.z += _loc8_ * _loc5_ - _loc9_ * _loc4_;
      }
      
      public function addLocalForce(param1:Vector3, param2:Vector3) : void
      {
         this.baseMatrix.transformVector(param1,_r);
         this.baseMatrix.transformVector(param2,_f);
         this.forceAccum.add(_f);
         this.torqueAccum.add(_r.cross(_f));
      }
      
      public function addWorldForceAtLocalPoint(param1:Vector3, param2:Vector3) : void
      {
         this.baseMatrix.transformVector(param1,_r);
         this.forceAccum.add(param2);
         this.torqueAccum.add(_r.cross(param2));
      }
      
      public function addScaledWorldForceAtLocalPoint(param1:Vector3, param2:Vector3, param3:Number) : void
      {
         this.baseMatrix.transformVector(param1,_r);
         this.forceAccum.addScaled(param3,param2);
         this.torqueAccum.addScaled(param3,_r.cross(param2));
      }
      
      public function addTorque(param1:Vector3) : void
      {
         this.torqueAccum.add(param1);
      }
      
      public function clearAccumulators() : void
      {
         this.forceAccum.x = this.forceAccum.y = this.forceAccum.z = 0;
         this.torqueAccum.x = this.torqueAccum.y = this.torqueAccum.z = 0;
      }
      
      public function calcAccelerations() : void
      {
         this.acceleration.x = this.forceAccum.x * this.invMass;
         this.acceleration.y = this.forceAccum.y * this.invMass;
         this.acceleration.z = this.forceAccum.z * this.invMass;
         this.angularAcceleration.x = this.invInertiaWorld.m00 * this.torqueAccum.x + this.invInertiaWorld.m01 * this.torqueAccum.y + this.invInertiaWorld.m02 * this.torqueAccum.z;
         this.angularAcceleration.y = this.invInertiaWorld.m10 * this.torqueAccum.x + this.invInertiaWorld.m11 * this.torqueAccum.y + this.invInertiaWorld.m12 * this.torqueAccum.z;
         this.angularAcceleration.z = this.invInertiaWorld.m20 * this.torqueAccum.x + this.invInertiaWorld.m21 * this.torqueAccum.y + this.invInertiaWorld.m22 * this.torqueAccum.z;
      }
      
      public function calcDerivedData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:CollisionShape = null;
         this.state.orientation.toMatrix3(this.baseMatrix);
         this.invInertiaWorld.copy(this.invInertia).append(this.baseMatrix).prependTransposed(this.baseMatrix);
         if(this.collisionShapes != null)
         {
            this.aabb.infinity();
            _loc1_ = 0;
            while(_loc1_ < this.numCollisionShapes)
            {
               _loc2_ = this.collisionShapes[_loc1_];
               _loc2_.transform.setFromMatrix3(this.baseMatrix,this.state.position);
               if(_loc2_.localTransform != null)
               {
                  _loc2_.transform.prepend(_loc2_.localTransform);
               }
               _loc2_.calculateAABB();
               this.aabb.addBoundBox(_loc2_.aabb);
               _loc1_++;
            }
         }
      }
      
      public function saveState() : void
      {
         this.prevState.copy(this.state);
      }
      
      public function restoreState() : void
      {
         this.state.copy(this.prevState);
      }
      
      public function integrateVelocity(param1:Number) : void
      {
         this.integrateLinearVelocity(param1);
         this.integrateAngularVelocity(param1);
      }
      
      private function integrateLinearVelocity(param1:Number) : void
      {
         var _loc7_:Number = NaN;
         this.previousVelocity.copy(this.state.velocity);
         if(this.acceleration.z < this.minZAcceleration)
         {
            this.acceleration.z = this.minZAcceleration;
         }
         this.state.velocity = this.state.velocity.clone();
         this.state.velocity.x += this.acceleration.x * param1;
         this.state.velocity.y += this.acceleration.y * param1;
         this.state.velocity.z += this.acceleration.z * param1;
         this.state.velocity.x *= linearDamping;
         this.state.velocity.y *= linearDamping;
         this.state.velocity.z *= linearDamping;
         var _loc2_:Number = Math.abs(this.state.velocity.z);
         if(_loc2_ > MAX_SPEED_Z)
         {
            this.state.velocity.z *= MAX_SPEED_Z / _loc2_;
         }
         if(this.state.velocity.z - this.previousVelocity.z > this.maxZSpeedDelta)
         {
            this.state.velocity.z = this.previousVelocity.z + this.maxZSpeedDelta;
         }
         var _loc3_:Number = this.state.velocity.x;
         var _loc4_:Number = this.state.velocity.y;
         var _loc5_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
         var _loc6_:Number = Number(this.maxSpeedXY.getNumber());
         if(_loc5_ > _loc6_)
         {
            _loc7_ = _loc6_ / _loc5_;
            this.state.velocity.x *= _loc7_;
            this.state.velocity.y *= _loc7_;
         }
      }
      
      private function integrateAngularVelocity(param1:Number) : void
      {
         this.state.angularVelocity.x += this.angularAcceleration.x * param1;
         this.state.angularVelocity.y += this.angularAcceleration.y * param1;
         this.state.angularVelocity.z += this.angularAcceleration.z * param1;
         this.state.angularVelocity.x *= rotationalDamping;
         this.state.angularVelocity.y *= rotationalDamping;
         this.state.angularVelocity.z *= rotationalDamping;
         if(this.state.angularVelocity.length() > 10)
         {
            this.state.angularVelocity.setLength(10);
         }
      }
      
      public function integratePosition(param1:Number) : void
      {
         var _loc2_:Vector3 = new Vector3();
         var _loc3_:Vector3 = this.state.position;
         var _loc4_:Vector3 = this.state.velocity;
         _loc2_.x = _loc3_.x + _loc4_.x * param1;
         _loc2_.y = _loc3_.y + _loc4_.y * param1;
         _loc2_.z = _loc3_.z + _loc4_.z * param1;
         this.state.position = _loc2_;
         this.state.orientation.addScaledVector(this.state.angularVelocity,param1);
      }
      
      public function integratePseudoVelocity(param1:Number) : void
      {
         this.state.position.x += this.pseudoVelocity.x * param1;
         this.state.position.y += this.pseudoVelocity.y * param1;
         this.state.position.z += this.pseudoVelocity.z * param1;
         this.state.orientation.addScaledVector(this.pseudoAngularVelocity,param1);
         this.pseudoVelocity.reset();
         this.pseudoAngularVelocity.reset();
      }
      
      public function toString() : String
      {
         return "Body{state=" + String(this.state) + "}";
      }
   }
}

