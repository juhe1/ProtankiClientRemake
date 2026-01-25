package alternativa.tanks.models.weapon.railgun
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.LogicUnit;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.BasicGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponForces;
   import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import alternativa.tanks.utils.MathUtils;
   import flash.utils.getTimer;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   import alternativa.tanks.models.weapons.targeting.CheatCommonTargetingSystem;
   
   public class RailgunWeapon extends BattleRunnerProvider implements Weapon, LogicUnit
   {
      public static var cheatTargetingEnabled:Boolean = false;
      
      private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private static const basicGunParams:BasicGlobalGunParams = new BasicGlobalGunParams();
      
      private var controller:SimpleWeaponController;
      
      private var targetingSystem:TargetingSystem;
      private var cheatTargetingSystem:TargetingSystem;
      
      private var reloadTime:EncryptedInt = new EncryptedIntImpl();
      
      private var weaponForces:WeaponForces;
      
      private var weakeningCoeff:Number;
      
      private var chargingDuration:EncryptedInt = new EncryptedIntImpl();
      
      private var effects:IRailgunEffects;
      
      private var callback:RailgunCallback;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var enabled:Boolean;
      
      private var nextTime:EncryptedInt = new EncryptedIntImpl();
      
      private var charging:Boolean;
      
      public function RailgunWeapon(param1:TargetingSystem, _cheatTargetingSystem:TargetingSystem, param2:SimpleWeaponController, param3:int, param4:WeaponForces, param5:Number, param6:int, param7:IRailgunEffects, param8:RailgunCallback)
      {
         super();
         this.targetingSystem = param1;
         this.cheatTargetingSystem = _cheatTargetingSystem;
         this.controller = param2;
         this.reloadTime.setInt(param3);
         this.weaponForces = param4;
         this.weakeningCoeff = param5;
         this.chargingDuration.setInt(param6);
         this.effects = param7;
         this.callback = param8;
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
         this.controller.init();
      }
      
      public function destroy() : void
      {
         this.deactivate();
         this.effects.stopEffects();
         this.controller.destroy();
         this.controller = null;
         this.effects = null;
         this.weaponForces = null;
         this.targetingSystem = null;
         this.cheatTargetingSystem = null;
         this.callback = null;
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
         if(this.enabled)
         {
            this.enabled = false;
            this.effects.stopEffects();
         }
      }
      
      public function reset() : void
      {
         this.enabled = false;
         this.effects.stopEffects();
         this.nextTime.setInt(0);
         this.charging = false;
      }
      
      public function getStatus() : Number
      {
         var _loc1_:Number = NaN;
         if(this.charging)
         {
            return MathUtils.clamp((this.nextTime.getInt() - getTimer()) / this.chargingDuration.getInt(),0,1);
         }
         return MathUtils.clamp(1 - (this.nextTime.getInt() - getTimer()) / this.reloadTime.getInt(),0,1);
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         if(this.charging)
         {
            if(param1 >= this.nextTime.getInt())
            {
               this.shoot(param1);
            }
         }
         else if(this.enabled)
         {
            if(param1 >= this.nextTime.getInt() && this.controller.wasActive())
            {
               this.startCharging(param1);
            }
         }
         this.controller.discardStoredAction();
      }
      
      private function startCharging(param1:int) : void
      {
         this.charging = true;
         this.nextTime.setInt(param1 + this.chargingDuration.getInt());
         this.effects.createChargeEffect(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D(),this.chargingDuration.getInt());
         this.weaponPlatform.getBasicGunParams(basicGunParams);
         this.effects.createSoundEffect(basicGunParams.muzzlePosition);
         this.callback.onStartCharging(param1);
      }
      
      private function shoot(param1:int) : void
      {
         var _loc2_:RailgunShotResult = null;
         this.charging = false;
         this.nextTime.setInt(param1 + this.reloadTime.getInt());
         this.weaponPlatform.getAllGunParams(allGunParams);
         this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.weaponForces.getRecoilForce());
         this.weaponPlatform.addDust();
         if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),allGunParams))
         {
            _loc2_ = new RailgunShotResult();
            if(cheatTargetingEnabled)
            {
               _loc2_.setFromTargetingResult(this.cheatTargetingSystem.target(allGunParams));
            } else
            {
               _loc2_.setFromTargetingResult(this.targetingSystem.target(allGunParams));
            }
            if(_loc2_.hitPoints.length > 0)
            {
               this.applyImpactToTargets(_loc2_);
            }
            this.createShotEffect(_loc2_,allGunParams);
            this.callback.onShot(param1,_loc2_.getStaticHitPoint(),_loc2_.targets,_loc2_.hitPoints);
         }
         else
         {
            this.callback.onShotDummy(param1);
         }
      }
      
      private function applyImpactToTargets(param1:RailgunShotResult) : void
      {
         var _loc4_:Body = null;
         var _loc5_:Tank = null;
         var _loc2_:Number = 1;
         var _loc3_:int = 0;
         while(_loc3_ < param1.targets.length)
         {
            _loc4_ = param1.targets[_loc3_];
            _loc5_ = _loc4_.tank;
            _loc5_.applyWeaponHit(param1.hitPoints[_loc3_],param1.shotDirection,this.weaponForces.getImpactForce() * _loc2_);
            _loc2_ *= this.weakeningCoeff;
            _loc3_++;
         }
      }
      
      private function createShotEffect(param1:RailgunShotResult, param2:AllGlobalGunParams) : void
      {
         var _loc3_:Vector3 = param1.getStaticHitPoint();
         if(_loc3_ == null && param1.targets.length > 0)
         {
            _loc3_ = RailgunUtils.getDistantPoint(param2.barrelOrigin,param1.shotDirection);
         }
         this.effects.createShotTrail(param2.muzzlePosition,_loc3_,param2.direction);
         this.effects.createStaticHitMark(param2.barrelOrigin,param1.getStaticHitPoint());
         if(_loc3_ != null)
         {
            if(param1.hasStaticHit)
            {
               this.effects.createStaticHitEffect(param2.muzzlePosition,param1.staticHitPoint,param1.staticHitNormal);
            }
            if(param1.targets.length > 0)
            {
               this.effects.createTargetHitEffects(param2.muzzlePosition,_loc3_,param1.hitPoints,param1.targets);
            }
         }
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.RAILGUN_RESISTANCE;
      }
      
      public function immediateReload() : void
      {
         var _loc1_:int = int(battleService.getPhysicsTime());
         if(this.nextTime.getInt() > _loc1_)
         {
            this.nextTime.setInt(_loc1_);
         }
      }
   }
}

