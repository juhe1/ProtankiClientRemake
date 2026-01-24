package alternativa.tanks.models.weapon.twins
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
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins.ITwinsShootSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins.TwinsShootSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins.TwinsShootSFXModelBase;
   
   [ModelInfo]
   public class TwinsSFXModel extends TwinsShootSFXModelBase implements ITwinsShootSFXModelBase, ObjectLoadPostListener, ObjectUnloadListener, ITwinsSFXModel
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var materialRegistry:EffectsMaterialRegistry;
      
      public function TwinsSFXModel()
      {
         super();
      }
      
      private static function getMuzzleFlashMaterial(param1:BitmapData) : TextureMaterial
      {
         var _loc2_:TextureMaterial = materialRegistry.getMaterial(param1);
         _loc2_.resolution = TwinsEffects.FLASH_SIZE / param1.height;
         return _loc2_;
      }
      
      private static function getPlasmaAnimation(param1:MultiframeImageResource) : TextureAnimation
      {
         return getTextureAnimation(param1,TwinsShotParams.SPRITE_SIZE);
      }
      
      private static function getExplosionAnimation(param1:MultiframeImageResource) : TextureAnimation
      {
         return getTextureAnimation(param1,TwinsShotParams.EXPLOSION_SPRITE_SIZE);
      }
      
      private static function getTextureAnimation(param1:MultiframeImageResource, param2:Number) : TextureAnimation
      {
         var _loc3_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc3_.material.resolution = param2 / param1.frameWidth;
         return _loc3_;
      }
      
      private static function releaseMaterials(param1:TwinsSFXData) : void
      {
         materialRegistry.releaseMaterial(param1.muzzleFlashMaterial);
         materialRegistry.releaseMaterial(param1.shotAnimation.material);
         materialRegistry.releaseMaterial(param1.explosionAnimation.material);
         materialRegistry.releaseMaterial(param1.hitMarkMaterial);
      }
      
      public function getPlasmaWeaponEffects() : TwinsEffects
      {
         return TwinsEffects(getData(TwinsEffects));
      }
      
      public function getSFXData() : TwinsSFXData
      {
         return TwinsSFXData(getData(TwinsSFXData));
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:TwinsShootSFXCC = getInitParam();
         var _loc2_:TwinsSFXData = new TwinsSFXData();
         _loc2_.muzzleFlashMaterial = getMuzzleFlashMaterial(_loc1_.muzzleFlashTexture.data);
         _loc2_.shotAnimation = getPlasmaAnimation(_loc1_.shotTexture);
         _loc2_.explosionAnimation = getExplosionAnimation(_loc1_.explosionTexture);
         _loc2_.hitMarkMaterial = materialRegistry.getMaterial(_loc1_.hitMarkTexture.data);
         _loc2_.shotSound = _loc1_.shotSound.sound;
         var _loc3_:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
         _loc2_.shotLightingAnimation = _loc3_.createAnimation("shot");
         _loc2_.shellLightingAnimation = _loc3_.createAnimation("bullet");
         _loc2_.hitLightingAnimation = _loc3_.createAnimation("hit");
         putData(TwinsSFXData,_loc2_);
         putData(TwinsEffects,new TwinsEffects(battleService,_loc2_));
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         releaseMaterials(this.getSFXData());
      }
   }
}

