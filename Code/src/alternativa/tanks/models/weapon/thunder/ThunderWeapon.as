package alternativa.tanks.models.weapon.thunder
{
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
   import alternativa.tanks.models.weapon.splash.Splash;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapons.targeting.TargetingResult;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import flash.utils.getTimer;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class ThunderWeapon extends BattleRunnerProvider implements Weapon, LogicUnit
   {
      public static var cheatTargetingEnabled:Boolean = false;
      
      private static const gunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private static const hitInfo:HitInfo = new HitInfo();
      
      private var enabled:Boolean;
      
      private var reloadTime:EncryptedInt = new EncryptedIntImpl();
      
      private var nextTime:EncryptedInt = new EncryptedIntImpl();
      
      private var weaponForces:WeaponForces;
      
      private var controller:SimpleWeaponController;
      
      private var targetingSystem:TargetingSystem;
      
      private var cheatTargetingSystem:TargetingSystem;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var weakening:DistanceWeakening;
      
      private var splash:Splash;
      
      private var callback:ThunderCallback;
      
      private var effects:IThunderEffects;
      
      public function ThunderWeapon(param1:int, param2:WeaponForces, param3:DistanceWeakening, param4:TargetingSystem, _cheatTargetingSystem:TargetingSystem, param5:Splash, param6:IThunderEffects, param7:ThunderCallback)
      {
         super();
         this.reloadTime.setInt(param1);
         this.weaponForces = param2;
         this.controller = new SimpleWeaponController();
         this.targetingSystem = param4;
         this.cheatTargetingSystem = _cheatTargetingSystem;
         this.weakening = param3;
         this.splash = param5;
         this.callback = param7;
         this.effects = param6;
      }
      
      private static function adjustHitPosition(param1:HitInfo) : void
      {
         param1.position.add(param1.normal);
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
         this.splash = null;
         this.callback = null;
         this.effects = null;
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
         var _loc2_:Number = NaN;
         var _loc3_:Tank = null;
         this.nextTime.setInt(param1 + this.reloadTime.getInt());
         this.weaponPlatform.getAllGunParams(gunParams);
         this.weaponPlatform.getBody().addWorldForceScaled(gunParams.barrelOrigin,gunParams.direction,-this.weaponForces.getRecoilForce());
         this.weaponPlatform.addDust();
         this.effects.createShotEffects(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
         if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),gunParams) && this.getTarget(gunParams,hitInfo))
         {
            adjustHitPosition(hitInfo);
            this.effects.createExplosionEffects(hitInfo.position);
            _loc2_ = this.weakening.getImpactCoeff(hitInfo.distance);
            this.splash.applySplashForce(hitInfo.position,_loc2_,hitInfo.body);
            if(BattleUtils.isTankBody(hitInfo.body))
            {
               _loc3_ = hitInfo.body.tank;
               _loc3_.applyWeaponHit(hitInfo.position,hitInfo.direction,this.weaponForces.getImpactForce() * _loc2_);
               this.callback.onShotTarget(param1,hitInfo.position,hitInfo.body);
            }
            else
            {
               this.effects.createExplosionMark(gunParams.barrelOrigin,hitInfo.position);
               this.callback.onShotStatic(param1,hitInfo.position);
            }
         }
         else
         {
            this.callback.onShot(param1);
         }
      }
      
      private function getTarget(param1:AllGlobalGunParams, param2:HitInfo) : Boolean
      {
         var _loc3_:TargetingResult = (cheatTargetingEnabled ? this.cheatTargetingSystem : this.targetingSystem).target(param1);
         param2.setResult(param1,_loc3_);
         return _loc3_.hasAnyHit();
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.THUNDER_RESISTANCE;
      }
   }
}

