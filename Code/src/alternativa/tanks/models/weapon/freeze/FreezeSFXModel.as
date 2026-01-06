package alternativa.tanks.models.weapon.freeze
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
   import alternativa.tanks.models.weapon.streamweapon.StreamWeaponSFXData;
   import alternativa.tanks.utils.GraphicsUtils;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.MultiframeTextureResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.freeze.FreezeSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.freeze.FreezeSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.freeze.IFreezeSFXModelBase;
   
   [ModelInfo]
   public class FreezeSFXModel extends FreezeSFXModelBase implements IFreezeSFXModelBase, ObjectLoadListener, ObjectUnloadListener, IFreezeSFXModel
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var materialRegistry:EffectsMaterialRegistry;
      
      public function FreezeSFXModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:FreezeSFXCC = getInitParam();
         var _loc2_:StreamWeaponSFXData = new StreamWeaponSFXData();
         _loc2_.particleAnimation = this.getParticleAnimation(_loc1_.particleTextureResource);
         _loc2_.muzzlePlaneAnimation = this.getMuzzlePlaneAnimation(_loc1_.planeTextureResource);
         _loc2_.particleSpeed = BattleUtils.toClientScale(_loc1_.particleSpeed);
         _loc2_.shootingSound = _loc1_.shotSoundResource.sound;
         var _loc3_:LightingSfx = new LightingSfx(_loc1_.lightingSFXEntity);
         _loc2_.startLightAnimation = _loc3_.createAnimation("start");
         _loc2_.loopLightAnimation = _loc3_.createAnimation("loop");
         _loc2_.startFireAnimation = _loc3_.createAnimation("startFire");
         _loc2_.loopFireAnimation = _loc3_.createAnimation("loopFire");
         putData(StreamWeaponSFXData,_loc2_);
      }
      
      private function getParticleAnimation(param1:MultiframeTextureResource) : TextureAnimation
      {
         var _loc2_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc2_.material.resolution = FreezeEffectsParams.PARTICLE_END_SIZE / param1.frameWidth;
         return _loc2_;
      }
      
      private function getMuzzlePlaneAnimation(param1:MultiframeTextureResource) : TextureAnimation
      {
         var _loc2_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc2_.material.resolution = FreezeEffectsParams.PLANE_LENGTH / param1.frameWidth;
         return _loc2_;
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:StreamWeaponSFXData = StreamWeaponSFXData(getData(StreamWeaponSFXData));
         materialRegistry.releaseMaterial(_loc1_.particleAnimation.material);
         materialRegistry.releaseMaterial(_loc1_.muzzlePlaneAnimation.material);
      }
      
      public function getFreezeEffects(param1:Number, param2:Number) : StreamWeaponEffects
      {
         var _loc3_:StreamWeaponSFXData = StreamWeaponSFXData(getData(StreamWeaponSFXData));
         return new FreezeEffects(battleService.getObjectPool(),param1,param2,_loc3_);
      }
   }
}

