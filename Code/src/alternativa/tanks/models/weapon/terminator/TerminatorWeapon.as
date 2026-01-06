package alternativa.tanks.models.weapon.terminator
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.railgun.RailgunData;
   import alternativa.tanks.models.weapon.railgun.RailgunShotResult;
   import alternativa.tanks.models.weapon.railgun.RailgunUtils;
   import alternativa.tanks.models.weapon.rocketlauncher.Rocket;
   import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherEffects;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeaponState;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketLauncherPriorityCalculator;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
   import alternativa.tanks.models.weapon.terminator.state.PrimaryShotState;
   import alternativa.tanks.models.weapon.terminator.state.SecondaryShotState;
   import alternativa.tanks.models.weapons.common.CommonLocalWeapon;
   import alternativa.tanks.models.weapons.shell.ShellWeaponCommunication;
   import alternativa.tanks.models.weapons.targeting.PenetratingTargetingSystem;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import alternativa.tanks.models.weapons.targeting.direction.sector.SectorDirectionCalculator;
   import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
   import alternativa.tanks.models.weapons.targeting.processor.SingleTargetDirectionProcessor;
   import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunCC;
   import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class TerminatorWeapon extends CommonLocalWeapon implements ITerminatorWeapon
   {
      
      private static var shotId:int;
      
      private static var PRIMARY_BARRELS:* = 2;
      
      private static var SECONDARY_BARRELS:* = 6;
      
      private static const secondaryShotDirection:Vector3 = new Vector3();
      
      private var commonWeapon:TerminatorCommonWeapon;
      
      private var needReleaseTrigger:Boolean;
      
      private var openingTrigger:Boolean;
      
      private var primaryNextShotTime:int;
      
      private var primaryNextChargeTime:int;
      
      private var primaryCurrentBarrel:int;
      
      private var secondaryNextShotTime:int;
      
      private var secondaryCurrentBarrel:int;
      
      private var secondaryTarget:RocketTargetPoint = new RocketTargetPoint();
      
      private var primaryTargetingSystem:TargetingSystem;
      
      private var secondaryTargetingSystem:TargetingSystem;
      
      private var primaryShotState:RocketLauncherWeaponState;
      
      private var secondaryShotState:RocketLauncherWeaponState;
      
      private var currentState:RocketLauncherWeaponState;
      
      public function TerminatorWeapon(param1:RailgunData, param2:TerminatorCommonWeapon)
      {
         this.commonWeapon = param2;
         this.primaryTargetingSystem = new PenetratingTargetingSystem(param2.user,param2.weaponObject,param1.getWeakeningCoeff());
         var _loc3_:* = this.getSecondaryParams().shotRange;
         var _loc4_:TargetingPriorityCalculator = new TargetingPriorityCalculator(new RocketLauncherPriorityCalculator(param2.weaponObject,this.secondaryTarget,_loc3_));
         this.secondaryTargetingSystem = new TargetingSystem(new SectorDirectionCalculator(param2.user,param2.weaponObject,_loc3_,_loc4_),new SingleTargetDirectionProcessor(param2.user,_loc3_),_loc4_);
         this.secondaryTargetingSystem.getProcessor().setShotFromMuzzle();
         this.secondaryTargetingSystem = this.secondaryTargetingSystem;
         super(param2.weaponObject);
      }
      
      override public function init(param1:WeaponPlatform) : void
      {
         super.init(param1);
         this.commonWeapon.init(param1,gunParams);
         this.primaryShotState = new PrimaryShotState(this,this.commonWeapon.weaponObject.getReloadTimeMS(),this.getPrimaryParams().chargingTimeMsec);
         this.secondaryShotState = new SecondaryShotState(this,getWeaponPlatform(),this.commonWeapon.weaponObject.rocketLauncherObject,this.getSecondaryParams());
         this.switchToPrimary();
      }
      
      private function switchToPrimary() : void
      {
         this.currentState = this.primaryShotState;
      }
      
      private function switchToSecondary() : void
      {
         this.currentState = this.secondaryShotState;
      }
      
      private function getPrimaryParams() : RailgunCC
      {
         return this.commonWeapon.initParam.primaryCC;
      }
      
      private function getSecondaryParams() : RocketLauncherCC
      {
         return this.commonWeapon.initParam.secondaryCC;
      }
      
      override public function getStatus() : Number
      {
         return this.currentState.getStatus();
      }
      
      override public function runLogic(param1:int, param2:int) : void
      {
         if(this.needReleaseTrigger)
         {
            this.needReleaseTrigger = false;
            super.releaseTrigger();
         }
         this.currentState.update(param1);
      }
      
      public function switchToSecondaryState(param1:int) : void
      {
         this.switchToSecondary();
         this.currentState.start(param1);
      }
      
      public function secondaryOpen(param1:int) : void
      {
         if(!this.openingTrigger)
         {
            this.openingTrigger = true;
            this.commonWeapon.effects.createOpenEffect();
            this.commonWeapon.weaponObject.secondaryOpen(param1);
         }
      }
      
      public function secondaryHide(param1:int) : void
      {
         if(this.openingTrigger)
         {
            this.commonWeapon.effects.createHideEffect();
            this.commonWeapon.weaponObject.secondaryHide(param1);
            this.openingTrigger = false;
         }
      }
      
      override public function releaseTrigger() : void
      {
         this.needReleaseTrigger = true;
      }
      
      private function updateNextPrimaryShootTime(param1:int) : void
      {
         this.primaryNextChargeTime = param1 + this.getPrimaryParams().chargingTimeMsec;
         this.primaryNextShotTime = this.primaryNextChargeTime + this.commonWeapon.weaponObject.getReloadTimeMS();
      }
      
      private function updateNextSecondaryShotTime(param1:int) : void
      {
         this.secondaryNextShotTime = param1 + this.getSecondaryParams().salvoReloadTime;
      }
      
      public function startCharging(param1:int) : void
      {
         this.updateNextPrimaryShootTime(param1);
         this.commonWeapon.createPrimaryChargeEffects(this.primaryCurrentBarrel);
         this.commonWeapon.weaponObject.primaryCharge(param1,this.primaryCurrentBarrel);
      }
      
      public function getPrimaryNextChargeTime() : int
      {
         return this.primaryNextChargeTime;
      }
      
      public function getPrimaryNextShotTime() : int
      {
         return this.primaryNextShotTime;
      }
      
      public function shootPrimary(param1:int) : void
      {
         var _loc2_:RailgunShotResult = null;
         this.updateNextPrimaryShootTime(param1);
         getWeaponPlatform().getAllGunParams(gunParams,this.primaryCurrentBarrel);
         getWeaponPlatform().getBody().addWorldForceScaled(gunParams.barrelOrigin,gunParams.direction,-this.commonWeapon.weaponObject.commonData().getRecoilForce());
         getWeaponPlatform().addDust();
         if(BattleUtils.isTurretAboveGround(getWeaponPlatform().getBody(),gunParams))
         {
            _loc2_ = new RailgunShotResult();
            _loc2_.setFromTargetingResult(this.primaryTargetingSystem.target(gunParams));
            if(_loc2_.hitPoints.length > 0)
            {
               this.applyPrimaryImpactToTargets(_loc2_);
            }
            this.createPrimaryShotEffect(_loc2_,gunParams);
            this.commonWeapon.weaponObject.primaryShot(param1,_loc2_.getStaticHitPoint(),_loc2_.targets,_loc2_.hitPoints,this.primaryCurrentBarrel);
         }
         else
         {
            this.commonWeapon.weaponObject.primaryDummyShot(param1,this.primaryCurrentBarrel);
         }
         this.primaryCurrentBarrel = (this.primaryCurrentBarrel + 1) % PRIMARY_BARRELS;
      }
      
      private function applyPrimaryImpactToTargets(param1:RailgunShotResult) : void
      {
         var _loc4_:Tank = null;
         var _loc2_:Number = 1;
         var _loc3_:int = 0;
         while(_loc3_ < param1.targets.length)
         {
            _loc4_ = param1.targets[_loc3_].tank;
            _loc4_.applyWeaponHit(param1.hitPoints[_loc3_],param1.shotDirection,this.commonWeapon.weaponObject.commonData().getImpactForce() * _loc2_);
            _loc2_ *= this.getPrimaryParams().weakeningCoeff;
            _loc3_++;
         }
      }
      
      public function shootSecondary(param1:int, param2:Number) : void
      {
         this.updateNextPrimaryShootTime(param1);
         this.updateNextSecondaryShotTime(param1);
         this.releaseTrigger();
         getWeaponPlatform().getAllGunParams(gunParams,PRIMARY_BARRELS + this.secondaryCurrentBarrel);
         var _loc3_:Vector3 = BattleUtils.tmpVector;
         _loc3_.cross2(gunParams.elevationAxis,gunParams.direction).normalize();
         var _loc4_:Number = Math.sqrt(1 - param2 * param2);
         secondaryShotDirection.copy(_loc3_).scale(param2).addScaled(_loc4_,gunParams.direction);
         if(BattleUtils.isTurretAboveGround(getWeaponPlatform().getBody(),gunParams))
         {
            if(this.secondaryTarget.hasTarget())
            {
               this.getShellCommunication().tryToShootWithTarget(param1,PRIMARY_BARRELS + this.secondaryCurrentBarrel,shotId,secondaryShotDirection,this.secondaryTarget.getTank(),this.secondaryTarget.getLocalPoint());
            }
            this.launchRocket();
         }
         else
         {
            this.getShellCommunication().tryToDummyShoot(param1,PRIMARY_BARRELS + this.secondaryCurrentBarrel);
         }
         this.commonWeapon.createSecondaryShotEffects(PRIMARY_BARRELS + this.secondaryCurrentBarrel);
         this.secondaryCurrentBarrel = this.secondaryCurrentBarrel >= SECONDARY_BARRELS - 1 ? 0 : this.secondaryCurrentBarrel + 1;
      }
      
      private function getShellCommunication() : ShellWeaponCommunication
      {
         return this.commonWeapon.weaponObject.rocketLauncherObject.shellCommunication();
      }
      
      private function launchRocket() : void
      {
         var _loc1_:Rocket = Rocket(battleService.getObjectPool().getObject(Rocket));
         _loc1_.init(this.getSecondaryParams(),this.commonWeapon.weaponObject.rocketLauncherObject,this.secondaryTarget,PRIMARY_BARRELS + this.secondaryCurrentBarrel,this.commonWeapon.effects.rocketLauncherEffects);
         _loc1_.addToGame(gunParams,secondaryShotDirection,getWeaponPlatform().getBody(),false,shotId++);
      }
      
      override public function reset() : void
      {
         super.reset();
         this.commonWeapon.resetEffects();
         this.secondaryTarget.resetTarget();
         this.primaryCurrentBarrel = 0;
         this.secondaryCurrentBarrel = 0;
         this.switchToPrimary();
      }
      
      override public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.TERMINATOR_RESISTANCE;
      }
      
      public function getTarget() : RocketTargetPoint
      {
         return this.secondaryTarget;
      }
      
      public function getTargetingSystem() : TargetingSystem
      {
         return this.secondaryTargetingSystem;
      }
      
      override protected function start(param1:int) : void
      {
         super.start(param1);
         this.currentState.start(param1);
      }
      
      override protected function stop(param1:int, param2:Boolean) : void
      {
         this.currentState.stop(param1);
         super.stop(param1,param2);
      }
      
      public function getEffects() : RocketLauncherEffects
      {
         return this.commonWeapon.effects.rocketLauncherEffects;
      }
      
      public function onEndingOfSalvo(param1:int) : void
      {
         super.reset();
         this.releaseTrigger();
         this.switchToPrimary();
         this.secondaryHide(param1);
      }
      
      private function createPrimaryShotEffect(param1:RailgunShotResult, param2:AllGlobalGunParams) : void
      {
         var _loc3_:Vector3 = param1.getStaticHitPoint();
         if(_loc3_ == null && param1.targets.length > 0)
         {
            _loc3_ = RailgunUtils.getDistantPoint(param2.barrelOrigin,param1.shotDirection);
         }
         this.commonWeapon.effects.createRecoilEffect(this.primaryCurrentBarrel);
         this.commonWeapon.effects.railgunEffects.createShotTrail(param2.muzzlePosition,_loc3_,param2.direction);
         this.commonWeapon.effects.railgunEffects.createStaticHitMark(param2.barrelOrigin,param1.getStaticHitPoint());
         if(_loc3_ == null)
         {
            return;
         }
         if(param1.hasStaticHit)
         {
            this.commonWeapon.effects.railgunEffects.createStaticHitEffect(param2.muzzlePosition,param1.staticHitPoint,param1.staticHitNormal);
         }
         if(param1.targets.length > 0)
         {
            this.commonWeapon.effects.railgunEffects.createTargetHitEffects(param2.muzzlePosition,_loc3_,param1.hitPoints,param1.targets);
         }
      }
      
      public function canShoot(param1:int) : Boolean
      {
         return isShooting() && param1 >= this.secondaryNextShotTime;
      }
      
      public function salvoShoot(param1:int, param2:Number) : void
      {
         this.shootSecondary(param1,param2);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.switchToPrimary();
         this.secondaryTarget = null;
         this.secondaryTargetingSystem = null;
         this.commonWeapon.destroy();
         this.commonWeapon = null;
      }
   }
}

