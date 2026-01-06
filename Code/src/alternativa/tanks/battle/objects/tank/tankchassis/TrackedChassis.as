package alternativa.tanks.battle.objects.tank.tankchassis
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.objects.tank.TankConst;
   import alternativa.tanks.battle.objects.tank.ValueSmoother;
   import alternativa.tanks.utils.EncryptedNumber;
   import alternativa.tanks.utils.EncryptedNumberImpl;
   import alternativa.tanks.utils.MathUtils;
   
   public class TrackedChassis
   {
      
      public static const TURN_SPEED_COUNT:* = 7;
      
      private static const MIN_ACCELERATION:Number = 400;
      
      private static const _xAxis:Vector3 = new Vector3();
      
      private static const _yAxis:Vector3 = new Vector3();
      
      private static const _zAxis:Vector3 = new Vector3();
      
      private static const _surfaceVelocity:Vector3 = new Vector3();
      
      private static const _surfaceAngularVelocity:Vector3 = new Vector3();
      
      private static const _relativeVelocity:Vector3 = new Vector3();
      
      private static const _relativeAngularVelocity:Vector3 = new Vector3();
      
      private static const _forceVector:Vector3 = new Vector3();
      
      private static const _midPoint:Vector3 = new Vector3();
      
      private var body:Body;
      
      private var suspensionParams:SuspensionParams;
      
      private var maxSpeedSmoother:ValueSmoother;
      
      public var leftTrack:Track;
      
      public var rightTrack:Track;
      
      public var movementLocked:Boolean;
      
      public var movementDirection:int;
      
      public var turnDirection:int;
      
      public var turnSpeedNumber:int;
      
      public var inverseBackTurnMovement:Boolean;
      
      private const _acceleration:EncryptedNumber = new EncryptedNumberImpl();
      
      private const _reverseAcceleration:EncryptedNumber = new EncryptedNumberImpl();
      
      private const _sideAcceleration:EncryptedNumber = new EncryptedNumberImpl();
      
      private const _turnAcceleration:EncryptedNumber = new EncryptedNumberImpl();
      
      private const _reverseTurnAcceleration:EncryptedNumber = new EncryptedNumberImpl();
      
      private const _stabilizationAcceleration:EncryptedNumber = new EncryptedNumberImpl();
      
      public function TrackedChassis(param1:Body, param2:SuspensionParams, param3:ValueSmoother, param4:Vector3)
      {
         super();
         this.body = param1;
         this.suspensionParams = param2;
         this.maxSpeedSmoother = param3;
         this.createTracks(TankConst.NUM_RAYS_PER_TRACK,param4);
      }
      
      private function createTracks(param1:int, param2:Vector3) : void
      {
         var _loc3_:Number = param2.y * 0.8;
         var _loc4_:Number = param2.x - 40;
         this.leftTrack = new Track(this.body,param1,new Vector3(-0.5 * _loc4_,0,-0.5 * param2.z + TankConst.RAY_OFFSET),_loc3_,this.suspensionParams,-1);
         this.rightTrack = new Track(this.body,param1,new Vector3(0.5 * _loc4_,0,-0.5 * param2.z + TankConst.RAY_OFFSET),_loc3_,this.suspensionParams,1);
      }
      
      public function setAcceleration(param1:Number) : void
      {
         this._acceleration.setNumber(param1);
      }
      
      public function setReverseAcceleration(param1:Number) : void
      {
         this._reverseAcceleration.setNumber(param1);
      }
      
      public function setSideAcceleration(param1:Number) : void
      {
         this._sideAcceleration.setNumber(param1);
      }
      
      public function setTurnAcceleration(param1:Number) : void
      {
         this._turnAcceleration.setNumber(param1);
      }
      
      public function setReverseTurnAcceleration(param1:Number) : void
      {
         this._reverseTurnAcceleration.setNumber(param1);
      }
      
      public function setStabilizationAcceleration(param1:Number) : void
      {
         this._stabilizationAcceleration.setNumber(param1);
      }
      
      public function getAcceleration() : Number
      {
         return this._acceleration.getNumber();
      }
      
      public function getActualMovementDirection() : int
      {
         return this.movementLocked ? 0 : this.movementDirection;
      }
      
      public function getActualTurnDirection() : int
      {
         return this.movementLocked ? 0 : this.turnDirection;
      }
      
      public function setTracksCollisionGroup(param1:int) : void
      {
         this.leftTrack.setCollisionGroup(param1);
         this.rightTrack.setCollisionGroup(param1);
      }
      
      public function applyForces(param1:Number, param2:Number, param3:Number) : void
      {
         this.adjustSuspensionSpringCoeff();
         this.calculateSuspensionContacts(param3);
         this.applyMovementForces(param1,param2,param3);
         this.applySlopeHack();
      }
      
      private function adjustSuspensionSpringCoeff() : void
      {
         var _loc1_:Number = this.body.scene.gravity.length() * this.body.mass;
         this.suspensionParams.springCoeff = _loc1_ / (2 * TankConst.NUM_RAYS_PER_TRACK * (this.suspensionParams.maxRayLength - this.suspensionParams.nominalRayLength));
      }
      
      private function calculateSuspensionContacts(param1:Number) : void
      {
         this.leftTrack.calculateSuspensionContacts(param1);
         this.rightTrack.calculateSuspensionContacts(param1);
      }
      
      private function applyMovementForces(param1:Number, param2:Number, param3:Number) : void
      {
         if(this.leftTrack.numContacts + this.rightTrack.numContacts > 0)
         {
            this.doApplyMovementForces(param1,param2,param3);
         }
      }
      
      private function doApplyMovementForces(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc7_:Vector3 = null;
         var _loc8_:Matrix3 = null;
         var _loc9_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:int = 0;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:int = 0;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc4_:int = this.movementLocked ? 0 : this.movementDirection;
         var _loc5_:int = this.movementLocked ? 0 : this.turnDirection;
         var _loc6_:Vector3 = this.body.state.velocity;
         _loc7_ = this.body.state.angularVelocity;
         _loc8_ = this.body.baseMatrix;
         _xAxis.x = _loc8_.m00;
         _xAxis.y = _loc8_.m10;
         _xAxis.z = _loc8_.m20;
         _yAxis.x = _loc8_.m01;
         _yAxis.y = _loc8_.m11;
         _yAxis.z = _loc8_.m21;
         _zAxis.x = _loc8_.m02;
         _zAxis.y = _loc8_.m12;
         _zAxis.z = _loc8_.m22;
         _loc9_ = 1;
         var _loc10_:Number = Math.PI / 4;
         var _loc11_:Number = TankConst.MAX_SLOPE_ANGLE;
         if(_zAxis.z < Math.cos(_loc10_))
         {
            if(_zAxis.z < Math.cos(_loc11_))
            {
               _loc9_ = 0;
            }
            else
            {
               _loc9_ = (_loc11_ - Math.acos(_zAxis.z)) / (_loc11_ - _loc10_);
            }
         }
         this.calculateSurfaceVelocities(_surfaceVelocity,_surfaceAngularVelocity);
         _relativeVelocity.x = _loc6_.x - _surfaceVelocity.x;
         _relativeVelocity.y = _loc6_.y - _surfaceVelocity.y;
         _relativeVelocity.z = _loc6_.z - _surfaceVelocity.z;
         _relativeAngularVelocity.x = _loc7_.x - _surfaceAngularVelocity.x;
         _relativeAngularVelocity.y = _loc7_.y - _surfaceAngularVelocity.y;
         _relativeAngularVelocity.z = _loc7_.z - _surfaceAngularVelocity.z;
         var _loc12_:Number = _relativeVelocity.x * _yAxis.x + _relativeVelocity.y * _yAxis.y + _relativeVelocity.z * _yAxis.z;
         var _loc13_:Number = _relativeAngularVelocity.x * _zAxis.x + _relativeAngularVelocity.y * _zAxis.y + _relativeAngularVelocity.z * _zAxis.z;
         var _loc14_:Number = _relativeVelocity.x * _xAxis.x + _relativeVelocity.y * _xAxis.y + _relativeVelocity.z * _xAxis.z;
         var _loc15_:Number = this._sideAcceleration.getNumber() * _loc9_ * param3;
         if(_loc14_ < 0)
         {
            if(_loc15_ > -_loc14_)
            {
               _loc14_ = 0;
            }
            else
            {
               _loc14_ += _loc15_;
            }
         }
         else if(_loc14_ > 0)
         {
            if(_loc15_ > _loc14_)
            {
               _loc14_ = 0;
            }
            else
            {
               _loc14_ -= _loc15_;
            }
         }
         _relativeVelocity.setLengthAlongDirection(_xAxis,_loc14_);
         _loc6_.x = _surfaceVelocity.x + _relativeVelocity.x;
         _loc6_.y = _surfaceVelocity.y + _relativeVelocity.y;
         _loc6_.z = _surfaceVelocity.z + _relativeVelocity.z;
         var _loc16_:int = this.leftTrack.numContacts;
         var _loc17_:int = this.rightTrack.numContacts;
         var _loc18_:Number = Number(this._acceleration.getNumber());
         var _loc19_:Number = Number(this._turnAcceleration.getNumber());
         if(_loc16_ > 0 || _loc17_ > 0)
         {
            _loc20_ = 0;
            if(_loc4_ == 0)
            {
               _loc20_ = -MathUtils.sign(_loc12_) * _loc18_ * param3;
               if(MathUtils.sign(_loc12_) != MathUtils.sign(_loc12_ + _loc20_))
               {
                  _loc20_ = -_loc12_;
               }
            }
            else
            {
               if(MathUtils.sign(_loc12_) * MathUtils.sign(_loc4_) < 0)
               {
                  _loc18_ = Number(this._reverseAcceleration.getNumber());
               }
               _loc20_ = _loc4_ * _loc18_ * param3;
            }
            _loc21_ = MathUtils.clamp(_loc12_ + _loc20_,-param1,param1);
            _loc22_ = _loc21_ - _loc12_;
            _loc23_ = 1;
            _loc24_ = MathUtils.clamp(1 - Math.abs(_loc12_ / param1),0,1);
            if(_loc24_ < _loc23_ && _loc4_ * MathUtils.sign(_loc12_) > 0)
            {
               _loc22_ *= _loc24_ / _loc23_;
            }
            _loc25_ = _loc22_ / param3;
            if(Math.abs(_loc25_) < MIN_ACCELERATION && Math.abs(_loc21_) > 0.5 * this.maxSpeedSmoother.getTargetValue())
            {
               _loc25_ = MathUtils.numberSign(_loc25_,0.1) * MIN_ACCELERATION;
            }
            _loc26_ = _loc25_ * this.body.mass;
            _loc27_ = _loc16_ + _loc17_;
            _loc28_ = _loc26_ * (_loc27_ + 0.21 * (20 - _loc27_)) / 10;
            _loc29_ = _loc28_ / _loc27_;
            _loc30_ = Math.PI / 4;
            _loc31_ = Math.PI / 3;
            _loc32_ = 0;
            while(_loc32_ < TankConst.NUM_RAYS_PER_TRACK)
            {
               this.applyForceFromRay(this.leftTrack.rays[_loc32_],_yAxis,_loc29_,_loc31_,_loc30_);
               this.applyForceFromRay(this.rightTrack.rays[_loc32_],_yAxis,_loc29_,_loc31_,_loc30_);
               _loc32_++;
            }
            _loc33_ = 1;
            if(_loc16_ == 0 || _loc17_ == 0)
            {
               _loc33_ = 0.5;
            }
            _loc34_ = 0;
            if(_loc5_ == 0)
            {
               _loc34_ = -MathUtils.sign(_loc13_) * this._stabilizationAcceleration.getNumber() * _loc9_ * param3;
               if(MathUtils.sign(_loc13_) != MathUtils.sign(_loc13_ + _loc34_))
               {
                  _loc34_ = -_loc13_;
               }
            }
            else
            {
               if(this.isReversedTurn(_loc5_,_loc13_,_loc4_,this.inverseBackTurnMovement))
               {
                  _loc19_ = Number(this._reverseTurnAcceleration.getNumber());
               }
               _loc34_ = _loc5_ * _loc19_ * _loc9_ * param3;
               if(_loc4_ == -1 && this.inverseBackTurnMovement)
               {
                  _loc34_ = -_loc34_;
               }
            }
            _loc35_ = param2;
            if(_loc5_ != 0)
            {
               _loc35_ = param2 * this.turnSpeedNumber / TURN_SPEED_COUNT;
            }
            _loc36_ = _loc35_ * _loc33_;
            _loc37_ = MathUtils.clamp(_loc13_ + _loc34_,-_loc36_,_loc36_);
            _relativeAngularVelocity.setLengthAlongDirection(_zAxis,_loc37_);
            _loc7_.x = _surfaceAngularVelocity.x + _relativeAngularVelocity.x;
            _loc7_.y = _surfaceAngularVelocity.y + _relativeAngularVelocity.y;
            _loc7_.z = _surfaceAngularVelocity.z + _relativeAngularVelocity.z;
         }
      }
      
      private function isReversedTurn(param1:int, param2:Number, param3:int, param4:Boolean) : Boolean
      {
         var _loc5_:int = param4 && param3 < 0 ? -1 : 1;
         return param1 * param2 * _loc5_ < 0;
      }
      
      private function calculateSurfaceVelocities(param1:Vector3, param2:Vector3) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:SuspensionRay = null;
         var _loc5_:int = 0;
         var _loc6_:Vector3 = null;
         _loc3_ = 1 / (this.leftTrack.numContacts + this.rightTrack.numContacts);
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         _loc5_ = 0;
         while(_loc5_ < TankConst.NUM_RAYS_PER_TRACK)
         {
            _loc4_ = this.leftTrack.rays[_loc5_];
            if(_loc4_.hasCollision)
            {
               _loc6_ = _loc4_.rayHit.position;
               _loc7_ += _loc6_.x;
               _loc8_ += _loc6_.y;
               _loc9_ += _loc6_.z;
            }
            _loc4_ = this.rightTrack.rays[_loc5_];
            if(_loc4_.hasCollision)
            {
               _loc6_ = _loc4_.rayHit.position;
               _loc7_ += _loc6_.x;
               _loc8_ += _loc6_.y;
               _loc9_ += _loc6_.z;
            }
            _loc5_++;
         }
         _loc7_ *= _loc3_;
         _loc8_ *= _loc3_;
         _loc9_ *= _loc3_;
         _midPoint.x = _loc7_;
         _midPoint.y = _loc8_;
         _midPoint.z = _loc9_;
         param1.x = 0;
         param1.y = 0;
         param1.z = 0;
         param2.x = 0;
         param2.y = 0;
         param2.z = 0;
         _loc5_ = 0;
         while(_loc5_ < TankConst.NUM_RAYS_PER_TRACK)
         {
            this.addVelocitiesFromRay(this.leftTrack.rays[_loc5_],_midPoint,param1,param2);
            this.addVelocitiesFromRay(this.rightTrack.rays[_loc5_],_midPoint,param1,param2);
            _loc5_++;
         }
         param1.x *= _loc3_;
         param1.y *= _loc3_;
         param1.z *= _loc3_;
         param2.x *= _loc3_;
         param2.y *= _loc3_;
         param2.z *= _loc3_;
      }
      
      private function addVelocitiesFromRay(param1:SuspensionRay, param2:Vector3, param3:Vector3, param4:Vector3) : void
      {
         var _loc5_:Vector3 = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Vector3 = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         if(param1.hasCollision)
         {
            param3.x += param1.contactVelocity.x;
            param3.y += param1.contactVelocity.y;
            param3.z += param1.contactVelocity.z;
            _loc5_ = param1.rayHit.position;
            _loc6_ = _loc5_.x - param2.x;
            _loc7_ = _loc5_.y - param2.y;
            _loc8_ = _loc5_.z - param2.z;
            _loc9_ = _loc6_ * _loc6_ + _loc7_ * _loc7_ + _loc8_ * _loc8_;
            if(_loc9_ > 1)
            {
               _loc10_ = 1 / _loc9_;
               _loc11_ = param1.contactVelocity;
               _loc12_ = (_loc7_ * _loc11_.z - _loc8_ * _loc11_.y) * _loc10_;
               _loc13_ = (_loc8_ * _loc11_.x - _loc6_ * _loc11_.z) * _loc10_;
               _loc14_ = (_loc6_ * _loc11_.y - _loc7_ * _loc11_.x) * _loc10_;
               param4.x += _loc12_;
               param4.y += _loc13_;
               param4.z += _loc14_;
            }
         }
      }
      
      private function applyForceFromRay(param1:SuspensionRay, param2:Vector3, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(param1.hasCollision)
         {
            _loc6_ = param2.x;
            _loc7_ = param2.y;
            _loc8_ = param2.z;
            _loc9_ = _loc6_ * _loc6_ + _loc7_ * _loc7_ + _loc8_ * _loc8_;
            if(_loc9_ > 0.00001)
            {
               _loc10_ = Math.acos(param1.rayHit.normal.z);
               if(_loc10_ < 0)
               {
                  _loc10_ = -_loc10_;
               }
               if(_loc10_ < param4)
               {
                  _loc11_ = param3 / Math.sqrt(_loc9_);
                  if(_loc10_ > param5)
                  {
                     _loc11_ *= (param4 - _loc10_) / (param4 - param5);
                  }
                  _forceVector.x = _loc6_ * _loc11_;
                  _forceVector.y = _loc7_ * _loc11_;
                  _forceVector.z = _loc8_ * _loc11_;
                  this.body.addWorldForceAtLocalPoint(param1.getOrigin(),_forceVector);
               }
            }
         }
      }
      
      private function applySlopeHack() : void
      {
         var _loc1_:Matrix3 = null;
         var _loc2_:Vector3 = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(this.rightTrack.numContacts >= this.rightTrack.numRays >> 1 || this.leftTrack.numContacts >= this.leftTrack.numRays >> 1)
         {
            _loc1_ = this.body.baseMatrix;
            _loc2_ = this.body.scene.gravity;
            _loc3_ = _loc2_.x * _loc1_.m02 + _loc2_.y * _loc1_.m12 + _loc2_.z * _loc1_.m22;
            _loc4_ = _loc2_.length();
            _loc5_ = Math.SQRT1_2 * _loc4_;
            if(_loc3_ < -_loc5_ || _loc3_ > _loc5_)
            {
               _loc6_ = (_loc1_.m02 * _loc3_ - _loc2_.x) * this.body.mass;
               _loc7_ = (_loc1_.m12 * _loc3_ - _loc2_.y) * this.body.mass;
               _loc8_ = (_loc1_.m22 * _loc3_ - _loc2_.z) * this.body.mass;
               this.body.addForceXYZ(_loc6_,_loc7_,_loc8_);
            }
         }
      }
      
      public function reset() : void
      {
         this.movementLocked = false;
      }
   }
}

