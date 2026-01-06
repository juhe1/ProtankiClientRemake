package alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo
{
   import alternativa.math.Vector3;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponUtils;
   import alternativa.tanks.models.weapon.laser.LaserPointer;
   import alternativa.tanks.models.weapon.rocketlauncher.RocketLauncherObject;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.IRocketLauncherWeapon;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeaponState;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim.RocketLauncherAim;
   import alternativa.tanks.models.weapons.charging.WeaponChargingCommunication;
   import alternativa.tanks.models.weapons.targeting.TargetingResult;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import flash.utils.getTimer;
   import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;
   
   public class SalvoShotState implements RocketLauncherWeaponState
   {
      
      private static const gunParamsForSalvo:AllGlobalGunParams = new AllGlobalGunParams();
      
      private var salvoStartTime:int;
      
      private var nextSalvoShotTime:int;
      
      private var numberOfRemainingShots:int;
      
      private var weapon:IRocketLauncherWeapon;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var target:RocketTargetPoint;
      
      private var targetingSystem:TargetingSystem;
      
      private var rocketLauncherParams:RocketLauncherCC;
      
      private var aim:RocketLauncherAim;
      
      private var laser:LaserPointer;
      
      private var chargingCommunication:WeaponChargingCommunication;
      
      private var shotDirectionVerticalProjection:Number;
      
      private var endGracePeriodTime:int;
      
      public function SalvoShotState(param1:IRocketLauncherWeapon, param2:WeaponPlatform, param3:RocketLauncherObject, param4:RocketLauncherCC)
      {
         super();
         this.weapon = param1;
         this.weaponPlatform = param2;
         this.targetingSystem = param1.getTargetingSystem();
         this.target = param1.getTarget();
         this.rocketLauncherParams = param4;
         this.laser = param3.laser();
         this.chargingCommunication = param3.charging();
         this.aim = new RocketLauncherAim(this.target,param1);
      }
      
      public function start(param1:int) : void
      {
         if(this.weapon.canShoot(param1))
         {
            this.resetAiming();
            this.numberOfRemainingShots = this.rocketLauncherParams.salvoSize;
         }
      }
      
      public function getStatus() : Number
      {
         var _loc1_:int = this.salvoStartTime;
         if(this.target.isLost())
         {
            _loc1_ += this.rocketLauncherParams.salvoAimingGracePeriod - (this.endGracePeriodTime - getTimer());
         }
         return Math.max((_loc1_ - getTimer()) / this.rocketLauncherParams.salvoAimingTime,0);
      }
      
      public function update(param1:int) : void
      {
         if(param1 < this.salvoStartTime || this.target.isLost())
         {
            this.actualizeTarget(param1);
            return;
         }
         if(this.numberOfRemainingShots > 0 && param1 >= this.nextSalvoShotTime)
         {
            this.doSalvoShot(param1);
         }
      }
      
      private function actualizeTarget(param1:int) : void
      {
         this.resetAimingIfTargetNotAlive();
         WeaponUtils.calculateMainGunParams(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLaserLocalPosition(),gunParamsForSalvo);
         if(!BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),gunParamsForSalvo) || BattleUtils.barrelCollidesWithStatic(gunParamsForSalvo))
         {
            this.laser.hideLaser();
            this.resetAiming();
            return;
         }
         var _loc2_:TargetingResult = this.targetingSystem.target(gunParamsForSalvo);
         if(_loc2_.hasTankHit())
         {
            this.updateTarget(_loc2_,param1);
         }
         else
         {
            this.loseTarget(_loc2_,param1);
         }
      }
      
      private function resetAimingIfTargetNotAlive() : void
      {
         if(!this.target.isAlive())
         {
            this.resetAiming();
         }
      }
      
      private function updateTarget(param1:TargetingResult, param2:int) : void
      {
         var _loc3_:RayHit = param1.getSingleHit();
         var _loc4_:Tank = _loc3_.shape.body.tank;
         if(!this.target.hasTarget())
         {
            this.setTarget(_loc4_,param2);
         }
         if(!this.target.isSameTank(_loc4_))
         {
            this.loseTarget(param1,param2);
            return;
         }
         if(this.target.isLost())
         {
            this.salvoStartTime += this.rocketLauncherParams.salvoAimingGracePeriod - (this.endGracePeriodTime - param2);
            this.nextSalvoShotTime = this.salvoStartTime;
         }
         var _loc5_:Vector3 = this.getTargetLocalPoint(_loc3_,_loc4_);
         this.laser.aimAtTank(_loc4_,_loc5_);
         this.target.setLocalPoint(_loc5_);
         this.updateShotDirection(param1);
      }
      
      private function setTarget(param1:Tank, param2:int) : void
      {
         if(param1.state == ClientTankState.ACTIVE && !param1.isSameTeam(this.weaponPlatform.teamType))
         {
            this.target.setTank(param1);
            this.aim.show();
            this.salvoStartTime = param2 + this.rocketLauncherParams.salvoAimingTime;
            this.nextSalvoShotTime = this.salvoStartTime;
            this.chargingCommunication.startCharging(param2);
         }
         else
         {
            this.resetAiming();
         }
      }
      
      private function getTargetLocalPoint(param1:RayHit, param2:Tank) : Vector3
      {
         var _loc3_:Vector3 = BattleUtils.tmpVector;
         _loc3_.copy(param1.position);
         BattleUtils.globalToLocal(param2.getBody(),_loc3_);
         return _loc3_;
      }
      
      private function updateShotDirection(param1:TargetingResult) : void
      {
         var _loc2_:Vector3 = BattleUtils.tmpVector;
         _loc2_.cross2(gunParamsForSalvo.elevationAxis,gunParamsForSalvo.direction).normalize();
         this.shotDirectionVerticalProjection = _loc2_.dot(param1.getDirection());
      }
      
      private function loseTarget(param1:TargetingResult, param2:int) : void
      {
         this.laser.updateDirection(param1.getDirection());
         if(this.target.hasTarget() && !this.target.isLost())
         {
            this.target.markAsLost();
            this.endGracePeriodTime = param2 + this.rocketLauncherParams.salvoAimingGracePeriod;
         }
         if(!this.target.hasTarget() || param2 > this.endGracePeriodTime)
         {
            this.resetAiming();
         }
      }
      
      private function doSalvoShot(param1:int) : void
      {
         if(this.numberOfRemainingShots == this.rocketLauncherParams.salvoSize)
         {
            this.finishAiming(param1);
         }
         this.laser.hideLaser();
         --this.numberOfRemainingShots;
         this.nextSalvoShotTime = param1 + this.rocketLauncherParams.timeBetweenShotsOfSalvo;
         this.weapon.salvoShoot(param1,this.shotDirectionVerticalProjection);
         if(this.numberOfRemainingShots <= 0)
         {
            this.completeSalvo(param1);
         }
      }
      
      private function finishAiming(param1:int) : void
      {
         this.chargingCommunication.finishCharging(param1);
         this.weapon.getEffects().playAimingCompleteSoundEffect();
      }
      
      public function stop(param1:int) : void
      {
         if(param1 < this.salvoStartTime)
         {
            this.completeSalvo(param1);
         }
      }
      
      private function completeSalvo(param1:int) : void
      {
         this.resetAiming();
         this.laser.hideLaser();
         this.numberOfRemainingShots = 0;
         this.weapon.onEndingOfSalvo(param1);
      }
      
      public function getReloadTime() : int
      {
         return this.rocketLauncherParams.salvoReloadTime;
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.resetAiming();
         this.laser.hideLaser();
         this.weapon = null;
         this.target = null;
         this.targetingSystem = null;
         this.rocketLauncherParams = null;
         this.aim = null;
         this.laser = null;
      }
      
      private function resetAiming() : void
      {
         this.target.resetTarget();
         this.aim.hide();
         this.salvoStartTime = int.MAX_VALUE;
         this.nextSalvoShotTime = int.MAX_VALUE;
      }
   }
}

