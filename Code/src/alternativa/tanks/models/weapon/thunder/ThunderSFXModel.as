package alternativa.tanks.models.weapon.thunder
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import alternativa.tanks.utils.GraphicsUtils;
   import flash.display.BitmapData;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.MultiframeTextureResource;
   import platform.client.fp10.core.resource.types.TextureResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.IThunderShootSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.ThunderShootSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.ThunderShootSFXModelBase;
   
   [ModelInfo]
   public class ThunderSFXModel extends ThunderShootSFXModelBase implements IThunderShootSFXModelBase, IThunderSFXModel, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject]
      public static var materialRegistry:EffectsMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      public function ThunderSFXModel()
      {
         super();
      }
      
      private static function getMuzzleFlashMaterial(param1:TextureResource) : TextureMaterial
      {
         var _loc2_:BitmapData = param1.data;
         var _loc3_:TextureMaterial = materialRegistry.getMaterial(_loc2_);
         _loc3_.resolution = ThunderShotEffect.SPRITE_SIZE_1 / _loc2_.height;
         return _loc3_;
      }
      
      private static function getExplosionAnimation(param1:MultiframeTextureResource, param2:Number) : TextureAnimation
      {
         var _loc3_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc3_.material.resolution = param2 / param1.frameWidth;
         return _loc3_;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:ThunderShootSFXCC = getInitParam();
         var _loc2_:ThunderSFXData = new ThunderSFXData();
         _loc2_.muzzleFlashMaterial = getMuzzleFlashMaterial(_loc1_.shotTexture);
         _loc2_.explosionAnimation = getExplosionAnimation(_loc1_.explosionTexture,_loc1_.explosionSize);
         _loc2_.explosionSize = _loc1_.explosionSize;
         _loc2_.shotSound = _loc1_.shotSound.sound;
         _loc2_.explosionSound = _loc1_.explosionSound.sound;
         _loc2_.explosionMarkMaterial = materialRegistry.getMaterial(_loc1_.explosionMarkTexture.data);
         var _loc3_:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
         _loc2_.shotLightAnimation = _loc3_.createAnimation("shot");
         _loc2_.hitLightAnimation = _loc3_.createAnimation("hit");
         putData(ThunderSFXData,_loc2_);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:ThunderSFXData = ThunderSFXData(getData(ThunderSFXData));
         materialRegistry.releaseMaterial(_loc1_.muzzleFlashMaterial);
         materialRegistry.releaseMaterial(_loc1_.explosionAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.explosionMarkMaterial);
      }
      
      public function getEffects() : IThunderEffects
      {
         return new ThunderEffects(battleService,ThunderSFXData(getData(ThunderSFXData)));
      }
   }
}

