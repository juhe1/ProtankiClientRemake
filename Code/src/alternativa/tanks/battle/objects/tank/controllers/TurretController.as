package alternativa.tanks.battle.objects.tank.controllers
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.objects.tank.SimpleValueSmoother;
   import alternativa.tanks.battle.objects.tank.ValueSmoother;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.rotation.WeaponRotationLimit;
   import alternativa.tanks.services.targeting.TargetingInputManager;
   import alternativa.tanks.utils.BitMask;
   import alternativa.tanks.utils.MathUtils;
   import platform.client.fp10.core.type.IGameObject;
   
   public final class TurretController
   {
      
      [Inject]
      public static var inputManager:TargetingInputManager;
      
      public static const BIT_LEFT:int = 5;//0;
      
      public static const BIT_RIGHT:int = 6;//1;
      
      public static const BIT_CENTER:int = 7;//2;
      
      public static const BIT_UP:int = 8;//3;
      
      public static const BIT_DOWN:int = 9;//4;
      
      private static const ROTATION_FIXER:Number = 5;
      
      private static const ROTATION_IGNORE:Number = 20;
      
      private static const IGNORE_TARGET_ANGLE:Number = 0.05;
      
      private static const IGNORE_TARGET_ANGLE_VALUE:Number = IGNORE_TARGET_ANGLE * Math.PI / 180;
      
      private static const EPSILON:Number = 0.000001;
      
      private static const weaponObject:WeaponObject = new WeaponObject(null);
      
      private static var zAxisPrev:Vector3 = new Vector3();
      
      private static var yAxisPrev:Vector3 = new Vector3();
      
      private static var yAxisNext:Vector3 = new Vector3();
      
      private static var tmpVector:Vector3 = new Vector3();
      
      private var maxTurnSpeedSmoother:ValueSmoother;
      
      private var maxTurnSpeed:Number = 0;
      
      private var turnAcceleration:Number = 0;
      
      private var turnSpeed:Number = 0;
      
      private var prevDirection:Number = 0;
      
      private var currDirection:Number = 0;
      
      private var prevTurnDirection:int;
      
      private var turnDirection:int;
      
      private var centerTurret:Boolean;
      
      private var initialDirection:Number = 0;
      
      private var lockMask:BitMask;
      
      private var clearDirectionOnReset:Boolean;
      
      protected var controlState:int = 0;
      
      private var _appliedControlState:int = 0;
      
      private var gyroscopePower:Number;
      
      protected var freeRotation:Number = 0;
      
      private var targetAngle:Number;
      
      private var rotationMode:Boolean;
      
      private var listener:ITurretControllerListener;
      
      private var _hasCameraRotation:Boolean = false;
      
      private var forceControlState:Boolean = false;
      
      private var targetAngleChanged:Boolean = false;
      
      private var keyState:Vector.<Boolean>;
      
      private var maxAngle:Number;
      
      private var minAngle:Number;
      
      public function TurretController(param1:IGameObject, param2:Boolean)
      {
         var _loc4_:WeaponRotationLimit = null;
         this.maxTurnSpeedSmoother = new SimpleValueSmoother(0.3,10,0,0);
         this.lockMask = new BitMask();
         this.keyState = new Vector.<Boolean>(256,true);
         super();
         weaponObject.setObject(param1);
         var _loc3_:WeaponCommonData = weaponObject.commonData();
         this.clearDirectionOnReset = param2;
         this.setMaxTurnSpeed(_loc3_.getMaxTurretRotationSpeed(),true);
         this.turnAcceleration = _loc3_.getTurretRotationAcceleration();
         if(param1.hasModel(WeaponRotationLimit))
         {
            _loc4_ = WeaponRotationLimit(param1.adapt(WeaponRotationLimit));
            this.maxAngle = _loc4_.getMaxAngle();
            this.minAngle = _loc4_.getMinAngle();
         }
         else
         {
            this.maxAngle = Math.PI;
            this.minAngle = -Math.PI;
         }
         this.lockMask.clear();
      }
      
      public function get appliedControlState() : int
      {
         return this._appliedControlState;
      }
      
      public function setInitialDirection(param1:Number) : void
      {
         this.initialDirection = param1;
      }
      
      public function lock(param1:int) : void
      {
         this.lockMask.change(param1,true);
         if(this.isLocked())
         {
            this.turnSpeed = 0;
            this.applyControlState(0);
         }
      }
      
      public function unlock(param1:int) : void
      {
         var _loc2_:Boolean = this.isLocked();
         this.lockMask.change(param1,false);
         if(!this.isLocked() && _loc2_)
         {
            this.centerTurret = false;
            this.applyControlState(this.controlState);
         }
      }
      
      public function setControlState(param1:int, param2:Boolean = false) : void
      {
         this.controlState = param1;
         if(this.isEnabled())
         {
            this.applyControlState(param1,param2);
         }
      }
      
      private function applyControlState(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = this._appliedControlState;
         this._appliedControlState = param1;
         var _loc4_:int = MathUtils.getBitValue(param1,BIT_LEFT);
         var _loc5_:int = MathUtils.getBitValue(param1,BIT_RIGHT);
         this.turnDirection = _loc4_ - _loc5_;
         this.centerTurret = _loc4_ + _loc5_ == 0 && (this.centerTurret || MathUtils.getBitValue(param1,BIT_CENTER) == 1);
         if(this._appliedControlState != _loc3_ || param2)
         {
            this.onControlStateChanged(this._appliedControlState);
         }
      }
      
      protected function onControlStateChanged(param1:int) : void
      {
         if(this.listener != null)
         {
            this.listener.onTurretControlStateChanged(param1);
         }
      }
      
      public function setDirectionImmediate(param1:Number) : void
      {
         this.currDirection = param1;
      }
      
      public function setTargetDirection(param1:Number) : void
      {
         var _loc2_:Number = this.angleDiff(param1,this.targetAngle);
         if(Math.abs(_loc2_) > IGNORE_TARGET_ANGLE_VALUE)
         {
            this.targetAngle = param1;
            this.rotationMode = true;
            this.targetAngleChanged = true;
         }
      }
      
      public function getDirection() : Number
      {
         return this.currDirection;
      }
      
      public function getControl() : int
      {
         return this.isEnabled() ? this.controlState : 0;
      }
      
      public function clearRotationLimits() : void
      {
         this.maxAngle = Math.PI;
         this.minAngle = -Math.PI;
      }
      
      public function rotate(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         if(this.rotationMode)
         {
            this.computeRotation(param1);
         }
         this.setControlState(this.controlState,this.forceControlState);
         this.forceControlState = false;
         this.prevDirection = this.currDirection;
         this.maxTurnSpeed = this.maxTurnSpeedSmoother.update(param1);
         if(this.lockMask.isEmpty())
         {
            if(this.centerTurret)
            {
               if(this.currDirection == this.initialDirection)
               {
                  this.finishTurretCentering();
                  return;
               }
               _loc2_ = this.currDirection < this.initialDirection ? 1 : -1;
            }
            else
            {
               _loc2_ = this.turnDirection;
            }
            if(this.prevTurnDirection != _loc2_)
            {
               this.turnSpeed = 0;
               this.prevTurnDirection = _loc2_;
            }
            if(_loc2_ == 0)
            {
               this.turnSpeed = 0;
               return;
            }
            this.turnSpeed += _loc2_ * this.turnAcceleration * param1;
            this.turnSpeed = MathUtils.clamp(this.turnSpeed,-this.maxTurnSpeed,this.maxTurnSpeed);
            _loc3_ = this.currDirection < this.initialDirection;
            this.currDirection += this.turnSpeed * param1;
            if(this.centerTurret && _loc3_ != this.currDirection < this.initialDirection)
            {
               this.currDirection = this.initialDirection;
               this.finishTurretCentering();
               return;
            }
            this.currDirection = MathUtils.clampAngle(this.currDirection);
            this.currDirection = MathUtils.clamp(this.currDirection,this.minAngle,this.maxAngle);
         }
      }
      
      private function computeRotation(param1:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         this.controlState = 0;
         var _loc2_:Number = this.angleDiff(this.targetAngle,this.getDirection());
         var _loc3_:Number = Math.abs(_loc2_);
         if(_loc3_ >= EPSILON)
         {
            _loc4_ = this.getMaxTurnSpeed() * param1;
            if(_loc3_ < _loc4_ && !this.targetAngleChanged)
            {
               _loc5_ = _loc4_ / ROTATION_FIXER;
               if(_loc3_ <= _loc5_)
               {
                  this.setDirectionImmediate(this.targetAngle);
                  this.rotationMode = false;
                  if(_loc3_ >= _loc4_ / ROTATION_IGNORE)
                  {
                     this.forceControlState = true;
                  }
               }
               else
               {
                  this.setDirectionImmediate(this.getDirection() + _loc2_ / 2);
               }
            }
            else
            {
               if(_loc2_ < 0)
               {
                  this.controlState = MathUtils.changeBitValue(this.controlState,BIT_RIGHT,true);
                  this.controlState = MathUtils.changeBitValue(this.controlState,BIT_LEFT,false);
               }
               else if(_loc2_ > 0)
               {
                  this.controlState = MathUtils.changeBitValue(this.controlState,BIT_LEFT,true);
                  this.controlState = MathUtils.changeBitValue(this.controlState,BIT_RIGHT,false);
               }
               this.targetAngleChanged = false;
            }
         }
      }
      
      private function angleDiff(param1:Number, param2:Number) : Number
      {
         return Math.atan2(Math.sin(param1 - param2),Math.cos(param1 - param2));
      }
      
      private function finishTurretCentering() : void
      {
         this.centerTurret = false;
         this.turnSpeed = 0;
      }
      
      public function updatePhysics(param1:Body) : void
      {
         this.applyGyroscopeEffect(param1);
      }
      
      private function applyGyroscopeEffect(param1:Body) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.gyroscopePower > 0)
         {
            param1.prevState.orientation.getYAxis(yAxisPrev);
            param1.prevState.orientation.getZAxis(zAxisPrev);
            param1.state.orientation.getYAxis(yAxisNext);
            tmpVector.cross2(yAxisNext,yAxisPrev);
            _loc2_ = tmpVector.dot(zAxisPrev);
            _loc3_ = yAxisPrev.dot(yAxisNext);
            _loc4_ = Math.atan2(_loc2_,_loc3_);
            this.currDirection += _loc4_ * this.gyroscopePower;
         }
      }
      
      public function getInterpolatedDirection(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = this.currDirection - this.prevDirection;
         if(_loc3_ < -Math.PI)
         {
            _loc2_ = this.prevDirection + param1 * (MathUtils.PI2 + _loc3_);
            if(_loc2_ > Math.PI)
            {
               _loc2_ -= MathUtils.PI2;
            }
         }
         else if(_loc3_ > Math.PI)
         {
            _loc2_ = this.prevDirection - param1 * (MathUtils.PI2 - _loc3_);
            if(_loc2_ < -Math.PI)
            {
               _loc2_ += MathUtils.PI2;
            }
         }
         else
         {
            _loc2_ = this.prevDirection + param1 * _loc3_;
         }
         return _loc2_;
      }
      
      public function isRotating() : Boolean
      {
         return this.turnSpeed != 0;
      }
      
      public function reset() : void
      {
         this.turnSpeed = 0;
         this.prevDirection = 0;
         this.currDirection = this.initialDirection;
         this.maxTurnSpeedSmoother.reset(this.maxTurnSpeedSmoother.getTargetValue());
         this.centerTurret = false;
         if(this.clearDirectionOnReset)
         {
            this.turnDirection = 0;
         }
      }
      
      public function setListener(param1:ITurretControllerListener) : void
      {
         this.listener = param1;
         this.setControlState(0);
         this.targetAngle = 0;
      }
      
      public function setMaxTurnSpeed(param1:Number, param2:Boolean) : void
      {
         if(param2)
         {
            this.maxTurnSpeed = param1;
            this.maxTurnSpeedSmoother.reset(param1);
         }
         else
         {
            this.maxTurnSpeedSmoother.setTargetValue(param1);
         }
      }
      
      public function getMaxTurnSpeed() : Number
      {
         return this.maxTurnSpeedSmoother.getTargetValue();
      }
      
      public function setTurnAcceleration(param1:Number) : void
      {
         this.turnAcceleration = param1;
      }
      
      public function getTurnAcceleration() : Number
      {
         return this.turnAcceleration;
      }
      
      protected function isLocked() : Boolean
      {
         return !this.lockMask.isEmpty();
      }
      
      public function isEnabled() : Boolean
      {
         return this.lockMask.isEmpty();
      }
      
      public function setGyroscopePower(param1:Number) : void
      {
         this.gyroscopePower = param1;
      }
      
      public function rotateLeft(param1:Boolean) : void
      {
         this.setState(TurretController.BIT_LEFT,param1);
         this.rotationMode = false;
      }
      
      public function rotateRight(param1:Boolean) : void
      {
         this.setState(TurretController.BIT_RIGHT,param1);
         this.rotationMode = false;
      }
      
      public function rotateUp(param1:Boolean) : void
      {
         this.setState(TurretController.BIT_UP,param1);
         this.rotationMode = false;
      }
      
      public function rotateDown(param1:Boolean) : void
      {
         this.setState(TurretController.BIT_DOWN,param1);
         this.rotationMode = false;
      }
      
      public function center(param1:Boolean) : void
      {
         this.setState(TurretController.BIT_CENTER,param1);
         this.rotationMode = false;
      }
      
      private function setState(param1:int, param2:Boolean) : void
      {
         this.controlState = MathUtils.changeBitValue(this.controlState,param1,param2);
      }
      
      public function setCameraRotation(param1:Number) : void
      {
         this.freeRotation = param1;
         this._hasCameraRotation = true;
      }
      
      public function getCameraRotation() : Number
      {
         return this.freeRotation;
      }
      
      public function hasCameraRotation() : Boolean
      {
         return this._hasCameraRotation;
      }
      
      public function resetCameraRotation() : void
      {
         this.freeRotation = 0;
         this._hasCameraRotation = false;
      }
      
      public function stopCameraRotation() : void
      {
         this.targetAngle = this.getDirection();
      }
      
      public function saveKeyState(param1:uint, param2:Boolean) : void
      {
         if(param1 < this.keyState.length)
         {
            this.keyState[param1] = param2;
         }
      }
      
      public function loadKeyState(param1:uint) : Boolean
      {
         return param1 < this.keyState.length ? this.keyState[param1] : false;
      }
      
      public function resetSavedKeyStates() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.keyState.length)
         {
            this.keyState[_loc1_] = false;
            _loc1_++;
         }
      }
   }
}

