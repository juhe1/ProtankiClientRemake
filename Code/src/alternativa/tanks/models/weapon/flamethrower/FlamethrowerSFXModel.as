package alternativa.tanks.models.weapon.flamethrower
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.sfx.colortransform.ColorTransformConsumer;
   import alternativa.tanks.models.sfx.colortransform.ColorTransformEntry;
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
   import alternativa.tanks.models.weapon.streamweapon.StreamWeaponSFXData;
   import alternativa.tanks.utils.GraphicsUtils;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.firebird.FlameThrowingSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.firebird.FlameThrowingSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.firebird.IFlameThrowingSFXModelBase;
   
   [ModelInfo]
   public class FlamethrowerSFXModel extends FlameThrowingSFXModelBase implements IFlameThrowingSFXModelBase, ObjectLoadListener, ObjectUnloadListener, IFlamethrowerSFXModel, ColorTransformConsumer
   {
      
      [Inject] // added
      public static var materialRegistry:EffectsMaterialRegistry;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      public function FlamethrowerSFXModel()
      {
         super();
      }
      
      private static function getParticleAnimation(param1:MultiframeImageResource) : TextureAnimation
      {
         var _loc2_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc2_.material.resolution = FlamethrowerEffectsParams.PARTICLE_END_SIZE / param1.frameWidth;
         return _loc2_;
      }
      
      private static function getMuzzlePlaneAnimation(param1:MultiframeImageResource) : TextureAnimation
      {
         var _loc2_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc2_.material.resolution = FlamethrowerEffectsParams.PLANE_LENGTH / param1.frameWidth;
         return _loc2_;
      }
      
      public function initColorTransform(param1:Vector.<ColorTransformEntry>) : void
      {
         var _loc2_:StreamWeaponSFXData = StreamWeaponSFXData(getData(StreamWeaponSFXData));
         _loc2_.particleColorTransformPoints = param1;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:FlameThrowingSFXCC = getInitParam();
         var _loc2_:StreamWeaponSFXData = new StreamWeaponSFXData();
         _loc2_.particleAnimation = getParticleAnimation(_loc1_.fireTexture);
         _loc2_.muzzlePlaneAnimation = getMuzzlePlaneAnimation(_loc1_.muzzlePlaneTexture);
         _loc2_.shootingSound = _loc1_.flameSound.sound;
         _loc2_.particleSpeed = FlamethrowerEffectsParams.PARTICLE_SPEED;
         var _loc3_:LightingSfx = new LightingSfx(_loc1_.lightingSFXEntity);
         _loc2_.startLightAnimation = _loc3_.createAnimation("start");
         _loc2_.loopLightAnimation = _loc3_.createAnimation("loop");
         _loc2_.startFireAnimation = _loc3_.createAnimation("startFire");
         _loc2_.loopFireAnimation = _loc3_.createAnimation("loopFire");
         putData(StreamWeaponSFXData,_loc2_);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:StreamWeaponSFXData = StreamWeaponSFXData(getData(StreamWeaponSFXData));
         materialRegistry.releaseMaterial(_loc1_.particleAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.muzzlePlaneAnimation.material);
      }
      
      public function getFlamethrowerEffects(param1:Number, param2:Number) : StreamWeaponEffects
      {
         var _loc3_:StreamWeaponSFXData = StreamWeaponSFXData(getData(StreamWeaponSFXData));
         return new FlamethrowerEffects(battleService.getObjectPool(),param1,param2,_loc3_);
      }
   }
}

