package scpacker.weapon
{
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisCC;
   import scpacker.tanks.WeaponsManager;
   import alternativa.tanks.models.weapon.healing.HealingGunModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsCC;
   import alternativa.tanks.models.weapon.railgun.RailgunModel;
   import alternativa.tanks.models.weapon.smoky.SmokyModel;
   import alternativa.tanks.models.weapons.discrete.DiscreteWeaponCommunicationModel;
   import alternativa.tanks.models.weapons.discrete.DiscreteWeapon;
   import alternativa.tanks.models.weapon.freeze.FreezeModel;
   //import alternativa.tanks.models.weapon.artillery.ArtilleryModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;
   import alternativa.types.Long;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryCC;
   import alternativa.tanks.models.weapon.machinegun.MachineGunModel;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot.ShotgunShotCC;
   import alternativa.tanks.models.weapon.laser.LaserPointerModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetCC;
   import alternativa.osgi.OSGi;
   import projects.tanks.client.battlefield.models.tankparts.weapon.freeze.FreezeCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashCC;
   import alternativa.tanks.models.weapon.thunder.ThunderModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower.FlameThrowerCC;
   import alternativa.tanks.models.weapon.streamweapon.StreamWeaponData;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.aiming.ShotGunAimingCC;
   import alternativa.tanks.models.weapons.shell.ShellWeaponCommunication;
   import projects.tanks.client.battlefield.models.tankparts.weapon.laser.LaserPointerCC;
   import alternativa.object.ClientObject;
   import alternativa.tanks.models.weapon.newname_95__END;
   import alternativa.tanks.models.weapons.charging.newname_97__END;
   import alternativa.tanks.models.weapon.shotgun.ShotgunShotModel;
   import alternativa.tanks.models.weapon.shaft.ShaftModel;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunCC;
   import alternativa.tanks.models.weapon.ricochet.RicochetModel;
   import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAimingModel ;
   import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAiming;
   import alternativa.tanks.models.weapon.plasma.TwinsModel;
   import alternativa.tanks.models.weapon.flamethrower.FlamethrowerModel;
   import alternativa.tanks.models.weapon.shotgun.ShotgunModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.smoky.SmokyModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.thunder.ThunderModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower.FlameThrowerModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.freeze.FreezeModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot.ShotgunShotModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.MachineGunModelBase;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.battlefield.models.tankparts.weapon.laser.LaserPointerModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.cc.MachineGunCC;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.impl.GameObject;
   import alternativa.tanks.models.weapon.streamweapon.StreamWeaponModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.StreamWeaponModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.StreamWeaponCC;
   import alternativa.tanks.models.weapon.splash.SplashModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.ShotgunHittingModelBase;
   
   public class WeaponModelUtil
   {
      private static var railgunModel:RailgunModel;
      private static var smokyModel:SmokyModel;
      private static var flamethrowerModel:FlamethrowerModel;
      private static var twinsModel:TwinsModel;
      private static var healingGunModel:HealingGunModel;
      private static var thunderModel:ThunderModel;
      private static var freezeModel:FreezeModel;
      private static var ricochetModel:RicochetModel;
      private static var shaftModel:ShaftModel;
      private static var shotgunModel:ShotgunModel;
      private static var machineGunModel:MachineGunModel;
      private static var streamWeaponModel:StreamWeaponModel;
      private static var splashModel:SplashModel;
      private static var shotGunAimingModel:ShotgunAimingModel;

      public static var weaponJsonObjects:Dictionary = new Dictionary();
      
      //private static var newname_121__END:ArtilleryModel;
      
      public static var resourceRegistry:ResourceRegistry = OSGi.getInstance().getService(ResourceRegistry) as ResourceRegistry;
      
      public static var modelRegistry:ModelRegistry = OSGi.getInstance().getService(ModelRegistry) as ModelRegistry;
      
      public function WeaponModelUtil()
      {
         super();
      }
      
      public static function getWeaponModel(weaponObject:GameObject) : Model
      {
         var _loc18_:LaserPointerCC = null;
         var _loc11_:LaserPointerModel = null;
         var _loc9_:ShaftCC = null;
         var _loc5_:RailgunCC = null;
         var _loc10_:RicochetCC = null;
         var _loc12_:TwinsCC = null;
         var flameThrowerCC:FlameThrowerCC = null;
         var _loc14_:StreamWeaponData = null;
         var freezeCC:FreezeCC = null;
         var _loc16_:IsisCC = null;
         var splashCC:SplashCC = null;
         var shotGunAimingCC:ShotGunAimingCC = null;
         var _loc2_:ShotgunShotCC = null;
         var _loc15_:ShotgunAimingModel = null;
         var _loc6_:MachineGunCC = null;
         if(smokyModel == null)
         {
            smokyModel = SmokyModel(modelRegistry.getModel(SmokyModelBase.modelId));
            thunderModel = ThunderModel(modelRegistry.getModel(ThunderModelBase.modelId));
            healingGunModel = HealingGunModel(modelRegistry.getModel(IsisModelBase.modelId));
            shaftModel = ShaftModel(modelRegistry.getModel(ShaftModelBase.modelId));
            ricochetModel = RicochetModel(modelRegistry.getModel(RicochetModelBase.modelId));
            twinsModel = TwinsModel(modelRegistry.getModel(TwinsModelBase.modelId));
            railgunModel = RailgunModel(modelRegistry.getModel(RailgunModelBase.modelId));
            flamethrowerModel = FlamethrowerModel(modelRegistry.getModel(FlameThrowerModelBase.modelId));
            freezeModel = FreezeModel(modelRegistry.getModel(FreezeModelBase.modelId));
            shotgunModel = ShotgunModel(modelRegistry.getModel(ShotgunShotModelBase.modelId));
            machineGunModel = MachineGunModel(modelRegistry.getModel(MachineGunModelBase.modelId));
            streamWeaponModel = StreamWeaponModel(modelRegistry.getModel(StreamWeaponModelBase.modelId));
            splashModel = SplashModel(modelRegistry.getModel(SplashModelBase.modelId));
            shotGunAimingModel = ShotgunAimingModel(modelRegistry.getModel(ShotgunHittingModelBase.modelId));
            //newname_121__END = ArtilleryModel(modelRegistry.getModel(Long.getLong(1546475564,-1431010080)));
         }
         var model:Model = null;
         var _loc8_:* = weaponJsonObjects[weaponObject.id];

         Model.object = weaponObject;

         switch(weaponObject.name.split("_")[0])
         {
            case "smoky":
               model = smokyModel;
               break;
            case "shaft":
               _loc18_ = new LaserPointerCC();
               _loc18_.fadeInTimeMs = _loc8_.fadeInTimeMs;
               _loc18_.laserPointerBlueColor = _loc8_.laserPointerBlueColor;
               _loc18_.laserPointerRedColor = _loc8_.laserPointerRedColor;
               _loc18_.locallyVisible = _loc8_.locallyVisible;
               _loc11_ = LaserPointerModel(modelRegistry.getModel(LaserPointerModelBase.modelId));

               _loc11_.putInitParams(_loc18_);

               _loc9_ = new ShaftCC();
               _loc9_.afterShotPause = _loc8_.afterShotPause;
               _loc9_.aimingImpact = _loc8_.aimingImpact;
               _loc9_.chargeRate = _loc8_.charge_rate;
               _loc9_.dischargeRate = _loc8_.discharge_rate;
               _loc9_.fastShotEnergy = _loc8_.fastShotEnergy;
               _loc9_.horizontalTargetingSpeed = _loc8_.horizontal_targeting_speed;
               _loc9_.initialFOV = _loc8_.initial_fov;
               _loc9_.maxEnergy = _loc8_.max_energy;
               _loc9_.minAimedShotEnergy = _loc8_.minAimedShotEnergy;
               _loc9_.minimumFOV = _loc8_.minimum_fov;
               _loc9_.reticleImage = ImageResource(resourceRegistry.getResource(Long.getLong(0,_loc8_.reticleImageId)));
               _loc9_.rotationCoeffKmin = _loc8_.rotationCoeffKmin;
               _loc9_.rotationCoeffT1 = _loc8_.rotationCoeffT1;
               _loc9_.rotationCoeffT2 = _loc8_.rotationCoeffT2;
               _loc9_.shrubsHidingRadiusMax = _loc8_.shrubs_hiding_radius_max;
               _loc9_.shrubsHidingRadiusMin = _loc8_.shrubs_hiding_radius_min;
               _loc9_.targetingAcceleration = _loc8_.targetingAcceleration;
               _loc9_.targetingTransitionTime = _loc8_.targetingTransitionTime;
               _loc9_.verticalTargetingSpeed = _loc8_.vertical_targeting_speed;

               shaftModel.putInitParams(_loc9_);
               shaftModel.objectLoaded();

               model = shaftModel;
               break;
            case "railgun":
               _loc5_ = new RailgunCC();
               _loc5_.chargingTimeMsec = _loc8_.chargingTimeMsec;
               _loc5_.weakeningCoeff = _loc8_.weakeningCoeff;
               
               railgunModel.putInitParams(_loc5_);
               railgunModel.objectLoaded();

               model = railgunModel;
               break;
            case "ricochet":
               _loc10_ = new RicochetCC();
               _loc10_.energyCapacity = _loc8_.energyCapacity;
               _loc10_.energyPerShot = _loc8_.energyPerShot;
               _loc10_.energyRechargeSpeed = _loc8_.energyRechargeSpeed;
               //_loc10_.maxRicochetCount = _loc8_.maxRicochetCount;
               _loc10_.shellRadius = _loc8_.shellRadius;
               _loc10_.shellSpeed = _loc8_.shellSpeed;
               _loc10_.shotDistance = _loc8_.shotDistance;
               
               ricochetModel.putInitParams(_loc10_);
               ricochetModel.objectLoaded();

               model = ricochetModel;
               break;
            case "twins":
               _loc12_ = new TwinsCC();
               _loc12_.distance = _loc8_.distance;
               _loc12_.shellRadius = _loc8_.shellRadius;
               _loc12_.speed = _loc8_.speed;

               twinsModel.putInitParams(_loc12_);
               twinsModel.objectLoaded();

               model = twinsModel;
               break;
            case "flamethrower":
               flameThrowerCC = new FlameThrowerCC();
               flameThrowerCC.coneAngle = _loc8_.coneAngle;
               flameThrowerCC.range = _loc8_.range;

               flamethrowerModel.putInitParams(flameThrowerCC);
               flamethrowerModel.objectLoaded();

               initializeStreamWeapon(weaponObject, _loc8_);

               model = flamethrowerModel;
               break;
            case "freeze":
               freezeCC = new FreezeCC();
               freezeCC.damageAreaConeAngle = _loc8_.damageAreaConeAngle;
               freezeCC.damageAreaRange = _loc8_.damageAreaRange;

               initializeStreamWeapon(weaponObject, _loc8_);

               freezeModel.putInitParams(freezeCC);
               freezeModel.objectLoaded();

               model = freezeModel;
               break;
            case "isida":
               _loc16_ = new IsisCC();
               _loc16_.capacity = _loc8_.capacity;
               _loc16_.chargeRate = _loc8_.chargeRate;
               _loc16_.checkPeriodMsec = _loc8_.checkPeriodMsec;
               _loc16_.coneAngle = _loc8_.coneAngle;
               _loc16_.dischargeRate = _loc8_.dischargeDamageRate;

               // TODO: add these params
               //_loc16_.dischargeHealingRate = _loc8_.dischargeHealingRate;
               //_loc16_.dischargeIdleRate = _loc8_.dischargeIdleRate;

               _loc16_.radius = _loc8_.radius;

               healingGunModel.putInitParams(_loc16_);
               healingGunModel.objectLoaded();

               model = healingGunModel;
               break;
            case "thunder":
               splashCC = new SplashCC();
               splashCC.impactForce = _loc8_.impactForce;
               splashCC.minSplashDamagePercent = _loc8_.minSplashDamagePercent;
               splashCC.radiusOfMaxSplashDamage = _loc8_.radiusOfMaxSplashDamage;
               splashCC.splashDamageRadius = _loc8_.splashDamageRadius;
               
               splashModel.putInitParams(splashCC);
               splashModel.objectLoaded();

               model = thunderModel;
               break;
            case "shotgun":
               shotGunAimingCC = new ShotGunAimingCC();
               shotGunAimingCC.coneHorizontalAngle = _loc8_.coneHorizontalAngle;
               shotGunAimingCC.coneVerticalAngle = _loc8_.coneVerticalAngle;
               shotGunAimingCC.pelletCount = _loc8_.pelletCount;
               shotGunAimingModel.putInitParams(shotGunAimingCC);

               _loc2_ = new ShotgunShotCC();
               _loc2_.magazineReloadTime = _loc8_.magazineReloadTime;
               _loc2_.magazineSize = _loc8_.magazineSize;
               shotgunModel.putInitParams(_loc2_);

               model = shotgunModel;
               break;
            case "machinegun":
               _loc6_ = new MachineGunCC();
               _loc6_.spinDownTime = _loc8_.spinDownTime;
               _loc6_.spinUpTime = _loc8_.spinUpTime;
               _loc6_.temperatureHittingTime = _loc8_.temperatureHittingTime;
               _loc6_.weaponTurnDecelerationCoeff = _loc8_.weaponTurnDecelerationCoeff;
               machineGunModel.putInitParams(_loc6_);

               model = machineGunModel;
               break;
            //case "artillery":
            //   _loc7_ = newname_121__END;
            //   ArtilleryModel(_loc7_).putInitParams(new ArtilleryCC(_loc8_.chargingTime,_loc8_.initialTurretAngle,_loc8_.maxShellSpeed,_loc8_.minShellSpeed,_loc8_.shellGravityCoef,_loc8_.shellRadius,_loc8_.speedsCount));
            //   newname_121__END.objectLoaded(param1);
            //   param1.putParams(newname_97__END,modelRegistry.getModel(Long.getLong(1249124405,67678961)));
            //   param1.putParams(ShellWeaponCommunication,modelRegistry.getModel(Long.getLong(288784246,84754739)));
            //   _loc17_ = new SplashCC();
            //   _loc17_.ImpactForce = _loc8_.impactForce;
            //   _loc17_.newname_169__END = _loc8_.minSplashDamagePercent;
            //   _loc17_.newname_170__END = _loc8_.radiusOfMaxSplashDamage;
            //   _loc17_.newname_171__END = _loc8_.splashDamageRadius;
            //   param1.putParams(SplashCC,_loc17_);
         }
         
         Model.popObject();
         return model;
      }
      
      private static function initializeStreamWeapon(weaponObject:GameObject, _loc8_:Object):void {
         var streamWeaponCC:StreamWeaponCC = new StreamWeaponCC();
         streamWeaponCC.energyCapacity = _loc8_.energyCapacity;
         streamWeaponCC.energyDischargeSpeed = _loc8_.energyDischargeSpeed;
         streamWeaponCC.energyRechargeSpeed = _loc8_.energyRechargeSpeed;
         streamWeaponCC.weaponTickIntervalMsec = _loc8_.tickIntervalMsec;

         streamWeaponModel.putInitParams(streamWeaponCC);
         streamWeaponModel.objectLoaded();
      }
   }
}

