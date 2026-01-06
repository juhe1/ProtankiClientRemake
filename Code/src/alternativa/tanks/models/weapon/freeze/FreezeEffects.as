package alternativa.tanks.models.weapon.freeze
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
   import alternativa.tanks.models.weapon.streamweapon.StreamWeaponGraphicEffect;
   import alternativa.tanks.models.weapon.streamweapon.StreamWeaponSFXData;
   import alternativa.tanks.sfx.CollisionObject3DPositionProvider;
   import alternativa.tanks.sfx.ISound3DEffect;
   import alternativa.tanks.sfx.ISoundEffectDestructionListener;
   import alternativa.tanks.sfx.MobileSound3DEffect;
   import alternativa.tanks.sfx.MuzzlePositionProvider;
   import alternativa.tanks.sfx.OmniStreamLightEffect;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   
   public class FreezeEffects extends BattleRunnerProvider implements StreamWeaponEffects, ISoundEffectDestructionListener
   {
      
      private var objectPool:ObjectPool;
      
      private var range:Number;
      
      private var coneAngle:Number;
      
      private var sfxData:StreamWeaponSFXData;
      
      private var graphicEffect:StreamWeaponGraphicEffect;
      
      private var soundEffect:MobileSound3DEffect;
      
      private var muzzleLightEffect:OmniStreamLightEffect;
      
      private var lightEffect:OmniStreamLightEffect;
      
      public function FreezeEffects(param1:ObjectPool, param2:Number, param3:Number, param4:StreamWeaponSFXData)
      {
         super();
         this.objectPool = param1;
         this.range = param2;
         this.coneAngle = param3;
         this.sfxData = param4;
      }
      
      public function startEffects(param1:Body, param2:Vector3, param3:Object3D) : void
      {
         if(this.graphicEffect == null)
         {
            this.createGraphicEffect(param1,param2,param3);
            this.createSoundEffect(param3);
            this.createLightEffect(param2,param3);
         }
      }
      
      public function createLightEffect(param1:Vector3, param2:Object3D) : void
      {
         var _loc3_:MuzzlePositionProvider = null;
         var _loc4_:CollisionObject3DPositionProvider = null;
         if(this.muzzleLightEffect == null)
         {
            this.muzzleLightEffect = OmniStreamLightEffect(this.objectPool.getObject(OmniStreamLightEffect));
            _loc3_ = MuzzlePositionProvider(this.objectPool.getObject(MuzzlePositionProvider));
            _loc3_.init(param2,param1);
            this.muzzleLightEffect.init(_loc3_,this.sfxData.startLightAnimation,this.sfxData.loopLightAnimation);
            battleService.getBattleScene3D().addGraphicEffect(this.muzzleLightEffect);
         }
         if(this.lightEffect == null)
         {
            this.lightEffect = OmniStreamLightEffect(this.objectPool.getObject(OmniStreamLightEffect));
            _loc4_ = CollisionObject3DPositionProvider(this.objectPool.getObject(CollisionObject3DPositionProvider));
            _loc4_.init(param2,param1,getBattleRunner().getCollisionDetector(),FreezeEffectsParams.FIRE_LIGHT_OFFSET);
            this.lightEffect.init(_loc4_,this.sfxData.startFireAnimation,this.sfxData.loopFireAnimation);
            battleService.getBattleScene3D().addGraphicEffect(this.lightEffect);
         }
      }
      
      private function createGraphicEffect(param1:Body, param2:Vector3, param3:Object3D) : void
      {
         this.graphicEffect = StreamWeaponGraphicEffect(this.objectPool.getObject(StreamWeaponGraphicEffect));
         this.graphicEffect.init(param1,this.range,this.coneAngle,FreezeEffectsParams.PARTICLE_SPEED,param2,param3,this.sfxData,getBattleRunner().getCollisionDetector(),FreezeEffectsParams.PLANE_WIDTH,FreezeEffectsParams.PLANE_LENGTH,FreezeEffectsParams.PARTICLE_START_SIZE,FreezeEffectsParams.PARTICLE_END_SIZE,FreezeEffectsParams.PARTICLE_MUZZLE_OFFSET,FreezeEffectsParams.PARTICLE_MUZZLE_RANDOM_OFFSET);
         battleService.getBattleScene3D().addGraphicEffect(this.graphicEffect);
      }
      
      private function createSoundEffect(param1:Object3D) : void
      {
         var _loc2_:Sound3D = Sound3D.create(this.sfxData.shootingSound,FreezeEffectsParams.SOUND_VOLUME);
         this.soundEffect = MobileSound3DEffect(this.objectPool.getObject(MobileSound3DEffect));
         this.soundEffect.shortInit(_loc2_,param1,this);
         getBattleRunner().getSoundManager().addEffect(this.soundEffect);
      }
      
      public function stopEffects() : void
      {
         if(this.graphicEffect != null)
         {
            this.graphicEffect.kill();
            this.graphicEffect = null;
            this.killSound();
            this.muzzleLightEffect.stop();
            this.muzzleLightEffect = null;
            this.lightEffect.stop();
            this.lightEffect = null;
         }
      }
      
      private function killSound() : void
      {
         if(this.soundEffect != null)
         {
            this.soundEffect.kill();
            this.soundEffect = null;
         }
      }
      
      public function onSoundEffectDestroyed(param1:ISound3DEffect) : void
      {
         if(this.soundEffect == param1)
         {
            this.soundEffect = null;
         }
      }
   }
}

