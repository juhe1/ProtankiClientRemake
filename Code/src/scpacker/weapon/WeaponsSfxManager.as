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
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.LightingEfect;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.LightingSFXModelCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.LightingEfectRecord;
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
   import alternativa.tanks.models.weapon.common.IProtankiWeaponService;
   import alternativa.tanks.models.weapon.common.ProtankiWeaponService;
   import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.struct.ColorTransformStruct;
   import alternativa.tanks.models.weapon.plasma.TwinsSFXModel;
   import alternativa.tanks.models.weapon.shaft.ShaftSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky.SmokyShootSFXCC;
   
   public class WeaponsSfxManager
   {
      public static var resourceRegistry:ResourceRegistry = OSGi.getInstance().getService(ResourceRegistry) as ResourceRegistry;
      public static var modelRegistry:ModelRegistry = OSGi.getInstance().getService(ModelRegistry) as ModelRegistry;
      
      private static var railgunSfxDictionary:Dictionary = new Dictionary();
      private static var smokyShootSfxDictionary:Dictionary = new Dictionary();
      private static var flameThrowingSfxDictionary:Dictionary = new Dictionary();
      private static var twinsShootSfxDictionary:Dictionary = new Dictionary();
      private static var isisSfxDictionary:Dictionary = new Dictionary();
      private static var thunderShootSfxDictionary:Dictionary = new Dictionary();
      private static var freezeSfxDictionary:Dictionary = new Dictionary();
      private static var ricochetSfxDictionary:Dictionary = new Dictionary();
      private static var shaftShootSfxDictionary:Dictionary = new Dictionary();
      private static var shotgunSfxDictionary:Dictionary = new Dictionary();
      private static var machineGunSfxDictionary:Dictionary = new Dictionary();
      private static var artillerySfxDictionary:Dictionary = new Dictionary();
      private static var newname_5978__END:Dictionary = new Dictionary();
      
      public function WeaponsSfxManager()
      {
         super();
      }
      
      public static function initProtankiWeaponService(param1:ClientObject, param2:ClientObject, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         // IWeaponCommonModel
         var protankiWeaponService:ProtankiWeaponService = OSGi.getInstance().getService(IProtankiWeaponService) as ProtankiWeaponService;
         if(protankiWeaponService == null)
         {
            protankiWeaponService = new ProtankiWeaponService();
            OSGi.getInstance().registerService(IProtankiWeaponService,protankiWeaponService);
         }
         protankiWeaponService.initWeaponCommonData(param2,param3,param4,param5,param6);
      }
      
      public static function CreateSfxCCForWeapon(weaponName:String, jsonObject:Object, gameObject:IGameObject) : void
      {
         initializeBCSHModelForGameObject(jsonObject,gameObject);
         initializeLightingEffects(jsonObject,gameObject);
         Model.object = gameObject;
         switch(weaponName.split("_")[0])
         {
            case "smoky":
               createSmokySfx(gameObject,jsonObject);
               break;
            case "flamethrower":
               createFlamethrowerSfx(gameObject,jsonObject);
               break;
            case "twins":
               createTwinsSfx(gameObject,jsonObject);
               break;
            case "railgun":
               createRailgunSfx(gameObject,jsonObject);
               break;
            case "ricochet":
               createRicochetSfx(gameObject,jsonObject);
               break;
            case "freeze":
               createFreezeSfx(gameObject,jsonObject);
               break;
            case "isida":
               createIsisSfx(gameObject,jsonObject);
               break;
            case "shaft":
               createShaftSfx(gameObject,jsonObject);
               break;
            case "thunder":
               createThunderSfx(gameObject,jsonObject);
               break;
            case "shotgun":
               createShotgunSfx(gameObject,jsonObject);
               break;
            case "machinegun":
               createMachineGunSfx(gameObject,jsonObject);
               break;
            //case "artillery":
            //   createArtillerySfx(param1,param3);
         }
         Model.popObject();
      }
      
      public static function initializeBCSHModelForGameObject(param1:Object, gameObject:IGameObject) : void
      {
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
      
      public static function initializeLightingEffects(param1:Object, param2:IGameObject) : void
      {
         var lightingEffect:LightingEfect = null;
         var lightingEfectRecord:LightingEfectRecord = null;
         if(param1 == null)
         {
            return;
         }
         var records:Vector.<LightingEfect> = new Vector.<LightingEfect>();
         for each(var _loc7_ in param1.lighting)
         {
            lightingEffect = new LightingEfect();
            lightingEffect.name = _loc7_.name;
            lightingEffect.records = new Vector.<LightingEfectRecord>();
            for each(var _loc3_ in _loc7_.light)
            {
               lightingEfectRecord = new LightingEfectRecord();
               lightingEfectRecord.attenuationBegin = _loc3_.attenuationBegin;
               lightingEfectRecord.attenuationEnd = _loc3_.attenuationEnd;
               lightingEfectRecord.color = _loc3_.color;
               lightingEfectRecord.intensity = _loc3_.intensity;
               lightingEfectRecord.time = _loc3_.time;
               lightingEffect.records[lightingEffect.records.length] = lightingEfectRecord;
            }
            records[records.length] = lightingEffect;
         }
         Model.object = param2;
         modelRegistry.getModel(param2.gameClass.models[4]).putInitParams(new LightingSFXModelCC(records));
         Model.popObject();
      }
      
      public static function createRailgunSfx(gameObject:IGameObject, param2:Object = null) : RailgunSFXModel
      {
         var _loc3_:RailgunShootSFXCC = null;
         if(railgunSfxDictionary == null)
         {
            railgunSfxDictionary = new Dictionary();
         }
         var _loc4_:RailgunSFXModel = railgunSfxDictionary[param1.id];
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
            _loc4_ = new RailgunSFXModel();
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoadedPost();
            Model.popObject();
            railgunSfxDictionary[param1.id] = _loc4_;
         }
         return _loc4_;
      }
      
      public static function createSmokySfx(gameObject:IGameObject, param2:Object = null) : SmokySFXModel
      {
         var _loc3_:SmokyShootSFXCC = null;
         if(smokyShootSfxDictionary == null)
         {
            smokyShootSfxDictionary = new Dictionary();
         }
         var _loc4_:SmokySFXModel = smokyShootSfxDictionary[param1.id];
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
            _loc4_ = new SmokySFXModel();
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoaded();
            Model.popObject();
            smokyShootSfxDictionary[param1.id] = _loc4_;
         }
         return _loc4_;
      }
      
      public static function createFlamethrowerSfx(gameObject:IGameObject, param2:Object = null) : FlamethrowerSFXModel
      {
         var _loc3_:FlameThrowingSFXCC = null;
         var _loc6_:* = undefined;
         var _loc4_:ColorTransformEntry = null;
         if(flameThrowingSfxDictionary == null)
         {
            flameThrowingSfxDictionary = new Dictionary();
         }
         var _loc7_:FlamethrowerSFXModel = flameThrowingSfxDictionary[param1.id];
         if(param2 != null)
         {
            _loc7_ = new FlamethrowerSFXModel();
            _loc3_ = new FlameThrowingSFXCC();
            _loc3_.fireTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.fireTexture)));
            _loc3_.flameSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.flameSound)));
            _loc3_.muzzlePlaneTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.muzzlePlaneTexture)));

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

            flameThrowingSfxDictionary[param1.id] = _loc7_;
         }
         return _loc7_;
      }
      
      public static function createTwinsSfx(gameObject:IGameObject, param2:Object = null) : TwinsSFXModel
      {
         var _loc3_:TwinsShootSFXCC = null;
         if(twinsShootSfxDictionary == null)
         {
            twinsShootSfxDictionary = new Dictionary();
         }
         if(param2 != null)
         {
            twinsShootSfxDictionary[param1.id] = new TwinsSFXModel();
            _loc3_ = new TwinsShootSFXCC();
            _loc3_.explosionTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.hitMarkTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.hitMarkTexture)));
            _loc3_.muzzleFlashTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.muzzleFlashTexture)));
            _loc3_.shotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.shotTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.shotTexture)));
            Model.object = gameObject;
            twinsShootSfxDictionary[param1.id].putInitParams(_loc3_);
            twinsShootSfxDictionary[param1.id].objectLoadedPost();
            Model.popObject();
         }
         return twinsShootSfxDictionary[param1.id];
      }
      
      public static function createIsisSfx(gameObject:IGameObject, param2:Object = null) :HealingGunSFXModel 
      {
         var _loc3_:IsisSFXCC = null;
         if(isisSfxDictionary == null)
         {
            isisSfxDictionary = new Dictionary();
         }
         if(param2 != null)
         {
            isisSfxDictionary[param1.id] = new HealingGunSFXModel();
            _loc3_ = new IsisSFXCC();
            _loc3_.damagingBall = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.damagingBall)));
            _loc3_.damagingRay = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.damagingRay)));
            _loc3_.damagingSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.damagingSound)));
            _loc3_.healingBall = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.healingBall)));
            _loc3_.healingRay = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.healingRay)));
            _loc3_.healingSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.healingSound)));
            _loc3_.idleSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.idleSound)));
            Model.object = gameObject;
            isisSfxDictionary[param1.id].putInitParams(_loc3_);
            isisSfxDictionary[param1.id].objectLoadedPost();
            Model.popObject();
         }
         return isisSfxDictionary[param1.id];
      }
      
      public static function createThunderSfx(gameObject:IGameObject, param2:Object = null) : ThunderSFXModel
      {
         var _loc3_:ThunderShootSFXCC = null;
         if(thunderShootSfxDictionary == null)
         {
            thunderShootSfxDictionary = new Dictionary();
         }
         if(param2 != null)
         {
            thunderShootSfxDictionary[param1.id] = new ThunderSFXModel();
            _loc3_ = new ThunderShootSFXCC();
            _loc3_.explosionMarkTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionMarkTexture)));
            _loc3_.explosionSize = param2.explosionSize;
            _loc3_.explosionSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionSound)));
            _loc3_.explosionTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.shotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.shotTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.shotTexture)));
            Model.object = gameObject;
            thunderShootSfxDictionary[param1.id].putInitParams(_loc3_);
            thunderShootSfxDictionary[param1.id].objectLoaded();
            Model.popObject();
         }
         return thunderShootSfxDictionary[param1.id];
      }
      
      public static function createFreezeSfx(gameObject:IGameObject, param2:Object = null) : FreezeSFXModel
      {
         var _loc3_:FreezeSFXCC = null;
         if(freezeSfxDictionary == null)
         {
            freezeSfxDictionary = new Dictionary();
         }
         if(param2 != null)
         {
            freezeSfxDictionary[param1.id] = new FreezeSFXModel();
            _loc3_ = new FreezeSFXCC();
            _loc3_.particleSpeed = param2.particleSpeed;
            _loc3_.particleTextureResource = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.particleTextureResource)));
            _loc3_.planeTextureResource = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.planeTextureResource)));
            _loc3_.shotSoundResource = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSoundResource)));
            Model.object = gameObject;
            freezeSfxDictionary[param1.id].putInitParams(_loc3_);
            freezeSfxDictionary[param1.id].objectLoaded();
            Model.popObject();
         }
         return freezeSfxDictionary[param1.id];
      }
      
      public static function createRicochetSfx(gameObject:IGameObject, param2:Object = null) : RicochetSFXModel
      {
         var _loc3_:RicochetSFXCC = null;
         if(ricochetSfxDictionary == null)
         {
            ricochetSfxDictionary = new Dictionary();
         }
         var _loc4_:RicochetSFXModel = ricochetSfxDictionary[param1.id];
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
            _loc3_.tailTrailTexutre = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.tailTrailTexture)));
            _loc4_ = new RicochetSFXModel();
            Model.object = gameObject;
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoadedPost();
            Model.popObject();
            ricochetSfxDictionary[param1.id] = _loc4_;
         }
         return _loc4_;
      }
      
      public static function createShaftSfx(gameObject:IGameObject, param2:Object = null) : ShaftSFXModel
      {
         var _loc3_:ShaftSFXModel = null;
         var _loc4_:ShaftShootSFXCC = null;
         if(shaftShootSfxDictionary == null)
         {
            shaftShootSfxDictionary = new Dictionary();
         }
         if(param2 != null)
         {
            shaftShootSfxDictionary[param1.id] = new ShaftSFXModel();
            _loc4_ = new ShaftShootSFXCC();
            _loc4_.explosionSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionSound)));
            _loc4_.explosionTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc4_.hitMarkTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.hitMarkTexture)));
            _loc4_.muzzleFlashTexture = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,param2.muzzleFlashTexture)));
            _loc4_.shotSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.shotSound)));
            _loc4_.targetingSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.targetingSound)));
            _loc4_.trailTexture = ImageResource(resourceRegistry.getResource(Long.getLong(0,param2.trailTexture)));
            _loc4_.zoomModeSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,param2.zoomModeSound)));
            Model.object = gameObject;
            shaftShootSfxDictionary[param1.id].putInitParams(_loc4_);
            shaftShootSfxDictionary[param1.id].objectLoadedPost();
            Model.popObject();
         }
         return shaftShootSfxDictionary[param1.id];
      }
      
      public static function createShotgunSfx(gameObject:IGameObject, param2:Object = null) : ShotgunSFXModel
      {
         var _loc3_:ShotgunSFXCC = null;
         var _loc4_:ShotgunSFXModel = null;
         if(shotgunSfxDictionary == null)
         {
            shotgunSfxDictionary = new Dictionary();
         }
         if(param2 != null)
         {
            shotgunSfxDictionary[param1.id] = new ShotgunSFXModel();
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
            Model.object = gameObject;
            shotgunSfxDictionary[param1.id].putInitParams(_loc3_);
            shotgunSfxDictionary[param1.id].objectLoadedPost();
            Model.popObject();
         }
         return shotgunSfxDictionary[param1.id];
      }
      
      public static function createMachineGunSfx(gameObject:IGameObject, param2:Object = null) : MachineGunSFXModel
      {
         var _loc3_:MachineGunSFXModel = null;
         var _loc4_:MachineGunSFXCC = null;
         if(machineGunSfxDictionary == null)
         {
            machineGunSfxDictionary = new Dictionary();
         }
         if(param2 != null)
         {
            machineGunSfxDictionary[param1.id] = new MachineGunSFXModel();
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
            Model.object = gameObject;
            machineGunSfxDictionary[param1.id].putInitParams(_loc4_);
            machineGunSfxDictionary[param1.id].objectLoadedPost();
            Model.popObject();
         }
         return machineGunSfxDictionary[param1.id];
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
      
      public static function newname_2440__END(param1:String) : ClientObject
      {
         if(newname_5978__END[param1] == null)
         {
            newname_5978__END[param1] = newname_5979__END(param1);
         }
         return newname_5978__END[param1];
      }
      
      public static function newname_2438__END(param1:ClientObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(shaftShootSfxDictionary != null)
         {
            if(shaftShootSfxDictionary[param1.id] != null)
            {
               shaftShootSfxDictionary[param1.id].objectUnloaded(param1);
               delete shaftShootSfxDictionary[param1.id];
            }
         }
         if(thunderShootSfxDictionary != null)
         {
            if(thunderShootSfxDictionary[param1.id] != null)
            {
               thunderShootSfxDictionary[param1.id].objectUnloaded(param1);
               delete thunderShootSfxDictionary[param1.id];
            }
         }
         if(ricochetSfxDictionary != null)
         {
            if(ricochetSfxDictionary[param1.id] != null)
            {
               ricochetSfxDictionary[param1.id].objectUnloaded(param1);
               delete ricochetSfxDictionary[param1.id];
            }
         }
         if(freezeSfxDictionary != null)
         {
            if(freezeSfxDictionary[param1.id] != null)
            {
               freezeSfxDictionary[param1.id].objectUnloaded(param1);
               delete freezeSfxDictionary[param1.id];
            }
         }
         if(isisSfxDictionary != null)
         {
            if(isisSfxDictionary[param1.id] != null)
            {
               isisSfxDictionary[param1.id].objectUnloaded(param1);
               delete isisSfxDictionary[param1.id];
            }
         }
         if(twinsShootSfxDictionary != null)
         {
            if(twinsShootSfxDictionary[param1.id] != null)
            {
               twinsShootSfxDictionary[param1.id].objectUnloaded(param1);
               delete twinsShootSfxDictionary[param1.id];
            }
         }
         if(flameThrowingSfxDictionary != null)
         {
            if(flameThrowingSfxDictionary[param1.id] != null)
            {
               flameThrowingSfxDictionary[param1.id].objectUnloaded(param1);
               delete flameThrowingSfxDictionary[param1.id];
            }
         }
         if(smokyShootSfxDictionary != null)
         {
            if(smokyShootSfxDictionary[param1.id] != null)
            {
               smokyShootSfxDictionary[param1.id].objectUnloaded(param1);
               delete smokyShootSfxDictionary[param1.id];
            }
         }
         if(railgunSfxDictionary != null)
         {
            if(railgunSfxDictionary[param1.id] != null)
            {
               railgunSfxDictionary[param1.id].objectUnloaded(param1);
               delete railgunSfxDictionary[param1.id];
            }
         }
         if(shotgunSfxDictionary != null)
         {
            if(shotgunSfxDictionary[param1.id] != null)
            {
               shotgunSfxDictionary[param1.id].objectUnloaded(param1);
               delete shotgunSfxDictionary[param1.id];
            }
         }
         if(machineGunSfxDictionary != null)
         {
            if(machineGunSfxDictionary[param1.id] != null)
            {
               machineGunSfxDictionary[param1.id].objectUnloaded(param1);
               delete machineGunSfxDictionary[param1.id];
            }
         }
         if(artillerySfxDictionary != null)
         {
            if(artillerySfxDictionary[param1.id] != null)
            {
               artillerySfxDictionary[param1.id].objectUnloaded(param1);
               delete artillerySfxDictionary[param1.id];
            }
         }
      }
      
      private static function newname_5979__END(param1:String) : ClientObject
      {
         return new ClientObject(param1);
      }
      
      public static function destroy() : void
      {
         isisSfxDictionary = null;
         twinsShootSfxDictionary = null;
         flameThrowingSfxDictionary = null;
         smokyShootSfxDictionary = null;
         railgunSfxDictionary = null;
         thunderShootSfxDictionary = null;
         ricochetSfxDictionary = null;
         freezeSfxDictionary = null;
         shaftShootSfxDictionary = null;
         shotgunSfxDictionary = null;
         artillerySfxDictionary = null;
      }
   }
}

