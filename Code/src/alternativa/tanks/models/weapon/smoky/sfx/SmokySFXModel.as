package alternativa.tanks.models.weapon.smoky.sfx
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import alternativa.tanks.models.weapon.smoky.ISmokyEffects;
   import alternativa.tanks.models.weapon.smoky.SmokyEffectsParams;
   import alternativa.tanks.utils.GraphicsUtils;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.MultiframeTextureResource;
   import platform.client.fp10.core.resource.types.TextureResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky.ISmokyShootSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky.SmokyShootSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky.SmokyShootSFXModelBase;
   
   [ModelInfo]
   public class SmokySFXModel extends SmokyShootSFXModelBase implements ISmokyShootSFXModelBase, ISmokySFXModel, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject]
      public static var materialRegistry:EffectsMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      public function SmokySFXModel()
      {
         super();
      }
      
      private static function getMuzzleFlashMaterial(param1:TextureResource) : TextureMaterial
      {
         var _loc2_:TextureMaterial = materialRegistry.getMaterial(param1.data);
         _loc2_.resolution = SmokyEffectsParams.PLANE_WIDTH / param1.data.height;
         return _loc2_;
      }
      
      private static function createAnimation(param1:MultiframeTextureResource, param2:int) : TextureAnimation
      {
         var _loc3_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc3_.material.resolution = param2 / param1.frameWidth;
         return _loc3_;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:SmokyShootSFXCC = getInitParam();
         var _loc2_:SmokySFXData = new SmokySFXData();
         _loc2_.muzzleFlashMaterial = getMuzzleFlashMaterial(_loc1_.shotTexture);
         _loc2_.explosionAnimation = createAnimation(_loc1_.explosionTexture,_loc1_.explosionSize);
         _loc2_.explosionMarkMaterial = materialRegistry.getMaterial(_loc1_.explosionMarkTexture.data);
         _loc2_.criticalHitAnimation = createAnimation(_loc1_.criticalHitTexture,_loc1_.criticalHitSize);
         _loc2_.criticalHitSize = _loc1_.criticalHitSize;
         _loc2_.shotSound = _loc1_.shotSound.sound;
         _loc2_.explosionSound = _loc1_.explosionSound.sound;
         _loc2_.explosionSize = _loc1_.explosionSize;
         var _loc3_:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
         _loc2_.shotLightAnimation = _loc3_.createAnimation("shot");
         _loc2_.hitLightAnimation = _loc3_.createAnimation("hit");
         putData(SmokySFXData,_loc2_);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:SmokySFXData = SmokySFXData(getData(SmokySFXData));
         materialRegistry.releaseMaterial(_loc1_.muzzleFlashMaterial);
         materialRegistry.releaseMaterial(_loc1_.explosionAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.explosionMarkMaterial);
         materialRegistry.releaseMaterial(_loc1_.criticalHitAnimation.material);
      }
      
      public function getEffects() : ISmokyEffects
      {
         var _loc1_:SmokySFXData = SmokySFXData(getData(SmokySFXData));
         return new SmokyEffects(battleService.getBattleRunner().getSoundManager(),battleService.getObjectPool(),_loc1_);
      }
   }
}

