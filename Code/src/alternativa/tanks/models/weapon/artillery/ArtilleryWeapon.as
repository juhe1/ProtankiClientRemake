package alternativa.tanks.models.weapon.artillery
{
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryEffects;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapons.common.CommonLocalWeapon;
   import flash.utils.getTimer;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryCC;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class ArtilleryWeapon extends CommonLocalWeapon
   {
      
      private var reloadTimeMs:int;
      
      private var reloadingEndTime:int;
      
      private var weaponObject:ArtilleryObject;
      
      private var user:IGameObject;
      
      private var shotId:int;
      
      private var params:ArtilleryCC;
      
      private var startChargingTime:Number;
      
      private var needReleaseTrigger:Boolean;
      
      private var turretController:TurretController;
      
      private var effects:ArtilleryEffects;
      
      private var extraReloadingTimeMs:int;
      
      public function ArtilleryWeapon(param1:IGameObject, param2:ArtilleryObject, param3:ArtilleryCC)
      {
         super(param2);
         this.user = param1;
         this.weaponObject = param2;
         this.params = param3;
         this.reloadTimeMs = param2.getReloadTimeMS();
         this.extraReloadingTimeMs = this.reloadTimeMs;
      }
      
      override public function init(param1:WeaponPlatform) : void
      {
         this.effects = this.weaponObject.getEffects();
         var _loc2_:ITankModel = ITankModel(this.user.adapt(ITankModel));
         this.turretController = _loc2_.getTurretController();
         super.init(param1);
      }
      
      override public function getStatus() : Number
      {
         if(this.isCharging())
         {
            return 1 - Math.min(1,(getTimer() - this.startChargingTime) * 0.001 / this.params.chargingTime);
         }
         return 1 - Math.max(0,(this.reloadingEndTime - getTimer()) / (this.reloadTimeMs + this.extraReloadingTimeMs));
      }
      
      override public function runLogic(param1:int, param2:int) : void
      {
         if(this.needReleaseTrigger)
         {
            this.needReleaseTrigger = false;
            if(this.canShoot(this.startChargingTime))
            {
               this.shoot(getPhysicsTime());
            }
            super.releaseTrigger();
         }
         super.runLogic(param1,param2);
         if(!this.canShoot(this.startChargingTime) && this.canShoot(param1))
         {
            this.startCharging(param1);
         }
      }
      
      public function startCharging(param1:Number) : void
      {
         this.startChargingTime = param1;
         this.weaponObject.charging().startCharging(param1);
         if(this.isLocalWeapon())
         {
            this.effects.createChargingSoundEffect(getWeaponPlatform().getTurret3D());
         }
      }
      
      override public function releaseTrigger() : void
      {
         this.needReleaseTrigger = true;
      }
      
      public function shoot(param1:int) : void
      {
         this.weaponObject.charging().finishCharging(param1);
         this.extraReloadingTimeMs = this.getNotSpentChargingDuration(param1);
         this.reloadingEndTime = param1 + this.reloadTimeMs + this.extraReloadingTimeMs;
         var _loc2_:WeaponPlatform = getWeaponPlatform();
         _loc2_.getAllGunParams(gunParams);
         var _loc3_:WeaponCommonData = this.weaponObject.commonData();
         _loc2_.getBody().addWorldForceScaled(gunParams.muzzlePosition,gunParams.direction,-_loc3_.getRecoilForce());
         _loc2_.addDust();
         if(!BattleUtils.isTurretAboveGround(_loc2_.getBody(),gunParams))
         {
            this.weaponObject.shellCommunication().tryToDummyShoot(param1,0);
            return;
         }
         this.weaponObject.shellCommunication().tryToShoot(param1,0,++this.shotId,gunParams.direction);
         var _loc4_:ArtilleryShell = ArtilleryShell(battleService.getObjectPool().getObject(ArtilleryShell));
         var _loc5_:Number = this.getSpeed(param1);
         _loc4_.init(this.weaponObject,this.params,_loc5_);
         _loc4_.addToGame(gunParams,gunParams.direction,_loc2_.getBody(),this is RemoteArtilleryWeapon,this.shotId);
         this.effects.createShotEffect(_loc2_,gunParams,Math.min(1,this.getPower(param1)),-this.turretController.getDirection() * 180 / Math.PI,this.reloadTimeMs + this.extraReloadingTimeMs);
      }
      
      private function getNotSpentChargingDuration(param1:int) : int
      {
         var _loc2_:int = param1 - this.startChargingTime;
         return _loc2_ > this.params.chargingTime * 1000 ? 0 : int(this.params.chargingTime * 1000 - _loc2_);
      }
      
      public function getSpeed(param1:int) : Number
      {
         var _loc2_:int = Math.min(int((param1 - this.startChargingTime) * 0.001 / this.params.chargingTime * this.params.speedsCount),this.params.speedsCount - 1);
         return this.params.minShellSpeed + (this.params.maxShellSpeed - this.params.minShellSpeed) * _loc2_ / (this.params.speedsCount - 1);
      }
      
      public function getPower(param1:int) : Number
      {
         return (param1 - this.startChargingTime) * 0.001 / this.params.chargingTime;
      }
      
      public function getDiscretePower(param1:int) : Number
      {
         var _loc2_:int = Math.min(int((param1 - this.startChargingTime) * 0.001 / this.params.chargingTime * this.params.speedsCount),this.params.speedsCount);
         return _loc2_ / this.params.speedsCount;
      }
      
      public function isCharging() : Boolean
      {
         return this.startChargingTime >= this.reloadingEndTime;
      }
      
      private function canShoot(param1:int) : Boolean
      {
         return isShooting() && param1 >= this.reloadingEndTime;
      }
      
      override public function reset() : void
      {
         super.reset();
         if(this.effects != null)
         {
            this.effects.reset();
         }
         this.reloadingEndTime = 0;
         this.startChargingTime = -1;
      }
      
      override public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.ARTILLERY_RESISTANCE;
      }
      
      private function isLocalWeapon() : Boolean
      {
         return this.weaponObject.isLocal();
      }
      
      public function getInitialAngle() : Number
      {
         return this.params.initialTurretAngle;
      }
   }
}

