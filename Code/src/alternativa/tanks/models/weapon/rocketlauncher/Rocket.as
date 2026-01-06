package alternativa.tanks.models.weapon.rocketlauncher
{
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.loaders.Parser3DS;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleRunner;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.rocketlauncher.radio.RocketExplodeEvent;
   import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketFlightEffect;
   import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherEffects;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
   import alternativa.tanks.models.weapon.splash.Splash;
   import alternativa.tanks.models.weapons.shell.InelasticShell;
   import alternativa.tanks.models.weapons.shell.ShellWeaponCommunication;
   import alternativa.tanks.utils.objectpool.Pool;
   import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;
   
   public class Rocket extends InelasticShell
   {
      
      private static var baseRocketMesh:Mesh;
      
      private static const COS_ALMOST_ZERO_ANGLE:Number = 0.999;
      
      private static const POSITION_ACCURACY:Number = 0.1;
      
      private static const rocket3dsClass:Class = Rocket_rocket3dsClass;
      
      private static const _cross:Vector3 = new Vector3();
      
      private static const _toTarget:Vector3 = new Vector3();
      
      private var time:Number;
      
      private var impactForce:Number;
      
      private var barrelIndex:int;
      
      private var shellWeaponCommunication:ShellWeaponCommunication;
      
      private var splash:Splash;
      
      private var targetTank:Tank;
      
      private var targetLocalPoint:Vector3;
      
      private var rocketMesh:Mesh;
      
      private var weaponObject:RocketLauncherObject;
      
      private var rocketLauncherParams:RocketLauncherCC;
      
      private var effects:RocketLauncherEffects;
      
      private var flightEffect:RocketFlightEffect;
      
      private var explodeEvent:String;
      
      public function Rocket(param1:Pool)
      {
         var _loc2_:Parser3DS = null;
         this.targetLocalPoint = new Vector3();
         super(param1);
         if(baseRocketMesh == null)
         {
            _loc2_ = new Parser3DS();
            _loc2_.parse(new rocket3dsClass());
            baseRocketMesh = Mesh(_loc2_.objects[0]);
            baseRocketMesh.optimizeForDynamicBSP();
            baseRocketMesh.sorting = Sorting.DYNAMIC_BSP;
            baseRocketMesh.weldVertices(0.1,0.01);
            baseRocketMesh.weldFaces(0.001,0.01,0.001);
            baseRocketMesh.calculateFacesNormals();
            baseRocketMesh.calculateVerticesNormalsBySmoothingGroups(0.1);
            baseRocketMesh.calculateBounds();
            baseRocketMesh.shadowMapAlphaThreshold = 2;
            baseRocketMesh.depthMapAlphaThreshold = 2;
         }
         this.rocketMesh = Mesh(baseRocketMesh.clone());
      }
      
      public function init(param1:RocketLauncherCC, param2:RocketLauncherObject, param3:RocketTargetPoint, param4:int, param5:RocketLauncherEffects, param6:String = "") : void
      {
         this.explodeEvent = param6;
         param2.addEventListener(param6,this.explode);
         this.rocketLauncherParams = param1;
         this.weaponObject = param2;
         this.effects = param5;
         var _loc7_:WeaponCommonData = param2.commonData();
         this.impactForce = _loc7_.getImpactForce();
         this.splash = param2.splash();
         this.shellWeaponCommunication = param2.shellCommunication();
         this.barrelIndex = param4;
         this.rocketMesh.setMaterialToAllFaces(param2.getSfxData().rocketTexture);
         if(param3.hasTarget())
         {
            this.targetTank = param3.getTank();
            this.targetLocalPoint.copy(param3.getLocalPoint());
         }
         else
         {
            this.targetTank = null;
            this.targetLocalPoint.reset();
         }
      }
      
      override public function addToGame(param1:AllGlobalGunParams, param2:Vector3, param3:Body, param4:Boolean, param5:int) : void
      {
         super.addToGame(param1,param2,param3,param4,param5);
         this.time = 0;
         var _loc6_:Matrix3 = BattleUtils.tmpMatrix3;
         _loc6_.setDirectionVector(param2);
         this.setRocketRotation(_loc6_);
         battleService.getBattleScene3D().addObject(this.rocketMesh);
         this.flightEffect = this.effects.createRocketFlightSoundEffect(this.rocketMesh,this.flightDirection);
      }
      
      override protected function handleFlightFinish() : void
      {
         this.processHitImpl(null,currPosition,flightDirection,totalDistance,BattleRunner.PHYSICS_STEP_IN_MS);
      }
      
      override protected function getMaxDistance() : Number
      {
         return this.rocketLauncherParams.shotRange;
      }
      
      public function explode(param1:RocketExplodeEvent) : void
      {
         var _loc2_:Number = NaN;
         if(param1.type == RocketExplodeEvent.ALL || param1.rocketId == getShotId())
         {
            _rayCastDirection.diff(currPosition,prevPosition);
            _loc2_ = _rayCastDirection.length();
            _rayCastDirection.normalize();
            processHit(null,currPosition,_rayCastDirection,_loc2_);
         }
      }
      
      override protected function updateTotalDistance(param1:Number) : void
      {
      }
      
      override protected function updatePosition(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         prevPosition.copy(currPosition);
         var _loc2_:Number = param1;
         if(this.hasTarget())
         {
            _toTarget.copy(this.targetLocalPoint);
            BattleUtils.localToGlobal(this.targetTank.getBody(),_toTarget);
            _toTarget.subtract(prevPosition).normalize();
            _loc3_ = flightDirection.dot(_toTarget);
            if(_loc3_ < COS_ALMOST_ZERO_ANGLE && _loc3_ > -COS_ALMOST_ZERO_ANGLE)
            {
               _cross.cross2(flightDirection,_toTarget).normalize();
               _loc4_ = Math.min(Math.acos(_loc3_),param1 * this.rocketLauncherParams.angularVelocity);
               _loc5_ = _loc4_ / this.rocketLauncherParams.angularVelocity;
               _loc2_ -= _loc5_;
               _loc6_ = _loc4_ / 2;
               _rotationMatrix.fromAxisAngle(_cross,_loc6_);
               flightDirection.transform3(_rotationMatrix).normalize();
               _loc7_ = this.getDistanceAndUpdateTotalDistance(_loc5_);
               _loc8_ = _loc7_ * Math.sin(_loc6_) / _loc6_;
               currPosition.addScaled(_loc8_,flightDirection);
               flightDirection.transform3(_rotationMatrix).normalize();
               this.rotateRocket(_rotationMatrix);
               initRadialPoints(prevPosition,flightDirection);
            }
         }
         if(_loc2_ > 0)
         {
            currPosition.addScaled(this.getDistanceAndUpdateTotalDistance(_loc2_),flightDirection);
         }
         this.savePrevPositionIfNeed();
      }
      
      private function savePrevPositionIfNeed() : void
      {
         if(isRemoteShot)
         {
            return;
         }
         if(!this.checkTrajectoryByAnticheat())
         {
            shellStates.savePrevPosition();
         }
      }
      
      private function checkTrajectoryByAnticheat() : Boolean
      {
         var _loc7_:Number = NaN;
         var _loc1_:Vector3 = shellStates.getLastControlDirection();
         var _loc2_:Vector3 = shellStates.getLastControlPosition();
         var _loc3_:Number = this.toSeconds(shellStates.getLastControlTime());
         var _loc4_:Number = this.toSeconds(shellStates.getTimeSinceLastControlState());
         var _loc5_:Number = _loc1_.dot(flightDirection);
         var _loc6_:Number = _loc2_.distanceTo(currPosition);
         if(_loc5_ < COS_ALMOST_ZERO_ANGLE && _loc5_ > -COS_ALMOST_ZERO_ANGLE)
         {
            _loc7_ = Math.acos(_loc5_) / 2;
            _loc6_ = _loc6_ * _loc7_ / Math.sin(_loc7_);
         }
         return _loc6_ <= this.calculateDistanceByTime(_loc3_,_loc4_) + POSITION_ACCURACY;
      }
      
      private function toSeconds(param1:int) : Number
      {
         return param1 * 0.001;
      }
      
      private function getDistanceAndUpdateTotalDistance(param1:Number) : Number
      {
         var _loc2_:Number = this.calculateDistanceByTime(this.time,param1);
         totalDistance += _loc2_;
         this.time += param1;
         return _loc2_;
      }
      
      private function calculateDistanceByTime(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = this.rocketLauncherParams.boostPhaseDuration / 1000;
         if(param1 >= _loc3_)
         {
            return this.uniformMotionDistance(param2);
         }
         var _loc4_:Number = (this.rocketLauncherParams.maxSpeed - this.rocketLauncherParams.minSpeed) / _loc3_;
         var _loc5_:Number = this.rocketLauncherParams.minSpeed + _loc4_ * param1;
         if(param1 + param2 <= _loc3_)
         {
            return this.uniformAccelerationMotionDistance(_loc5_,param2,_loc4_);
         }
         var _loc6_:Number = _loc3_ - param1;
         return this.uniformAccelerationMotionDistance(_loc5_,_loc6_,_loc4_) + this.uniformMotionDistance(param2 - _loc6_);
      }
      
      private function uniformMotionDistance(param1:Number) : Number
      {
         return param1 * this.rocketLauncherParams.maxSpeed;
      }
      
      private function uniformAccelerationMotionDistance(param1:Number, param2:Number, param3:Number) : Number
      {
         return param1 * param2 + param3 * param2 * param2 / 2;
      }
      
      private function rotateRocket(param1:Matrix3) : void
      {
         var _loc2_:Matrix3 = BattleUtils.tmpMatrix3;
         _loc2_.setRotationMatrixForObject3D(this.rocketMesh);
         _loc2_.append(param1).append(param1);
         this.setRocketRotation(_loc2_);
      }
      
      private function setRocketRotation(param1:Matrix3) : void
      {
         var _loc2_:Vector3 = null;
         _loc2_ = BattleUtils.tmpVector;
         param1.getEulerAngles(_loc2_);
         this.rocketMesh.rotationX = _loc2_.x;
         this.rocketMesh.rotationY = _loc2_.y;
         this.rocketMesh.rotationZ = _loc2_.z;
      }
      
      private function hasTarget() : Boolean
      {
         return this.targetTank != null && this.targetTank.state == ClientTankState.ACTIVE && this.targetTank.getBody() != null;
      }
      
      override protected function getTimeMsToHit(param1:Number) : int
      {
         return BattleRunner.PHYSICS_STEP_IN_MS;
      }
      
      override protected function processHitImpl(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:int) : void
      {
         var _loc6_:Tank = null;
         super.processHitImpl(param1,param2,param3,param4,param5);
         if(!this.weaponObject.isAlive())
         {
            this.destroy();
            return;
         }
         this.effects.playExplosionEffect(param2,param3,this.barrelIndex);
         this.splash.applySplashForce(param2,1,param1);
         if(BattleUtils.isTankBody(param1))
         {
            _loc6_ = param1.tank;
            _loc6_.applyWeaponHit(param2,param3,this.impactForce);
            this.weaponObject.shellCommunication().tryToHit(getShotId(),shellStates,param1.tank);
         }
         else
         {
            this.weaponObject.shellCommunication().tryToHit(getShotId(),shellStates);
         }
         this.destroy();
      }
      
      override public function render(param1:int, param2:int) : void
      {
         var _loc3_:Number = NaN;
         _loc3_ = param2 / thousandth.getInt();
         this.rocketMesh.x = interpolatedPosition.x;
         this.rocketMesh.y = interpolatedPosition.y;
         this.rocketMesh.z = interpolatedPosition.z;
         this.flightEffect.update(_loc3_);
      }
      
      override protected function destroy() : void
      {
         super.destroy();
         this.weaponObject.removeEventListener(this.explodeEvent,this.explode);
         this.flightEffect.close();
         battleService.getBattleScene3D().removeObject(this.rocketMesh);
         shooterBody = null;
         this.rocketMesh.setMaterialToAllFaces(null);
         this.shellWeaponCommunication = null;
         this.targetTank = null;
         this.targetLocalPoint.reset();
         this.flightEffect = null;
         this.effects = null;
      }
      
      override protected function getRadius() : Number
      {
         return this.rocketLauncherParams.shellRadius;
      }
   }
}

