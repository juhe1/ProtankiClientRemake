package alternativa.tanks.models.weapon.shaft
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponConst;
   import alternativa.tanks.utils.EncryptedNumber;
   import alternativa.tanks.utils.EncryptedNumberImpl;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class RemoteShaftWeapon implements Weapon
   {
      
      private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private static const shotDirection:Vector3 = new Vector3();
      
      private var effects:ShaftEffects;
      
      private var shaftCC:ShaftCC;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var turnSpeedModificationTask:TurnSpeedModificationTask;
      
      private var speedCharacteristics:SpeedCharacteristics;
      
      private var turretController:TurretController;
      
      private var recoilForce:EncryptedNumber;
      
      public function RemoteShaftWeapon(param1:Number, param2:ShaftCC, param3:ShaftEffects, param4:TurretController, param5:SpeedCharacteristics)
      {
         super();
         this.recoilForce = new EncryptedNumberImpl(param1);
         this.shaftCC = param2;
         this.effects = param3;
         this.turretController = param4;
         this.speedCharacteristics = param5;
      }
      
      private static function getShotDirection(param1:Vector3, param2:Vector3, param3:Vector3) : Vector3
      {
         if(param2 != null)
         {
            return shotDirection.diff(param2,param1).normalize();
         }
         if(param3 == null)
         {
            param3 = allGunParams.direction;
         }
         return shotDirection.diff(param3,param1).normalize();
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
      }
      
      public function destroy() : void
      {
         this.effects.destroy();
      }
      
      public function activate() : void
      {
      }
      
      public function deactivate() : void
      {
         this.stopManualTargeting();
      }
      
      public function enable() : void
      {
      }
      
      public function disable(param1:Boolean) : void
      {
         this.stopManualTargeting();
      }
      
      public function reset() : void
      {
         this.stopManualTargeting();
      }
      
      public function getStatus() : Number
      {
         return 0;
      }
      
      public function startManualTargeting() : void
      {
         if(this.turnSpeedModificationTask == null)
         {
            this.effects.createManualModeEffects(this.weaponPlatform.getTurret3D());
            this.weaponPlatform.stopMovement();
            this.weaponPlatform.lockMovement(true);
            this.turnSpeedModificationTask = new TurnSpeedModificationTask(this.shaftCC,this.turretController,this.speedCharacteristics);
            this.turnSpeedModificationTask.start();
         }
      }
      
      public function stopManualTargeting() : void
      {
         if(this.turnSpeedModificationTask != null)
         {
            this.turnSpeedModificationTask.stop();
            this.turnSpeedModificationTask = null;
         }
         this.effects.stopManualTargetingEffects();
         this.weaponPlatform.lockMovement(false);
      }
      
      public function showShotEffects(param1:Vector3, param2:Body, param3:Vector3, param4:Number) : void
      {
         var _loc5_:Vector3 = null;
         this.weaponPlatform.getAllGunParams(allGunParams);
         this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.recoilForce.getNumber());
         this.weaponPlatform.addDust();
         this.effects.createMuzzleFlashEffect(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
         this.effects.createShotSoundEffect(allGunParams.muzzlePosition);
         this.effects.createHitMark(allGunParams.barrelOrigin,param1);
         if(param1 != null || param3 != null)
         {
            _loc5_ = getShotDirection(allGunParams.barrelOrigin,param1,param3);
            this.effects.createHitPointsGraphicEffects(param1,param3,allGunParams.muzzlePosition,allGunParams.direction,_loc5_);
            this.applyImpactForce(param2,param3,_loc5_,param4);
         }
      }
      
      private function applyImpactForce(param1:Body, param2:Vector3, param3:Vector3, param4:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Tank = null;
         if(param1 == null)
         {
            return;
         }
         if(Vector3.isFiniteVector(param3))
         {
            _loc5_ = param4 * WeaponConst.BASE_IMPACT_FORCE.getNumber();
            if(param1 != null && param1.tank != null)
            {
               if(Vector3.isFiniteVector(param2))
               {
                  _loc6_ = param1.tank;
                  _loc6_.applyWeaponHit(param2,param3,_loc5_);
               }
            }
         }
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.SHAFT_RESISTANCE;
      }
   }
}

