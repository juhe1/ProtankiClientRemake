package alternativa.tanks.models.weapon.ricochet
{
   import alternativa.math.Vector3;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.LogicUnit;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
   import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import alternativa.tanks.utils.MathUtils;
   import flash.utils.getTimer;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetCC;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class RicochetWeapon extends BattleRunnerProvider implements Weapon, LogicUnit
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private static var shotId:int;
      
      private static const shotDirection:Vector3 = new Vector3();
      
      private static const rayHit:RayHit = new RayHit();
      
      private static const _gunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private var recoilForce:Number;
      
      private var energyRechargeRate:Number;
      
      private var nextShotTime:int;
      
      private var energyBaseTime:int;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var controller:SimpleWeaponController = new SimpleWeaponController();
      
      private var targetingSystem:RicochetTargetingSystem;
      
      private var reloadingTime:int;
      
      private var effects:RicochetEffects;
      
      private var ammunition:RicochetAmmunition;
      
      private var callback:RicochetWeaponCallback;
      
      private var enabled:Boolean;
      
      private var ricochetInitParams:RicochetCC;
      
      private var lastEnergy:int;
      
      public function RicochetWeapon(param1:IGameObject, param2:RicochetCC)
      {
         super();
         var _loc3_:IRicochetSFXModel = IRicochetSFXModel(param1.adapt(IRicochetSFXModel));
         var _loc4_:WeaponObject = new WeaponObject(param1);
         var _loc5_:RicochetWeaponCallback = RicochetWeaponCallback(param1.adapt(RicochetWeaponCallback));
         this.ricochetInitParams = param2;
         this.recoilForce = _loc4_.commonData().getRecoilForce();
         this.energyRechargeRate = param2.energyRechargeSpeed / 1000;
         this.targetingSystem = getTargetingSystem(_loc4_.verticalAutoAiming(),param2);
         this.reloadingTime = _loc4_.getReloadTimeMS();
         this.effects = _loc3_.getRicochetEffects();
         this.ammunition = new RicochetAmmunition(_loc4_,param2,_loc3_.getSfxData(),_loc5_);
         this.callback = _loc5_;
      }
      
      private static function getTargetingSystem(param1:VerticalAutoAiming, param2:RicochetCC) : RicochetTargetingSystem
      {
         var _loc3_:Number = Number(param1.getElevationAngleUp());
         var _loc4_:int = int(param1.getNumRaysUp());
         var _loc5_:Number = Number(param1.getElevationAngleDown());
         var _loc6_:int = int(param1.getNumRaysDown());
         var _loc7_:Number = param2.shotDistance;
         var _loc8_:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         return new RicochetTargetingSystem(_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,battleService.getRicochetTargetEvaluator(),param2.maxRicochetCount);
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
         this.controller.init();
      }
      
      public function destroy() : void
      {
         this.ricochetInitParams = null;
         this.effects = null;
         this.callback = null;
         this.targetingSystem = null;
         this.controller.destroy();
      }
      
      public function activate() : void
      {
         getBattleRunner().addLogicUnit(this);
      }
      
      public function deactivate() : void
      {
         getBattleRunner().removeLogicUnit(this);
      }
      
      public function enable() : void
      {
         if(!this.enabled)
         {
            this.enabled = true;
            this.controller.discardStoredAction();
         }
      }
      
      public function disable(param1:Boolean) : void
      {
         this.enabled = false;
      }
      
      public function reset() : void
      {
         this.energyBaseTime = 0;
         this.nextShotTime = 0;
         this.controller.discardStoredAction();
      }
      
      public function getStatus() : Number
      {
         return this.getEnergy(getTimer()) / this.ricochetInitParams.energyCapacity;
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         var _loc3_:Number = NaN;
         if(this.enabled)
         {
            if(this.controller.wasActive() && param1 >= this.nextShotTime)
            {
               _loc3_ = this.getEnergy(param1);
               if(_loc3_ >= this.ricochetInitParams.energyPerShot)
               {
                  this.shoot(param1,_loc3_);
               }
            }
         }
         this.controller.discardStoredAction();
      }
      
      private function shoot(param1:int, param2:Number) : void
      {
         this.lastEnergy = param2 - this.ricochetInitParams.energyPerShot;
         this.nextShotTime = param1 + this.reloadingTime;
         this.setEnergyBaseTime(param1,this.lastEnergy);
         this.weaponPlatform.getAllGunParams(_gunParams);
         this.weaponPlatform.addDust();
         this.applyRecoilForceToShooter(_gunParams.muzzlePosition,_gunParams.direction,-this.recoilForce);
         this.effects.createShotEffects(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLocalMuzzlePosition(),_gunParams.muzzlePosition);
         this.effects.createLightEffect(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLocalMuzzlePosition());
         if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),_gunParams))
         {
            this.doRealShot(param1,_gunParams);
         }
         else
         {
            this.doDummyShot(param1);
         }
      }
      
      private function applyRecoilForceToShooter(param1:Vector3, param2:Vector3, param3:Number) : void
      {
         this.weaponPlatform.getBody().addWorldForceScaled(param1,param2,param3);
      }
      
      private function doRealShot(param1:int, param2:AllGlobalGunParams) : void
      {
         if(this.barrelCollidesWithStatic(param2.barrelOrigin,param2.direction,this.weaponPlatform.getBarrelLength()))
         {
            shotDirection.copy(param2.direction);
         }
         else
         {
            this.targetingSystem.getShotDirection(param2.muzzlePosition,param2.direction,param2.elevationAxis,this.weaponPlatform.getBody(),shotDirection);
         }
         this.createShot(param1,param2,shotDirection);
      }
      
      private function doDummyShot(param1:int) : void
      {
         this.callback.onDummyShot(param1);
      }
      
      private function barrelCollidesWithStatic(param1:Vector3, param2:Vector3, param3:Number) : Boolean
      {
         return getBattleRunner().getCollisionDetector().raycastStatic(param1,param2,CollisionGroup.STATIC,param3,null,rayHit);
      }
      
      private function getEnergy(param1:int) : Number
      {
         return MathUtils.clamp(this.energyRechargeRate * (param1 - this.energyBaseTime),0,this.ricochetInitParams.energyCapacity);
      }
      
      private function setEnergyBaseTime(param1:int, param2:Number) : void
      {
         this.energyBaseTime = param1 - param2 / this.energyRechargeRate;
      }
      
      private function createShot(param1:int, param2:AllGlobalGunParams, param3:Vector3) : void
      {
         var _loc4_:RicochetShot = this.ammunition.getShot();
         _loc4_.addToGame(param2,param3,this.weaponPlatform.getBody(),false,++shotId);
         this.callback.onShot(param1,_loc4_.getShotId(),param3);
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.RICOCHET_RESISTANCE;
      }
      
      public function addEnergy(param1:int) : void
      {
         this.setEnergyBaseTime(this.nextShotTime,this.lastEnergy + param1);
      }
   }
}

