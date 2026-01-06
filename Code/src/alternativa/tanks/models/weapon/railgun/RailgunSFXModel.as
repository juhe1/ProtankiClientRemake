package alternativa.tanks.models.weapon.railgun
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
   import platform.client.fp10.core.resource.types.MultiframeTextureResource;
   import platform.client.fp10.core.resource.types.TextureResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun.IRailgunShootSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun.RailgunShootSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun.RailgunShootSFXModelBase;
   
   [ModelInfo]
   public class RailgunSFXModel extends RailgunShootSFXModelBase implements IRailgunShootSFXModelBase, IRailgunSFXModel, ObjectLoadPostListener, ObjectUnloadListener
   {
      
      [Inject]
      public static var materialRegistry:EffectsMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      private const chargingTextureRegistry:ChargingTextureRegistry = new ChargingTextureRegistry();
      
      public function RailgunSFXModel()
      {
         super();
      }
      
      private static function getTextureAnimation(param1:MultiframeTextureResource, param2:Number) : TextureAnimation
      {
         var _loc3_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc3_.material.resolution = param2 / param1.frameWidth;
         return _loc3_;
      }
      
      private static function getTrailMaterial(param1:BitmapData) : TextureMaterial
      {
         var _loc2_:TextureMaterial = materialRegistry.getMaterial(param1);
         _loc2_.repeat = true;
         _loc2_.mipMapping = 0;
         return _loc2_;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:RailgunShootSFXCC = getInitParam();
         var _loc2_:RailgunSFXData = new RailgunSFXData();
         _loc2_.trailMaterial = getTrailMaterial(_loc1_.trailImage.data);
         _loc2_.smokeMaterial = getTrailMaterial(_loc1_.smokeImage.data);
         _loc2_.hitMarkMaterial = materialRegistry.getMaterial(_loc1_.hitMarkTexture.data);
         _loc2_.chargingAnimation = this.getChargingAnimation(_loc1_.chargingPart1,_loc1_.chargingPart2,_loc1_.chargingPart3);
         _loc2_.ringsAnimation = getTextureAnimation(_loc1_.ringsTexture,RailgunEffects.RINGS_SIZE);
         _loc2_.sphereAnimation = getTextureAnimation(_loc1_.sphereTexture,RailgunEffects.SPHERE_SIZE);
         _loc2_.powAnimation = getTextureAnimation(_loc1_.powTexture,RailgunEffects.POW_WIDTH);
         _loc2_.sound = _loc1_.shotSound.sound;
         var _loc3_:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
         _loc2_.chargeLightAnimation = _loc3_.createAnimation("charge");
         _loc2_.shotLightAnimation = _loc3_.createAnimation("shot");
         _loc2_.hitLightAnimation = _loc3_.createAnimation("hit");
         _loc2_.railLightAnimation = _loc3_.createAnimation("rail");
         putData(RailgunSFXData,_loc2_);
      }
      
      private function getChargingAnimation(param1:TextureResource, param2:TextureResource, param3:TextureResource) : TextureAnimation
      {
         var _loc4_:BitmapData = this.chargingTextureRegistry.getTexture(param1,param2,param3);
         var _loc5_:int = _loc4_.height;
         var _loc6_:TextureAnimation = GraphicsUtils.getTextureAnimation(materialRegistry,_loc4_,_loc5_,_loc5_);
         _loc6_.material.resolution = RailgunEffects.CHARGE_EFFECT_SIZE / _loc5_;
         return _loc6_;
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:RailgunSFXData = RailgunSFXData(getData(RailgunSFXData));
         materialRegistry.releaseMaterial(_loc1_.trailMaterial);
         materialRegistry.releaseMaterial(_loc1_.smokeMaterial);
         materialRegistry.releaseMaterial(_loc1_.chargingAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.hitMarkMaterial);
         materialRegistry.releaseMaterial(_loc1_.ringsAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.sphereAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.powAnimation.material);
      }
      
      public function getEffects() : IRailgunEffects
      {
         return new RailgunEffects(RailgunSFXData(getData(RailgunSFXData)),battleService);
      }
   }
}

