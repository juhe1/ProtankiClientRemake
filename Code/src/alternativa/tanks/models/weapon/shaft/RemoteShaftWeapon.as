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
      
      private static function getShotDirection(param1:Vector3, param2:Vector3, param3:Vector.<Vector3>) : Vector3
      {
         var _loc4_:Vector3 = null;
         var _loc5_:int = 0;
         var _loc6_:Vector3 = null;
         if(param2 != null)
         {
            return shotDirection.diff(param2,param1).normalize();
         }
         _loc5_ = param3.length - 1;
         while(_loc5_ >= 0)
         {
            _loc6_ = param3[_loc5_];
            if(_loc6_ != null)
            {
               _loc4_ = _loc6_;
               break;
            }
            _loc5_--;
         }
         if(_loc4_ == null)
         {
            _loc4_ = allGunParams.direction;
         }
         return shotDirection.diff(_loc4_,param1).normalize();
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
      
      public function showShotEffects(param1:Vector3, param2:Vector.<Body>, param3:Vector.<Vector3>, param4:Number) : void
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
      
      private function applyImpactForce(param1:Vector.<Body>, param2:Vector.<Vector3>, param3:Vector3, param4:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Body = null;
         var _loc8_:Vector3 = null;
         var _loc9_:Tank = null;
         if(param1 != null)
         {
            if(Vector3.isFiniteVector(param3))
            {
               _loc5_ = param4 * WeaponConst.BASE_IMPACT_FORCE.getNumber();
               _loc6_ = 0;
               while(_loc6_ < param1.length)
               {
                  _loc7_ = param1[_loc6_];
                  if(_loc7_ != null && _loc7_.tank != null)
                  {
                     _loc8_ = param2[_loc6_];
                     if(Vector3.isFiniteVector(_loc8_))
                     {
                        _loc9_ = _loc7_.tank;
                        _loc9_.applyWeaponHit(_loc8_,param3,_loc5_);
                     }
                  }
                  _loc5_ *= this.shaftCC.weakeningCoeff;
                  _loc6_++;
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

