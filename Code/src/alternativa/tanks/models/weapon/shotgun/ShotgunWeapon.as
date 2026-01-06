package alternativa.tanks.models.weapon.shotgun
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunEffects;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapons.common.CommonLocalWeapon;
   import flash.utils.getTimer;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot.ShotgunShotCC;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class ShotgunWeapon extends CommonLocalWeapon
   {
      
      private var params:ShotgunShotCC;
      
      private var reminderShots:int;
      
      private var nextShotTime:int;
      
      private var targeting:ShotgunRicochetTargetingSystem;
      
      private var fullDamageDistance:Number;
      
      private var bestDirection:Vector3 = new Vector3();
      
      private var weaponObject:ShotgunObject;
      
      private var reloadTimeMS:int;
      
      private var effects:ShotgunEffects;
      
      private var isMagazineReloading:Boolean;
      
      private var lastShotTime:int;
      
      public function ShotgunWeapon(param1:ShotgunShotCC, param2:ShotgunObject, param3:ShotgunRicochetTargetingSystem, param4:ShotgunEffects)
      {
         this.params = param1;
         this.weaponObject = param2;
         this.targeting = param3;
         this.reloadTimeMS = param2.getReloadTimeMS();
         var _loc5_:DistanceWeakening = param2.distanceWeakening();
         this.fullDamageDistance = _loc5_.getFullDamageDistance();
         this.effects = param4;
         super(param2);
      }
      
      override public function getStatus() : Number
      {
         if(this.isMagazineReloading)
         {
            return 1 - (this.nextShotTime - getTimer()) / this.params.magazineReloadTime;
         }
         return this.reminderShots / Number(this.params.magazineSize);
      }
      
      override public function runLogic(param1:int, param2:int) : void
      {
         if(isShooting() && param1 >= this.nextShotTime)
         {
            this.shoot(param1);
         }
      }
      
      private function shoot(param1:int) : void
      {
         var _loc4_:Vector.<Tank> = null;
         this.lastShotTime = param1;
         var _loc2_:WeaponPlatform = this.getWeaponPlatform();
         --this.reminderShots;
         if(this.reminderShots == 0)
         {
            this.isMagazineReloading = true;
            this.reminderShots = this.params.magazineSize;
            this.nextShotTime = param1 + this.params.magazineReloadTime;
            this.effects.createMagazineReloadSoundEffect(_loc2_.getTurret3D(),this.params.magazineReloadTime);
         }
         else
         {
            this.isMagazineReloading = false;
            this.nextShotTime = param1 + this.reloadTimeMS;
            this.effects.createReloadSoundEffect(_loc2_.getTurret3D(),this.reloadTimeMS);
         }
         _loc2_.getAllGunParams(gunParams);
         var _loc3_:WeaponCommonData = this.weaponObject.commonData();
         _loc2_.getBody().addWorldForceScaled(gunParams.barrelOrigin,gunParams.direction,-_loc3_.getRecoilForce());
         _loc2_.addDust();
         if(BattleUtils.isTurretAboveGround(_loc2_.getBody(),gunParams))
         {
            _loc4_ = this.targeting.getShotDirection(gunParams,_loc2_.getBody(),this.bestDirection);
            this.weaponObject.discrete().tryToShoot(param1,this.bestDirection,_loc4_);
         }
         else
         {
            this.bestDirection.copy(gunParams.direction);
            this.weaponObject.discrete().tryToDummyShoot(param1,this.bestDirection);
         }
         this.effects.createShotEffects(this.weaponObject,gunParams,_loc2_,this.bestDirection);
      }
      
      override public function reset() : void
      {
         super.reset();
         this.effects.stopEffects();
         this.reminderShots = this.params.magazineSize;
         this.nextShotTime = getTimer();
         this.isMagazineReloading = false;
      }
      
      override public function getWeaponPlatform() : WeaponPlatform
      {
         return super.getWeaponPlatform();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.weaponObject = null;
         this.targeting = null;
         this.params = null;
         this.effects.stopEffects();
         this.effects = null;
      }
      
      override public function disable(param1:Boolean) : void
      {
         super.disable(param1);
         this.effects.stopEffects();
      }
      
      override public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.SHOTGUN_RESISTANCE;
      }
      
      public function setRemainingShots(param1:int) : void
      {
         this.reminderShots = Math.min(param1,this.params.magazineSize);
         if(this.isMagazineReloading)
         {
            if(battleService.getBattleRunner().getPhysicsTime() < this.nextShotTime)
            {
               this.nextShotTime = this.lastShotTime + this.reloadTimeMS;
            }
            this.isMagazineReloading = false;
         }
      }
   }
}

