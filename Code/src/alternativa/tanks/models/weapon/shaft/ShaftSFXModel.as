package alternativa.tanks.models.weapon.shaft
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import alternativa.tanks.models.weapon.shaft.sfx.TrailEffect1;
   import alternativa.tanks.utils.GraphicsUtils;
   import flash.display.BitmapData;
   import flash.media.Sound;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft.IShaftShootSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft.ShaftShootSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft.ShaftShootSFXModelBase;
   
   [ModelInfo]
   public class ShaftSFXModel extends ShaftShootSFXModelBase implements IShaftShootSFXModelBase, IShaftSFXModel, ObjectLoadPostListener, ObjectUnloadListener
   {
      
      [Inject]
      public static var materialRegistry:EffectsMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      public function ShaftSFXModel()
      {
         super();
      }
      
      private static function getTextureAnimation(param1:MultiframeImageResource, param2:Number) : TextureAnimation
      {
         var _loc3_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc3_.material.resolution = param2 / param1.frameWidth;
         return _loc3_;
      }
      
      private static function getTrailMaterial(param1:BitmapData) : TextureMaterial
      {
         var _loc2_:TextureMaterial = materialRegistry.getMaterial(param1);
         _loc2_.resolution = TrailEffect1.WIDTH / param1.width;
         return _loc2_;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:ShaftShootSFXCC = getInitParam();
         var _loc2_:Sound = _loc1_.targetingSound.sound;
         var _loc3_:Sound = _loc1_.zoomModeSound.sound;
         var _loc4_:Sound = _loc1_.shotSound.sound;
         var _loc5_:Sound = _loc1_.explosionSound.sound;
         var _loc6_:TextureAnimation = getTextureAnimation(_loc1_.muzzleFlashTexture,ShaftEffects.MUZZLE_FLASH_SIZE);
         var _loc7_:TextureAnimation = getTextureAnimation(_loc1_.explosionTexture,ShaftEffects.EXPLOSION_WIDTH);
         var _loc8_:TextureMaterial = getTrailMaterial(_loc1_.trailTexture.data);
         var _loc9_:TextureMaterial = materialRegistry.getMaterial(_loc1_.hitMarkTexture.data);
         var _loc10_:Number = 500;
         var _loc11_:ShaftSFXData = new ShaftSFXData(_loc4_,_loc5_,_loc3_,_loc2_,_loc6_,_loc8_,_loc7_,_loc9_,_loc10_);
         var _loc12_:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
         _loc11_.shotLightAnimation = _loc12_.createAnimation("shot");
         _loc11_.hitLightAnimation = _loc12_.createAnimation("hit");
         putData(ShaftSFXData,_loc11_);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:ShaftSFXData = ShaftSFXData(getData(ShaftSFXData));
         materialRegistry.releaseMaterial(_loc1_.trailMaterial);
         materialRegistry.releaseMaterial(_loc1_.muzzleFlashAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.explosionAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.hitMarkMaterial);
      }
      
      public function getEffects() : ShaftEffects
      {
         var _loc1_:ShaftSFXData = ShaftSFXData(getData(ShaftSFXData));
         return new ShaftEffects(_loc1_,battleService);
      }
   }
}

