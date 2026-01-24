package alternativa.tanks.models.weapon.smoky.sfx
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.models.weapon.smoky.ISmokyEffects;
   import alternativa.tanks.models.weapon.smoky.SmokyEffectsParams;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.AnimatedSpriteEffect;
   import alternativa.tanks.sfx.MuzzlePositionProvider;
   import alternativa.tanks.sfx.PlaneMuzzleFlashEffect;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.sound.ISoundManager;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   import flash.display.BlendMode;
   
   public class SmokyEffects implements ISmokyEffects
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private var soundManager:ISoundManager;
      
      private var objectPool:ObjectPool;
      
      private var sfxData:SmokySFXData;
      
      public function SmokyEffects(param1:ISoundManager, param2:ObjectPool, param3:SmokySFXData)
      {
         super();
         this.soundManager = param1;
         this.objectPool = param2;
         this.sfxData = param3;
      }
      
      public function createShotEffects(param1:Vector3, param2:Object3D) : void
      {
         this.createShotSoundEffect(param2);
         this.createMuzzleFlashEffect(param1,param2);
         this.createMuzzleFlashLightEffect(param1,param2);
      }
      
      private function createShotSoundEffect(param1:Object3D) : void
      {
         var _loc2_:Sound3D = Sound3D.create(this.sfxData.shotSound,SmokyEffectsParams.SHOT_SOUND_VOLUME);
         this.soundManager.addEffect(Sound3DEffect.create(new Vector3(param1.x,param1.y,param1.z),_loc2_));
      }
      
      private function createMuzzleFlashEffect(param1:Vector3, param2:Object3D) : void
      {
         var _loc3_:PlaneMuzzleFlashEffect = PlaneMuzzleFlashEffect(this.objectPool.getObject(PlaneMuzzleFlashEffect));
         _loc3_.init(param1,param2,this.sfxData.muzzleFlashMaterial,SmokyEffectsParams.SHOT_GRAPHIC_EFFECT_LIFE_TIME,SmokyEffectsParams.PLANE_WIDTH,SmokyEffectsParams.PLANE_LENGTH);
         battleService.getBattleScene3D().addGraphicEffect(_loc3_);
      }
      
      private function createMuzzleFlashLightEffect(param1:Vector3, param2:Object3D) : void
      {
         var _loc3_:AnimatedLightEffect = AnimatedLightEffect(this.objectPool.getObject(AnimatedLightEffect));
         var _loc4_:MuzzlePositionProvider = MuzzlePositionProvider(this.objectPool.getObject(MuzzlePositionProvider));
         _loc4_.init(param2,param1);
         _loc3_.init(_loc4_,this.sfxData.shotLightAnimation);
         battleService.getBattleScene3D().addGraphicEffect(_loc3_);
      }
      
      public function createExplosionEffects(param1:Vector3) : void
      {
         this.createExplosionSoundEffect(param1);
         this.createExplosionGraphicEffect(param1);
         this.createExplosionLightEffect(param1);
      }
      
      private function createExplosionLightEffect(param1:Vector3) : void
      {
         var _loc2_:AnimatedLightEffect = AnimatedLightEffect(this.objectPool.getObject(AnimatedLightEffect));
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.objectPool.getObject(StaticObject3DPositionProvider));
         _loc3_.init(param1,SmokyEffectsParams.EXPLOSION_OFFSET_TO_CAMERA);
         _loc2_.init(_loc3_,this.sfxData.hitLightAnimation);
         battleService.getBattleScene3D().addGraphicEffect(_loc2_);
      }
      
      private function createExplosionSoundEffect(param1:Vector3) : void
      {
         var _loc2_:Sound3D = Sound3D.create(this.sfxData.explosionSound,1);
         this.soundManager.addEffect(Sound3DEffect.create(param1,_loc2_,SmokyEffectsParams.EXPLOSION_SOUND_DELAY));
      }
      
      private function createExplosionGraphicEffect(param1:Vector3) : void
      {
         var _loc2_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.objectPool.getObject(StaticObject3DPositionProvider));
         _loc2_.init(param1,SmokyEffectsParams.EXPLOSION_OFFSET_TO_CAMERA);
         var _loc3_:AnimatedSpriteEffect = AnimatedSpriteEffect(this.objectPool.getObject(AnimatedSpriteEffect));
         _loc3_.init(this.sfxData.explosionSize,this.sfxData.explosionSize,this.sfxData.explosionAnimation,0,_loc2_);
         battleService.getBattleScene3D().addGraphicEffect(_loc3_);
      }
      
      public function createExplosionMark(param1:Vector3, param2:Vector3) : void
      {
         battleService.getBattleScene3D().addDecal(param2,param1,SmokyEffectsParams.DECAL_RADIUS,this.sfxData.explosionMarkMaterial);
      }
      
      public function createCriticalHitEffects(param1:Vector3) : void
      {
         var _loc2_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.objectPool.getObject(StaticObject3DPositionProvider));
         _loc2_.init(param1,SmokyEffectsParams.EXPLOSION_OFFSET_TO_CAMERA + 50);
         var _loc3_:AnimatedSpriteEffect = AnimatedSpriteEffect(this.objectPool.getObject(AnimatedSpriteEffect));
         _loc3_.initLooped(this.sfxData.criticalHitSize,this.sfxData.criticalHitSize,this.sfxData.criticalHitAnimation,0,_loc2_,0.5,0.5,null,70,BlendMode.NORMAL,2);
         battleService.getBattleScene3D().addGraphicEffect(_loc3_);
      }
   }
}

