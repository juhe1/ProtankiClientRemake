package alternativa.tanks.models.weapon.rocketlauncher.weapon
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.rocketlauncher.Rocket;
   import alternativa.tanks.models.weapon.rocketlauncher.RocketLauncherObject;
   import alternativa.tanks.models.weapon.rocketlauncher.radio.RocketExplodeEvent;
   import alternativa.tanks.models.weapon.rocketlauncher.radio.RocketExplosion;
   import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherEffects;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketLauncherPriorityCalculator;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.SalvoShotState;
   import alternativa.tanks.models.weapons.common.CommonLocalWeapon;
   import alternativa.tanks.models.weapons.targeting.TargetingResult;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import alternativa.tanks.models.weapons.targeting.direction.sector.SectorDirectionCalculator;
   import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
   import alternativa.tanks.models.weapons.targeting.processor.SingleTargetDirectionProcessor;
   import flash.utils.getTimer;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class RocketLauncherWeapon extends CommonLocalWeapon implements IRocketLauncherWeapon
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private static var shotId:int;
      
      private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private static const shotDirection:Vector3 = new Vector3();
      
      private var reloadingEndTime:int;
      
      private var reloadingDuration:int;
      
      private var currentBarrelIndex:int;
      
      private var needReleaseTrigger:Boolean;
      
      private var target:RocketTargetPoint = new RocketTargetPoint();
      
      private var targetingSystem:TargetingSystem;
      
      private var weaponObject:RocketLauncherObject;
      
      private var effects:RocketLauncherEffects;
      
      private var rocketLauncherParams:RocketLauncherCC;
      
      private var simpleShotState:SimpleShotState;
      
      private var salvoShotState:SalvoShotState;
      
      private var currentState:RocketLauncherWeaponState;
      
      public function RocketLauncherWeapon(param1:IGameObject, param2:RocketLauncherObject, param3:RocketLauncherCC)
      {
         this.weaponObject = param2;
         this.rocketLauncherParams = param3;
         var _loc4_:Number = param3.shotRange;
         var _loc5_:RocketLauncherPriorityCalculator = new RocketLauncherPriorityCalculator(param2,this.target,_loc4_);
         var _loc6_:TargetingPriorityCalculator = new TargetingPriorityCalculator(_loc5_);
         this.targetingSystem = new TargetingSystem(new SectorDirectionCalculator(param1,param2,_loc4_,_loc6_),new SingleTargetDirectionProcessor(param1,_loc4_),_loc6_);
         this.targetingSystem.getProcessor().setShotFromMuzzle();
         super(param2);
      }
      
      override public function init(param1:WeaponPlatform) : void
      {
         super.init(param1);
         this.effects = new RocketLauncherEffects(this.weaponObject.getSfxData(),param1.getTurret3D());
         this.simpleShotState = new SimpleShotState(this,this.weaponObject.getReloadTimeMS());
         this.salvoShotState = new SalvoShotState(this,getWeaponPlatform(),this.weaponObject,this.rocketLauncherParams);
         this.currentState = this.simpleShotState;
      }
      
      override public function getStatus() : Number
      {
         return this.currentState.getStatus();
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
      
      override public function releaseTrigger() : void
      {
         this.needReleaseTrigger = true;
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
      
      public function simpleShoot(param1:int) : void
      {
         getWeaponPlatform().getAllGunParams(allGunParams,this.currentBarrelIndex);
         shotDirection.copy(allGunParams.direction);
         this.target.resetTarget();
         this.shoot(param1);
      }
      
      public function salvoShoot(param1:int, param2:Number) : void
      {
         getWeaponPlatform().getAllGunParams(allGunParams,this.currentBarrelIndex);
         var _loc3_:Vector3 = BattleUtils.tmpVector;
         _loc3_.cross2(allGunParams.elevationAxis,allGunParams.direction).normalize();
         var _loc4_:Number = Math.sqrt(1 - param2 * param2);
         shotDirection.copy(_loc3_).scale(param2).addScaled(_loc4_,allGunParams.direction);
         this.shoot(param1);
      }
      
      private function shoot(param1:int) : void
      {
         this.reload(param1,this.currentState.getReloadTime());
         var _loc2_:WeaponPlatform = getWeaponPlatform();
         var _loc3_:Body = _loc2_.getBody();
         if(BattleUtils.isTurretAboveGround(_loc3_,allGunParams))
         {
            this.doRealShot(param1);
         }
         else
         {
            this.weaponObject.shellCommunication().tryToDummyShoot(param1,this.currentBarrelIndex);
         }
         this.createShotEffects();
         this.currentBarrelIndex = (this.currentBarrelIndex + 1) % _loc2_.getNumberOfBarrels();
      }
      
      private function reload(param1:int, param2:int) : void
      {
         this.reloadingDuration = param2;
         this.reloadingEndTime = param1 + param2;
      }
      
      private function createShotEffects() : void
      {
         var _loc1_:WeaponCommonData = this.weaponObject.commonData();
         var _loc2_:WeaponPlatform = getWeaponPlatform();
         _loc2_.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-_loc1_.getRecoilForce());
         _loc2_.addDust();
         this.effects.playShotEffect(allGunParams.muzzlePosition,this.currentBarrelIndex);
      }
      
      private function doRealShot(param1:int) : void
      {
         if(this.target.hasTarget())
         {
            this.weaponObject.shellCommunication().tryToShootWithTarget(param1,this.currentBarrelIndex,shotId,shotDirection,this.target.getTank(),this.target.getLocalPoint());
         }
         else
         {
            this.calculateShotDirectionIfNeed();
            this.weaponObject.shellCommunication().tryToShoot(param1,this.currentBarrelIndex,shotId,shotDirection);
         }
         var _loc2_:Rocket = Rocket(battleService.getObjectPool().getObject(Rocket));
         _loc2_.init(this.rocketLauncherParams,this.weaponObject,this.target,this.currentBarrelIndex,this.effects,RocketExplodeEvent.ALL);
         _loc2_.addToGame(allGunParams,shotDirection,getWeaponPlatform().getBody(),false,shotId++);
      }
      
      private function calculateShotDirectionIfNeed() : void
      {
         var _loc1_:TargetingResult = null;
         if(!BattleUtils.barrelCollidesWithStatic(allGunParams))
         {
            _loc1_ = this.targetingSystem.target(allGunParams);
            shotDirection.copy(_loc1_.getDirection());
         }
      }
      
      public function canExplodeRockets() : Boolean
      {
         return this.weaponObject.getObject().hasModel(RocketExplosion);
      }
      
      public function explodeRockets() : void
      {
         this.weaponObject.dispatchEvent(new RocketExplodeEvent(RocketExplodeEvent.ALL));
      }
      
      public function switchToSalvoState(param1:int) : void
      {
         this.currentState = this.salvoShotState;
         this.salvoShotState.start(param1);
      }
      
      public function onEndingOfSalvo(param1:int) : void
      {
         super.reset();
         this.currentState = this.simpleShotState;
      }
      
      public function getReloadingEndTime() : int
      {
         return this.reloadingEndTime;
      }
      
      public function getReloadingDuration() : int
      {
         return this.reloadingDuration;
      }
      
      public function canShoot(param1:int) : Boolean
      {
         return isShooting() && param1 >= this.reloadingEndTime;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.target.resetTarget();
         this.reloadingEndTime = getTimer();
         this.currentBarrelIndex = 0;
         this.currentState = this.simpleShotState;
      }
      
      override public function disable(param1:Boolean) : void
      {
         super.disable(param1);
         this.target.resetTarget();
         this.currentState = this.simpleShotState;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.simpleShotState.close();
         this.simpleShotState = null;
         this.salvoShotState.close();
         this.salvoShotState = null;
         this.target = null;
         this.targetingSystem = null;
         this.weaponObject = null;
         this.rocketLauncherParams = null;
         this.currentState = null;
      }
      
      override public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.ROCKET_LAUNCHER_RESISTANCE;
      }
      
      public function getTargetingSystem() : TargetingSystem
      {
         return this.targetingSystem;
      }
      
      public function getTarget() : RocketTargetPoint
      {
         return this.target;
      }
      
      public function getEffects() : RocketLauncherEffects
      {
         return this.effects;
      }
   }
}

