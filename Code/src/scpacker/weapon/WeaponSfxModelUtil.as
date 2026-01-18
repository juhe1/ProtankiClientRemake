package scpacker.weapon
{
   import projects.tanks.client.battlefield.models.tankparts.sfx.firebird.FlameThrowingSFXCC;
   import alternativa.tanks.models.weapon.flamethrower.FlamethrowerSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx.MachineGunSFXCC;
   import alternativa.tanks.models.weapon.healing.HealingGunSFXModel;
   import alternativa.tanks.models.weapon.railgun.RailgunSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.freeze.FreezeSFXCC;
   import alternativa.tanks.models.weapon.freeze.FreezeSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet.RicochetSFXCC;
   import alternativa.types.Long;
   import projects.tanks.client.battlefield.models.tankparts.sfx.isis.IsisSFXCC;
   import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.ThunderShootSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx.ShotgunSFXCC;
   import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunSFXModel;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.models.weapon.thunder.ThunderSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.bcsh.BCSHStruct;
   import projects.tanks.client.battlefield.models.tankparts.sfx.bcsh.BCSHModelCC;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.sfx.ArtillerySfxCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun.RailgunShootSFXCC;
   import flash.utils.Dictionary;
   import alternativa.object.ClientObject;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft.ShaftShootSFXCC;
   import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfxModel;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.impl.*;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.type.IGameObject;
   import alternativa.tanks.models.weapon.ricochet.RicochetSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins.TwinsShootSFXCC;
   import alternativa.tanks.models.sfx.colortransform.ColorTransformEntry;
   import alternativa.tanks.models.weapon.smoky.sfx.SmokySFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.struct.ColorTransformStruct;
   import alternativa.tanks.models.weapon.shaft.ShaftSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky.SmokyShootSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingEffectEntity;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightEffectItem;
   import alternativa.tanks.models.weapon.twins.TwinsSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky.SmokyShootSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun.RailgunShootSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.sfx.ArtillerySfxModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx.MachineGunSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx.ShotgunSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft.ShaftShootSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet.RicochetSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.freeze.FreezeSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.ThunderShootSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.isis.IsisSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins.TwinsShootSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.firebird.FlameThrowingSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.bcsh.BCSHModelBase;
   import scpacker.utils.CoreUtils;
   
   public class WeaponSfxModelUtil
   {
      public static var resourceRegistry:ResourceRegistry = OSGi.getInstance().getService(ResourceRegistry) as ResourceRegistry;
      public static var modelRegistry:ModelRegistry = OSGi.getInstance().getService(ModelRegistry) as ModelRegistry;

      private static var smokySfxModel:SmokySFXModel;
      private static var railgunSfxModel:RailgunSFXModel;
      private static var flamethrowerSfxModel:FlamethrowerSFXModel;
      private static var twinsSfxModel:TwinsSFXModel;
      private static var isisSfxModel:HealingGunSFXModel;
      private static var thunderSfxModel:ThunderSFXModel;
      private static var freezeSfxModel:FreezeSFXModel;
      private static var ricochetSfxModel:RicochetSFXModel;
      private static var shaftSfxModel:ShaftSFXModel;
      private static var shotgunSfxModel:ShotgunSFXModel;
      private static var machineGunSfxModel:MachineGunSFXModel;
      private static var artillerySfxModel:ArtillerySfxModel;
      
      public function WeaponSfxModelUtil()
      {
         super();
      }
      
      public static function addSfxModelsForWeapon(weaponName:String, sfxDataJsonObject:Object, gameObject:IGameObject) : void
      {
         if(smokySfxModel == null)
         {
            smokySfxModel = modelRegistry.getModel(SmokyShootSFXModelBase.modelId) as SmokySFXModel;
            railgunSfxModel = modelRegistry.getModel(RailgunShootSFXModelBase.modelId) as RailgunSFXModel;
            flamethrowerSfxModel = modelRegistry.getModel(FlameThrowingSFXModelBase.modelId) as FlamethrowerSFXModel;
            twinsSfxModel = modelRegistry.getModel(TwinsShootSFXModelBase.modelId) as TwinsSFXModel;
            isisSfxModel = modelRegistry.getModel(IsisSFXModelBase.modelId) as HealingGunSFXModel;
            thunderSfxModel = modelRegistry.getModel(ThunderShootSFXModelBase.modelId) as ThunderSFXModel;
            freezeSfxModel = modelRegistry.getModel(FreezeSFXModelBase.modelId) as FreezeSFXModel;
            ricochetSfxModel = modelRegistry.getModel(RicochetSFXModelBase.modelId) as RicochetSFXModel;
            shaftSfxModel = modelRegistry.getModel(ShaftShootSFXModelBase.modelId) as ShaftSFXModel;
            shotgunSfxModel = modelRegistry.getModel(ShotgunSFXModelBase.modelId) as ShotgunSFXModel;
            machineGunSfxModel = modelRegistry.getModel(MachineGunSFXModelBase.modelId) as MachineGunSFXModel;
            artillerySfxModel = modelRegistry.getModel(ArtillerySfxModelBase.modelId) as ArtillerySfxModel;
         }
         
         initializeBCSHModelForGameObject(sfxDataJsonObject,gameObject);
         var lightingEffectEntity:LightingSFXEntity = createLightingEffectEntity(sfxDataJsonObject,gameObject);
         Model.object = gameObject;
         switch(weaponName.split("_")[0])
         {
            case "smoky":
               createSmokySfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            case "flamethrower":
               createFlamethrowerSfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            case "twins":
               createTwinsSfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            case "railgun":
               createRailgunSfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            case "ricochet":
               createRicochetSfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            case "freeze":
               createFreezeSfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            case "isida":
               createIsisSfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            case "shaft":
               createShaftSfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            case "thunder":
               createThunderSfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            case "shotgun":
               createShotgunSfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            case "machinegun":
               createMachineGunSfx(gameObject,lightingEffectEntity,sfxDataJsonObject);
               break;
            //case "artillery":
            //   createArtillerySfx(param1,param3);
         }
         Model.popObject();
      }
      
      public static function initializeBCSHModelForGameObject(param1:Object, gameObject:IGameObject) : void
      {
         CoreUtils.addModelToGameClass(gameObject, BCSHModelBase.modelId);
         var _loc5_:BCSHStruct = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Vector.<BCSHStruct> = new Vector.<BCSHStruct>();
         for each(var _loc4_ in param1.bcsh)
         {
            _loc5_ = new BCSHStruct();
            _loc5_.brightness = _loc4_.brightness;
            _loc5_.contrast = _loc4_.contrast;
            _loc5_.hue = _loc4_.hue;
            _loc5_.key = _loc4_.key;
            _loc5_.saturation = _loc4_.saturation;
            _loc3_[_loc3_.length] = _loc5_;
         }
         Model.object = gameObject;
         modelRegistry.getModel(gameObject.gameClass.models[3]).putInitParams(new BCSHModelCC(_loc3_));
         ObjectLoadListener(modelRegistry.getModel(gameObject.gameClass.models[3])).objectLoaded();
         Model.popObject();
      }
      
      public static function createLightingEffectEntity(param1:Object, param2:IGameObject) : LightingSFXEntity
      {
         var lightingEffect:LightingEffectEntity = null;
         var lightEfectItem:LightEffectItem = null;
         if(param1 == null)
         {
            return null;
         }
         var records:Vector.<LightingEffectEntity> = new Vector.<LightingEffectEntity>();
         for each(var _loc7_ in param1.lighting)
         {
            lightingEffect = new LightingEffectEntity();
            lightingEffect.effectName = _loc7_.name;
            lightingEffect.items = new Vector.<LightEffectItem>();
            for each(var _loc3_ in _loc7_.light)
            {
               lightEfectItem = new LightEffectItem();
               lightEfectItem.attenuationBegin = _loc3_.attenuationBegin;
               lightEfectItem.attenuationEnd = _loc3_.attenuationEnd;
               lightEfectItem.color = _loc3_.color;
               lightEfectItem.intensity = _loc3_.intensity;
               lightEfectItem.time = _loc3_.time;
               lightingEffect.items[lightingEffect.items.length] = lightEfectItem;
            }
            records[records.length] = lightingEffect;
         }
         return new LightingSFXEntity(records);
      }
      
      public static function createRailgunSfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) : RailgunSFXModel
      {
         CoreUtils.addModelToGameClass(gameObject, RailgunShootSFXModelBase.modelId);
         var _loc3_:RailgunShootSFXCC = null;
         var _loc4_:RailgunSFXModel = railgunSfxModel;
         if(param2 != null)
         {
            _loc3_ = new RailgunShootSFXCC();
            _loc3_.chargingPart1 = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.chargingPart1)));
            _loc3_.chargingPart2 = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.chargingPart2)));
            _loc3_.chargingPart3 = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.chargingPart3)));
            _loc3_.hitMarkTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.hitMarkTexture)));
            _loc3_.powTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.powTexture)));
            _loc3_.ringsTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.ringsTexture)));
            _loc3_.shotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.smokeImage = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.smokeImage)));
            _loc3_.sphereTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.sphereTexture)));
            _loc3_.trailImage = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.trailImage)));
            _loc3_.lightingSFXEntity = lightingEffectEntity;
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoadedPost();
            Model.popObject();
         }
         return _loc4_;
      }
      
      public static function createSmokySfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) : SmokySFXModel
      {
         CoreUtils.addModelToGameClass(gameObject, SmokyShootSFXModelBase.modelId);
         var _loc3_:SmokyShootSFXCC = null;
         var _loc4_:SmokySFXModel = smokySfxModel;
         if(param2 != null)
         {
            _loc3_ = new SmokyShootSFXCC();
            _loc3_.criticalHitSize = param2.criticalHitSize;
            _loc3_.criticalHitTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.criticalHitTexture)));
            _loc3_.explosionMarkTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionMarkTexture)));
            _loc3_.explosionSize = param2.explosionSize;
            _loc3_.explosionSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionSound)));
            _loc3_.explosionTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.shotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.shotTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.shotTexture)));
            _loc3_.lightingSFXEntity = lightingEffectEntity;
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoaded();
            Model.popObject();
         }
         return _loc4_;
      }
      
      public static function createFlamethrowerSfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) : FlamethrowerSFXModel
      {
         CoreUtils.addModelToGameClass(gameObject, FlameThrowingSFXModelBase.modelId);
         var _loc3_:FlameThrowingSFXCC = null;
         var _loc6_:* = undefined;
         var _loc4_:ColorTransformEntry = null;
         var _loc7_:FlamethrowerSFXModel = flamethrowerSfxModel;
         if(param2 != null)
         {
            _loc3_ = new FlameThrowingSFXCC();
            _loc3_.fireTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.fireTexture)));
            _loc3_.flameSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.flameSound)));
            _loc3_.muzzlePlaneTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.muzzlePlaneTexture)));
            _loc3_.lightingSFXEntity = lightingEffectEntity;

            _loc6_ = new Vector.<ColorTransformEntry>();
            for each(var _loc5_ in param2.colorTransform)
            {
               var colorTransformStruct:ColorTransformStruct = new ColorTransformStruct();
               colorTransformStruct.redMultiplier = _loc5_.redMultiplier;
               colorTransformStruct.greenMultiplier = _loc5_.greenMultiplier;
               colorTransformStruct.blueMultiplier = _loc5_.blueMultiplier;
               colorTransformStruct.alphaMultiplier = _loc5_.alphaMultiplier;
               colorTransformStruct.redOffset = _loc5_.redOffset;
               colorTransformStruct.greenOffset = _loc5_.greenOffset;
               colorTransformStruct.blueOffset = _loc5_.blueOffset;
               colorTransformStruct.alphaOffset = _loc5_.alphaOffset;
               colorTransformStruct.t = _loc5_.t;
		       _loc4_ = new ColorTransformEntry(colorTransformStruct);
               _loc6_.push(_loc4_);
            }

            Model.object = gameObject;
            _loc7_.putInitParams(_loc3_);
            _loc7_.objectLoaded();
            _loc7_.initColorTransform(_loc6_);
            Model.popObject();
         }
         return _loc7_;
      }
      
      public static function createTwinsSfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) : TwinsSFXModel
      {
         CoreUtils.addModelToGameClass(gameObject, TwinsShootSFXModelBase.modelId);
         var _loc3_:TwinsShootSFXCC = null;
         var _loc4_:TwinsSFXModel = twinsSfxModel;
         if(param2 != null)
         {
            _loc3_ = new TwinsShootSFXCC();
            _loc3_.explosionTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.hitMarkTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.hitMarkTexture)));
            _loc3_.muzzleFlashTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.muzzleFlashTexture)));
            _loc3_.shotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.shotTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.shotTexture)));
            _loc3_.lightingSFXEntity = lightingEffectEntity;
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoadedPost();
            Model.popObject();
         }
         return _loc4_;
      }
      
      public static function createIsisSfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) :HealingGunSFXModel 
      {
         CoreUtils.addModelToGameClass(gameObject, IsisSFXModelBase.modelId);
         var _loc3_:IsisSFXCC = null;
         var _loc4_:HealingGunSFXModel = isisSfxModel;
         if(param2 != null)
         {
            _loc3_ = new IsisSFXCC();
            _loc3_.damagingBall = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.damagingBall)));
            _loc3_.damagingRay = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.damagingRay)));
            _loc3_.damagingSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.damagingSound)));
            _loc3_.healingBall = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.healingBall)));
            _loc3_.healingRay = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.healingRay)));
            _loc3_.healingSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.healingSound)));
            _loc3_.idleSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.idleSound)));
            _loc3_.lightingSFXEntity = lightingEffectEntity;
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoadedPost();
            Model.popObject();
         }
         return _loc4_;
      }
      
      public static function createThunderSfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) : ThunderSFXModel
      {
         CoreUtils.addModelToGameClass(gameObject, ThunderShootSFXModelBase.modelId);
         var _loc3_:ThunderShootSFXCC = null;
         var _loc4_:ThunderSFXModel = thunderSfxModel;
         if(param2 != null)
         {
            _loc3_ = new ThunderShootSFXCC();
            _loc3_.explosionMarkTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionMarkTexture)));
            _loc3_.explosionSize = param2.explosionSize;
            _loc3_.explosionSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionSound)));
            _loc3_.explosionTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.shotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.shotTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.shotTexture)));
            _loc3_.lightingSFXEntity = lightingEffectEntity;
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoaded();
            Model.popObject();
         }
         return _loc4_;
      }
      
      public static function createFreezeSfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) : FreezeSFXModel
      {
         CoreUtils.addModelToGameClass(gameObject, FreezeSFXModelBase.modelId);
         var _loc3_:FreezeSFXCC = null;
         var _loc4_:FreezeSFXModel = freezeSfxModel;
         if(param2 != null)
         {
            _loc3_ = new FreezeSFXCC();
            _loc3_.particleSpeed = param2.particleSpeed;
            _loc3_.particleTextureResource = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.particleTextureResource)));
            _loc3_.planeTextureResource = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.planeTextureResource)));
            _loc3_.shotSoundResource = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSoundResource)));
            _loc3_.lightingSFXEntity = lightingEffectEntity;
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoaded();
            Model.popObject();
         }
         return _loc4_;
      }
      
      public static function createRicochetSfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) : RicochetSFXModel
      {
         CoreUtils.addModelToGameClass(gameObject, RicochetSFXModelBase.modelId);
         var _loc3_:RicochetSFXCC = null;
         var _loc4_:RicochetSFXModel = ricochetSfxModel;
         if(param2 != null)
         {
            _loc3_ = new RicochetSFXCC();
            _loc3_.bumpFlashTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.bumpFlashTexture)));
            _loc3_.explosionTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.explostinSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionSound)));
            _loc3_.ricochetSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.ricochetSound)));
            _loc3_.shotFlashTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.shotFlashTexture)));
            _loc3_.shotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.shotTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.shotTexture)));
            _loc3_.tailTrailTexutre = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.tailTrailTexutre)));
            _loc3_.lightingSFXEntity = lightingEffectEntity;
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoadedPost();
            Model.popObject();
         }
         return _loc4_;
      }
      
      public static function createShaftSfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) : ShaftSFXModel
      {
         CoreUtils.addModelToGameClass(gameObject, ShaftShootSFXModelBase.modelId);
         var _loc3_:ShaftSFXModel = shaftSfxModel;
         var _loc4_:ShaftShootSFXCC = null;
         if(param2 != null)
         {
            _loc4_ = new ShaftShootSFXCC();
            _loc4_.explosionSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionSound)));
            _loc4_.explosionTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc4_.hitMarkTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.hitMarkTexture)));
            _loc4_.muzzleFlashTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.muzzleFlashTexture)));
            _loc4_.shotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSound)));
            _loc4_.targetingSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.targetingSound)));
            _loc4_.trailTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.trailTexture)));
            _loc4_.zoomModeSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.zoomModeSound)));
            _loc4_.lightingSFXEntity = lightingEffectEntity;
            Model.object = gameObject;
            _loc3_.putInitParams(_loc4_);
            _loc3_.objectLoadedPost();
            Model.popObject();
         }
         return _loc3_;
      }
      
      public static function createShotgunSfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) : ShotgunSFXModel
      {
         CoreUtils.addModelToGameClass(gameObject, ShotgunSFXModelBase.modelId);
         var _loc3_:ShotgunSFXCC = null;
         var _loc4_:ShotgunSFXModel = shotgunSfxModel;
         if(param2 != null)
         {
            _loc3_ = new ShotgunSFXCC();
            _loc3_.explosionMarkTextures = new Vector.<ImageResource>(4);
            _loc3_.explosionMarkTextures[0] = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionMarkTexture0)));
            _loc3_.explosionMarkTextures[1] = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionMarkTexture1)));
            _loc3_.explosionMarkTextures[2] = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionMarkTexture2)));
            _loc3_.explosionMarkTextures[3] = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionMarkTexture3)));
            _loc3_.magazineReloadSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.magazineReloadSound)));
            _loc3_.pelletTrailTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.pelletTrailTexture)));
            _loc3_.reloadSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.reloadSound)));
            _loc3_.shotAcrossTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.shotAcrossTexture)));
            _loc3_.shotAlongTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.shotAlongTexture)));
            _loc3_.shotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.smokeTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.smokeTexture)));
            _loc3_.sparkleTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.sparkleTexture)));
            _loc3_.lightingSFXEntity = lightingEffectEntity;
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoadedPost();
            Model.popObject();
         }
         return _loc4_;
      }
      
      public static function createMachineGunSfx(gameObject:IGameObject, lightingEffectEntity:LightingSFXEntity, param2:Object = null) : MachineGunSFXModel
      {
         CoreUtils.addModelToGameClass(gameObject, MachineGunSFXModelBase.modelId);
         var _loc3_:MachineGunSFXModel = machineGunSfxModel;
         var _loc4_:MachineGunSFXCC = null;
         if(param2 != null)
         {
            _loc4_ = new MachineGunSFXCC();
            _loc4_.chainStartSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.chainStartSound)));
            _loc4_.crumbsTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.crumbsTexture)));
            _loc4_.dustTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.dustTexture)));
            _loc4_.fireAcrossTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.fireAcrossTexture)));
            _loc4_.fireAlongTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.fireAlongTexture)));
            _loc4_.hitSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.hitSound)));
            _loc4_.longFailSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.longFailSound)));
            _loc4_.shootEndSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shootEndSound)));
            _loc4_.shootSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shootSound)));
            _loc4_.smokeTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.smokeTexture)));
            _loc4_.sparklesTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.sparklesTexture)));
            _loc4_.tankHitSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.tankHitSound)));
            _loc4_.tankSparklesTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.tankSparklesTexture)));
            _loc4_.tracerTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.tracerTexture)));
            _loc4_.turbineStartSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.turbineStartSound)));
            _loc4_.lightingSFXEntity = lightingEffectEntity;
            Model.object = gameObject;
            _loc3_.putInitParams(_loc4_);
            _loc3_.objectLoadedPost();
            Model.popObject();
         }
         return _loc3_;
      }
      
      //public static function createArtillerySfx(param1:ClientObject, param2:Object = null) : ArtillerySfxModel
      //{
      //   var _loc3_:ArtillerySfxCC = null;
      //   if(artillerySfxDictionary == null)
      //   {
      //      artillerySfxDictionary = new Dictionary();
      //   }
      //   if(param2 != null)
      //   {
      //      _loc3_ = new ArtillerySfxCC();
      //      _loc3_.chargingSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.chargingSound)));
      //      _loc3_.explosionSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionSound)));
      //      _loc3_.farShotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.farShotSound)));
      //      _loc3_.flyBySound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.flyBySound)));
      //      _loc3_.shot1Sound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shot1Sound)));
      //      _loc3_.shot2Sound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shot2Sound)));
      //      _loc3_.shot3Sound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shot3Sound)));
      //      _loc3_.shot4Sound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shot4Sound)));
      //      _loc3_.reloadSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.reloadSound)));
      //      _loc3_.streamTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.streamTexture)));
      //      _loc3_.flameTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.flameTexture)));
      //      _loc3_.trailTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.trailTexture)));
      //      _loc3_.markTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.markTexture)));
      //      _loc3_.explosionTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionTexture)));
      //      _loc3_.smokeTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.smokeTexture)));
      //      artillerySfxDictionary[param1.id] = new ArtillerySfxModel();
      //      artillerySfxDictionary[param1.id].putInitParams(_loc3_);
      //      artillerySfxDictionary[param1.id].objectLoaded(param1);
      //   }
      //   return artillerySfxDictionary[param1.id];
      //}
   }
}

