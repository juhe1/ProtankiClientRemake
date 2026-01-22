package scpacker.weapon
{
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisCC;
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
   import alternativa.tanks.models.weapon.shaft.ShaftModel;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunCC;
   import alternativa.tanks.models.weapon.ricochet.RicochetModel;
   import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAimingModel ;
   import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAiming;
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
   import alternativa.tanks.models.weapon.streamweapon.StreamWeaponModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.StreamWeaponModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.StreamWeaponCC;
   import alternativa.tanks.models.weapon.splash.SplashModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.ShotgunHittingModelBase;
   import alternativa.tanks.models.weapon.twins.TwinsModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.VerticalAutoAimingModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.autoaiming.WeaponVerticalAnglesModelBase;
   import alternativa.tanks.models.weapon.angles.verticals.WeaponVerticalAnglesModel;
   import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAimingModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.weakening.WeaponWeakeningCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.VerticalAnglesCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.weakening.WeaponWeakeningModelBase;
   import alternativa.tanks.models.weapon.weakening.WeaponWeakeningModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shot.DiscreteShotModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shot.ShotCC;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.stream.StreamWeaponCommunicationModelBase;
   import platform.client.fp10.core.type.IGameObject;
   import scpacker.utils.CoreUtils;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.DiscreteWeaponCommunicationModelBase;
   
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
      //private static var newname_121__END:ArtilleryModel;

      public static var weaponJsonSpecialEntities:Dictionary = new Dictionary();
      public static var weaponDatas:Dictionary = new Dictionary();
      public static var weaponWeakeningDatas:Dictionary = new Dictionary();
      
      public static var resourceRegistry:ResourceRegistry = OSGi.getInstance().getService(ResourceRegistry) as ResourceRegistry;
      
      public static var modelRegistry:ModelRegistry = OSGi.getInstance().getService(ModelRegistry) as ModelRegistry;
      
      public function WeaponModelUtil()
      {
         super();
      }
      
      public static function addModelsForWeapon(weaponObject:IGameObject, weaponName:String) : void
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
         var isisCC:IsisCC = null;
         var splashCC:SplashCC = null;
         var shotGunAimingCC:ShotGunAimingCC = null;
         var _loc2_:ShotgunShotCC = null;
         var _loc15_:ShotgunAimingModel = null;
         var machineGunCC:MachineGunCC = null;
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
         var specialEntityJsonObject:* = weaponJsonSpecialEntities[weaponName];

         Model.object = weaponObject;

         switch(weaponName.split("_")[0])
         {
            case "smoky":
               initializeDiscreteShotModel(weaponObject, weaponDatas[weaponName]);
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               initializeWeaponWeakening(weaponObject, weaponWeakeningDatas[weaponName]);
               CoreUtils.addModelToGameClass(weaponObject, SmokyModelBase.modelId);
               break;
            case "shaft":
               initializeDiscreteShotModel(weaponObject, weaponDatas[weaponName]);
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               initializeWeaponWeakening(weaponObject, weaponWeakeningDatas[weaponName]);

               _loc18_ = new LaserPointerCC();
               _loc18_.fadeInTimeMs = specialEntityJsonObject.fadeInTimeMs;
               _loc18_.laserPointerBlueColor = specialEntityJsonObject.laserPointerBlueColor;
               _loc18_.laserPointerRedColor = specialEntityJsonObject.laserPointerRedColor;
               _loc18_.locallyVisible = specialEntityJsonObject.locallyVisible;
               _loc11_ = LaserPointerModel(modelRegistry.getModel(LaserPointerModelBase.modelId));

               _loc11_.putInitParams(_loc18_);

               _loc9_ = new ShaftCC();
               _loc9_.afterShotPause = specialEntityJsonObject.afterShotPause;
               _loc9_.aimingImpact = specialEntityJsonObject.aimingImpact;
               _loc9_.chargeRate = specialEntityJsonObject.charge_rate;
               _loc9_.dischargeRate = specialEntityJsonObject.discharge_rate;
               _loc9_.fastShotEnergy = specialEntityJsonObject.fastShotEnergy;
               _loc9_.horizontalTargetingSpeed = specialEntityJsonObject.horizontal_targeting_speed;
               _loc9_.initialFOV = specialEntityJsonObject.initial_fov;
               _loc9_.maxEnergy = specialEntityJsonObject.max_energy;
               _loc9_.minAimedShotEnergy = specialEntityJsonObject.minAimedShotEnergy;
               _loc9_.minimumFOV = specialEntityJsonObject.minimum_fov;
               _loc9_.reticleImage = ImageResource(resourceRegistry.getResource(Long.getLong(0,specialEntityJsonObject.reticleImageId)));
               _loc9_.rotationCoeffKmin = specialEntityJsonObject.rotationCoeffKmin;
               _loc9_.rotationCoeffT1 = specialEntityJsonObject.rotationCoeffT1;
               _loc9_.rotationCoeffT2 = specialEntityJsonObject.rotationCoeffT2;
               _loc9_.shrubsHidingRadiusMax = specialEntityJsonObject.shrubs_hiding_radius_max;
               _loc9_.shrubsHidingRadiusMin = specialEntityJsonObject.shrubs_hiding_radius_min;
               _loc9_.targetingAcceleration = specialEntityJsonObject.targetingAcceleration;
               _loc9_.targetingTransitionTime = specialEntityJsonObject.targetingTransitionTime;
               _loc9_.verticalTargetingSpeed = specialEntityJsonObject.vertical_targeting_speed;
               _loc9_.weakeningCoeff = specialEntityJsonObject.weakeningCoeff;

               CoreUtils.addModelToGameClass(weaponObject, ShaftModelBase.modelId);
               CoreUtils.addModelToGameClass(weaponObject, LaserPointerModelBase.modelId);
               CoreUtils.addModelToGameClass(weaponObject, VerticalAutoAimingModelBase.modelId);

               shaftModel.putInitParams(_loc9_);
               shaftModel.objectLoaded();
               break;
            case "railgun":
               initializeDiscreteShotModel(weaponObject, weaponDatas[weaponName]);
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               CoreUtils.addModelToGameClass(weaponObject, RailgunModelBase.modelId);

               _loc5_ = new RailgunCC();
               _loc5_.chargingTimeMsec = specialEntityJsonObject.chargingTimeMsec;
               _loc5_.weakeningCoeff = specialEntityJsonObject.weakeningCoeff;
               
               railgunModel.putInitParams(_loc5_);
               railgunModel.objectLoaded();
               break;
            case "ricochet":
               initializeDiscreteShotModel(weaponObject, weaponDatas[weaponName]);
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               initializeWeaponWeakening(weaponObject, weaponWeakeningDatas[weaponName]);
               CoreUtils.addModelToGameClass(weaponObject, RicochetModelBase.modelId);
               CoreUtils.addModelToGameClass(weaponObject, SplashModelBase.modelId);

               // Protanki doesn't have splash for ricochet, so we create empty params
               splashCC = new SplashCC();
               splashCC.impactForce = 0;
               splashCC.minSplashDamagePercent = 0;
               splashCC.radiusOfMaxSplashDamage = 0;
               splashCC.splashDamageRadius = 0;

               splashModel.putInitParams(splashCC);
               splashModel.objectLoaded();

               _loc10_ = new RicochetCC();
               _loc10_.energyCapacity = specialEntityJsonObject.energyCapacity;
               _loc10_.energyPerShot = specialEntityJsonObject.energyPerShot;
               _loc10_.energyRechargeSpeed = specialEntityJsonObject.energyRechargeSpeed;
               _loc10_.maxRicochetCount = specialEntityJsonObject.maxRicochetCount;
               _loc10_.shellRadius = specialEntityJsonObject.shellRadius;
               _loc10_.shellSpeed = specialEntityJsonObject.shellSpeed;
               _loc10_.shotDistance = specialEntityJsonObject.shotDistance;
               
               ricochetModel.putInitParams(_loc10_);
               ricochetModel.objectLoaded();
               break;
            case "twins":
               initializeDiscreteShotModel(weaponObject, weaponDatas[weaponName]);
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               initializeWeaponWeakening(weaponObject, weaponWeakeningDatas[weaponName]);
               CoreUtils.addModelToGameClass(weaponObject, TwinsModelBase.modelId);
               CoreUtils.addModelToGameClass(weaponObject, SplashModelBase.modelId);

               // Protanki doesn't have splash for twins, so we create empty params
               splashCC = new SplashCC();
               splashCC.impactForce = 0;
               splashCC.minSplashDamagePercent = 0;
               splashCC.radiusOfMaxSplashDamage = 0;
               splashCC.splashDamageRadius = 0;
               
               splashModel.putInitParams(splashCC);
               splashModel.objectLoaded();

               _loc12_ = new TwinsCC();
               _loc12_.distance = specialEntityJsonObject.distance;
               _loc12_.shellRadius = specialEntityJsonObject.shellRadius;
               _loc12_.speed = specialEntityJsonObject.speed;

               twinsModel.putInitParams(_loc12_);
               twinsModel.objectLoaded();
               break;
            case "flamethrower":
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               initializeWeaponWeakening(weaponObject, weaponWeakeningDatas[weaponName]);
               CoreUtils.addModelToGameClass(weaponObject, FlameThrowerModelBase.modelId);

               flameThrowerCC = new FlameThrowerCC();
               flameThrowerCC.coneAngle = specialEntityJsonObject.coneAngle;
               flameThrowerCC.range = specialEntityJsonObject.range;

               flamethrowerModel.putInitParams(flameThrowerCC);
               flamethrowerModel.objectLoaded();

               initializeStreamWeapon(weaponObject, specialEntityJsonObject);
               break;
            case "freeze":
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               initializeWeaponWeakening(weaponObject, weaponWeakeningDatas[weaponName]);
               CoreUtils.addModelToGameClass(weaponObject, FreezeModelBase.modelId);

               freezeCC = new FreezeCC();
               freezeCC.damageAreaConeAngle = specialEntityJsonObject.damageAreaConeAngle;
               freezeCC.damageAreaRange = specialEntityJsonObject.damageAreaRange;

               initializeStreamWeapon(weaponObject, specialEntityJsonObject);

               freezeModel.putInitParams(freezeCC);
               freezeModel.objectLoaded();
               break;
            case "isida":
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               CoreUtils.addModelToGameClass(weaponObject, IsisModelBase.modelId);

               isisCC = new IsisCC();
               isisCC.capacity = specialEntityJsonObject.capacity;
               isisCC.chargeRate = specialEntityJsonObject.chargeRate;
               isisCC.checkPeriodMsec = specialEntityJsonObject.checkPeriodMsec;
               isisCC.coneAngle = specialEntityJsonObject.coneAngle;
               isisCC.dischargeDamageRate = specialEntityJsonObject.dischargeDamageRate;
               isisCC.dischargeHealingRate = specialEntityJsonObject.dischargeHealingRate;
               isisCC.dischargeIdleRate = specialEntityJsonObject.dischargeIdleRate;
               isisCC.radius = specialEntityJsonObject.radius;

               healingGunModel.putInitParams(isisCC);
               healingGunModel.objectLoaded();
               break;
            case "thunder":
               initializeDiscreteShotModel(weaponObject, weaponDatas[weaponName]);
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               initializeWeaponWeakening(weaponObject, weaponWeakeningDatas[weaponName]);
               CoreUtils.addModelToGameClass(weaponObject, SplashModelBase.modelId);
               CoreUtils.addModelToGameClass(weaponObject, ThunderModelBase.modelId);

               splashCC = new SplashCC();
               splashCC.impactForce = specialEntityJsonObject.impactForce;
               splashCC.minSplashDamagePercent = specialEntityJsonObject.minSplashDamagePercent;
               splashCC.radiusOfMaxSplashDamage = specialEntityJsonObject.radiusOfMaxSplashDamage;
               splashCC.splashDamageRadius = specialEntityJsonObject.splashDamageRadius;
               
               splashModel.putInitParams(splashCC);
               splashModel.objectLoaded();
               break;
            case "shotgun":
               initializeDiscreteShotModel(weaponObject, weaponDatas[weaponName]);
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               initializeWeaponWeakening(weaponObject, weaponWeakeningDatas[weaponName]);
               CoreUtils.addModelToGameClass(weaponObject, ShotgunShotModelBase.modelId);
               CoreUtils.addModelToGameClass(weaponObject, ShotgunHittingModelBase.modelId);

               shotGunAimingCC = new ShotGunAimingCC();
               shotGunAimingCC.coneHorizontalAngle = specialEntityJsonObject.coneHorizontalAngle;
               shotGunAimingCC.coneVerticalAngle = specialEntityJsonObject.coneVerticalAngle;
               shotGunAimingCC.pelletCount = specialEntityJsonObject.pelletCount;
               shotGunAimingModel.putInitParams(shotGunAimingCC);

               _loc2_ = new ShotgunShotCC();
               _loc2_.magazineReloadTime = specialEntityJsonObject.magazineReloadTime;
               _loc2_.magazineSize = specialEntityJsonObject.magazineSize;
               shotgunModel.putInitParams(_loc2_);
               break;
            case "machinegun":
               initializeDiscreteShotModel(weaponObject, weaponDatas[weaponName]);
               initializeVerticalAutoAimingModel(weaponObject, weaponDatas[weaponName]);
               initializeWeaponWeakening(weaponObject, weaponWeakeningDatas[weaponName]);
               CoreUtils.addModelToGameClass(weaponObject, MachineGunModelBase.modelId);
               CoreUtils.addModelToGameClass(weaponObject, StreamWeaponCommunicationModelBase.modelId);

               machineGunCC = new MachineGunCC();
               machineGunCC.spinDownTime = specialEntityJsonObject.spinDownTime;
               machineGunCC.spinUpTime = specialEntityJsonObject.spinUpTime;
               machineGunCC.temperatureHittingTime = specialEntityJsonObject.temperatureHittingTime;
               machineGunCC.weaponTurnDecelerationCoeff = specialEntityJsonObject.weaponTurnDecelerationCoeff;
               machineGunModel.putInitParams(machineGunCC);
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
      }
      
      private static function initializeStreamWeapon(weaponObject:IGameObject, specialEntityJsonObject:Object):void {
         var streamWeaponCC:StreamWeaponCC = new StreamWeaponCC();
         streamWeaponCC.energyCapacity = specialEntityJsonObject.energyCapacity;
         streamWeaponCC.energyDischargeSpeed = specialEntityJsonObject.energyDischargeSpeed;
         streamWeaponCC.energyRechargeSpeed = specialEntityJsonObject.energyRechargeSpeed;
         streamWeaponCC.weaponTickIntervalMsec = specialEntityJsonObject.tickIntervalMsec;

         CoreUtils.addModelToGameClass(weaponObject, StreamWeaponModelBase.modelId);
         streamWeaponModel.putInitParams(streamWeaponCC);
         streamWeaponModel.objectLoaded();
      }

      private static function initializeVerticalAutoAimingModel(weaponObject:IGameObject, weaponData:WeaponData):void {
         var weaponVerticalAnglesModel:WeaponVerticalAnglesModel = WeaponVerticalAnglesModel(modelRegistry.getModel(WeaponVerticalAnglesModelBase.modelId));
         var verticalAutoAimingModel:VerticalAutoAimingModel = VerticalAutoAimingModel(modelRegistry.getModel(VerticalAutoAimingModelBase.modelId));

         var verticalAnglesCC:VerticalAnglesCC = new VerticalAnglesCC();
         verticalAnglesCC.angleDown = weaponData.autoAimingDown;
         verticalAnglesCC.angleUp = weaponData.autoAimingUp;

         CoreUtils.addModelToGameClass(weaponObject, WeaponVerticalAnglesModelBase.modelId);
         CoreUtils.addModelToGameClass(weaponObject, VerticalAutoAimingModelBase.modelId);
         weaponVerticalAnglesModel.putInitParams(verticalAnglesCC);
      }
      
      private static function initializeWeaponWeakening(weaponObject:IGameObject, weaponWeakeningCC:WeaponWeakeningCC):void {
         var weaponWeakeningModel:WeaponWeakeningModel = WeaponWeakeningModel(modelRegistry.getModel(WeaponWeakeningModelBase.modelId));
         CoreUtils.addModelToGameClass(weaponObject, WeaponWeakeningModelBase.modelId);
         weaponWeakeningModel.putInitParams(weaponWeakeningCC);
         weaponWeakeningModel.objectLoaded();
      }

      private static function initializeDiscreteShotModel(weaponObject:IGameObject, weaponData:WeaponData):void {
         var discreteShotModel:DiscreteShotModelBase = DiscreteShotModelBase(modelRegistry.getModel(DiscreteShotModelBase.modelId));
         CoreUtils.addModelToGameClass(weaponObject, DiscreteShotModelBase.modelId);
         CoreUtils.addModelToGameClass(weaponObject, DiscreteWeaponCommunicationModelBase.modelId);

         var shotCC:ShotCC = new ShotCC();
         shotCC.reloadMsec = weaponData.reload;

         discreteShotModel.putInitParams(shotCC);
      }
   }
}

