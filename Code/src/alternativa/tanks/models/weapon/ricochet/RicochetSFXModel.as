package alternativa.tanks.models.weapon.ricochet
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import alternativa.tanks.utils.GraphicsUtils;
   import flash.display.BitmapData;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet.IRicochetSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet.RicochetSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet.RicochetSFXModelBase;
   
   [ModelInfo]
   public class RicochetSFXModel extends RicochetSFXModelBase implements IRicochetSFXModelBase, ObjectLoadPostListener, ObjectUnloadListener, IRicochetSFXModel
   {
      
      [Inject]
      public static var materialRegistry:EffectsMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      public function RicochetSFXModel()
      {
         super();
      }
      
      private static function getShotAnimation(param1:MultiframeImageResource) : TextureAnimation
      {
         return getTextureAnimation(param1,RicochetShot.SPRITE_SIZE);
      }
      
      private static function getTextureAnimation(param1:MultiframeImageResource, param2:Number) : TextureAnimation
      {
         var _loc3_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc3_.material.resolution = param2 / param1.frameWidth;
         return _loc3_;
      }
      
      private static function getExplosionAnimation(param1:MultiframeImageResource) : TextureAnimation
      {
         return getTextureAnimation(param1,RicochetShot.EXPLOSION_SPRITE_SIZE);
      }
      
      private static function getBumpFlashAnimation(param1:MultiframeImageResource) : TextureAnimation
      {
         return getTextureAnimation(param1,RicochetShot.EXPLOSION_SPRITE_SIZE);
      }
      
      private static function getMuzzleFlashMaterial(param1:ImageResource) : TextureMaterial
      {
         var _loc2_:BitmapData = param1.data;
         var _loc3_:TextureMaterial = materialRegistry.getMaterial(_loc2_);
         _loc3_.resolution = RicochetEffects.MUZZLE_FLASH_SIZE / _loc2_.height;
         return _loc3_;
      }
      
      private static function getTrailMaterial(param1:BitmapData) : TextureMaterial
      {
         var _loc2_:TextureMaterial = materialRegistry.getMaterial(param1);
         _loc2_.resolution = RicochetShot.TRAIL_WIDTH / param1.height;
         return _loc2_;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:RicochetSFXCC = getInitParam();
         var _loc2_:RicochetSFXData = new RicochetSFXData();
         _loc2_.shotAnimation = getShotAnimation(_loc1_.shotTexture);
         _loc2_.explosionAnimation = getExplosionAnimation(_loc1_.explosionTexture);
         _loc2_.ricochetFlashAnimation = getBumpFlashAnimation(_loc1_.bumpFlashTexture);
         _loc2_.muzzleFlashMaterial = getMuzzleFlashMaterial(_loc1_.shotFlashTexture);
         _loc2_.tailTrailMaterial = getTrailMaterial(_loc1_.tailTrailTexutre.data);
         _loc2_.shotSound = _loc1_.shotSound.sound;
         _loc2_.ricochetSound = _loc1_.ricochetSound.sound;
         _loc2_.explosionSound = _loc1_.explostinSound.sound;
         var _loc3_:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
         _loc2_.shotLightAnimation = _loc3_.createAnimation("shot");
         _loc2_.ricochetLightAnimation = _loc3_.createAnimation("ricochet");
         _loc2_.hitLightAnimation = _loc3_.createAnimation("hit");
         _loc2_.shellLightAnimation = _loc3_.createAnimation("bullet");
         putData(RicochetSFXData,_loc2_);
         putData(RicochetEffects,new RicochetEffects(battleService,_loc2_));
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:RicochetSFXData = this.getSfxData();
         materialRegistry.releaseMaterial(_loc1_.explosionAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.ricochetFlashAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.shotAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.muzzleFlashMaterial);
         materialRegistry.releaseMaterial(_loc1_.tailTrailMaterial);
      }
      
      public function getSfxData() : RicochetSFXData
      {
         return RicochetSFXData(getData(RicochetSFXData));
      }
      
      public function getRicochetEffects() : RicochetEffects
      {
         return RicochetEffects(getData(RicochetEffects));
      }
   }
}

