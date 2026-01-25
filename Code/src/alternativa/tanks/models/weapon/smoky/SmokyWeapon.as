package alternativa.tanks.models.weapon.smoky
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.LogicUnit;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponForces;
   import alternativa.tanks.models.weapon.common.HitInfo;
   import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapons.targeting.TargetingResult;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import flash.utils.getTimer;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   import alternativa.tanks.models.weapons.targeting.CheatCommonTargetingSystem;
   
   public class SmokyWeapon extends BattleRunnerProvider implements Weapon, LogicUnit
   {
      public static var cheatTargetingEnabled:Boolean = false;
      
      private static const gunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private var enabled:Boolean;
      
      private var reloadTime:EncryptedInt = new EncryptedIntImpl();
      
      private var nextTime:EncryptedInt = new EncryptedIntImpl();
      
      private var weaponForces:WeaponForces;
      
      private var controller:SimpleWeaponController;
      
      private var targetingSystem:TargetingSystem;
      private var cheatTargetingSystem:CheatCommonTargetingSystem;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var weakening:DistanceWeakening;
      
      private var callback:SmokyCallback;
      
      private var effects:ISmokyEffects;
      
      public function SmokyWeapon(param1:int, param2:WeaponForces, param3:TargetingSystem, _cheatTargetingSystem:CheatCommonTargetingSystem, param4:DistanceWeakening, param5:ISmokyEffects, param6:SmokyCallback, param7:SimpleWeaponController)
      {
         super();
         this.reloadTime.setInt(param1);
         this.weaponForces = param2;
         this.targetingSystem = param3;
         this.cheatTargetingSystem = _cheatTargetingSystem;
         this.weakening = param4;
         this.effects = param5;
         this.callback = param6;
         this.controller = param7;
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
         this.controller.init();
         this.reset();
      }
      
      public function destroy() : void
      {
         this.weaponForces = null;
         this.targetingSystem = null;
         this.cheatTargetingSystem = null;
         this.weakening = null;
         this.effects = null;
         this.callback = null;
         this.controller.destroy();
         this.controller = null;
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
         this.enabled = true;
         this.controller.discardStoredAction();
      }
      
      public function disable(param1:Boolean) : void
      {
         this.enabled = false;
      }
      
      public function reset() : void
      {
         this.nextTime.setInt(getTimer());
      }
      
      public function getStatus() : Number
      {
         var _loc1_:Number = 1 - (this.nextTime.getInt() - getTimer()) / this.reloadTime.getInt();
         return _loc1_ > 1 ? 1 : _loc1_;
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         if(this.controller.wasActive())
         {
            if(this.enabled && param1 >= this.nextTime.getInt())
            {
               this.shoot(param1);
            }
            this.controller.discardStoredAction();
         }
      }
      
      private function shoot(param1:int) : void
      {
         var _loc3_:Tank = null;
         var _loc4_:Number = NaN;
         this.nextTime.setInt(param1 + this.reloadTime.getInt());
         this.weaponPlatform.getAllGunParams(gunParams);
         this.weaponPlatform.getBody().addWorldForceScaled(gunParams.barrelOrigin,gunParams.direction,-this.weaponForces.getRecoilForce());
         this.weaponPlatform.addDust();
         this.effects.createShotEffects(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
         var _loc2_:HitInfo = new HitInfo();
         if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),gunParams) && this.getTarget(gunParams,_loc2_))
         {
            this.effects.createExplosionEffects(_loc2_.position);
            if(BattleUtils.isTankBody(_loc2_.body))
            {
               _loc3_ = _loc2_.body.tank;
               _loc4_ = this.weakening.getImpactCoeff(_loc2_.distance);
               _loc3_.applyWeaponHit(_loc2_.position,_loc2_.direction,this.weaponForces.getImpactForce() * _loc4_);
               this.callback.onShotTarget(param1,_loc2_.position,_loc2_.body);
            }
            else
            {
               this.effects.createExplosionMark(gunParams.barrelOrigin,_loc2_.position);
               this.callback.onShotStatic(param1,_loc2_.position);
            }
         }
         else
         {
            this.callback.onShot(param1);
         }
      }
      
      private function getTarget(param1:AllGlobalGunParams, param2:HitInfo) : Boolean
      {
         var targetingResult:TargetingResult;
         if(cheatTargetingEnabled)
         {
            targetingResult = cheatTargetingSystem.target(param1);
         }
         else
         {
            targetingResult = targetingSystem.target(param1);
         }
         param2.setResult(param1,targetingResult);
         return targetingResult.hasAnyHit();
      }
      
      public function createCriticalHitEffect(param1:Vector3) : void
      {
         this.effects.createCriticalHitEffects(param1);
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.SMOKY_RESISTANCE;
      }
   }
}

