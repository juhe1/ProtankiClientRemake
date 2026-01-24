package alternativa.tanks.models.weapon.flamethrower
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.BattleService;
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
   import alternativa.tanks.sfx.StreamWeaponParticlesPositionProvider;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   
   public class FlamethrowerEffects extends BattleRunnerProvider implements StreamWeaponEffects, ISoundEffectDestructionListener
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private const MUZZLE_SHIFT:Number = 100;
      
      private var objectPool:ObjectPool;
      
      private var range:Number;
      
      private var coneAngle:Number;
      
      private var sfxData:StreamWeaponSFXData;
      
      private var graphicEffect:StreamWeaponGraphicEffect;
      
      private var soundEffect:MobileSound3DEffect;
      
      private var muzzleLightEffect:OmniStreamLightEffect;
      
      private var lightEffect:OmniStreamLightEffect;
      
      public function FlamethrowerEffects(param1:ObjectPool, param2:Number, param3:Number, param4:StreamWeaponSFXData)
      {
         super();
         this.objectPool = param1;
         this.range = param2;
         this.coneAngle = param3;
         this.sfxData = param4;
      }
      
      public function startEffects(param1:Body, param2:Vector3, param3:Object3D) : void
      {
         var _loc4_:Sound3D = null;
         var _loc5_:MuzzlePositionProvider = null;
         var _loc6_:Vector3 = null;
         var _loc7_:MuzzlePositionProvider = null;
         var _loc8_:CollisionObject3DPositionProvider = null;
         var _loc9_:StreamWeaponParticlesPositionProvider = null;
         if(this.graphicEffect == null)
         {
            this.graphicEffect = StreamWeaponGraphicEffect(this.objectPool.getObject(StreamWeaponGraphicEffect));
            this.graphicEffect.init(param1,this.range,this.coneAngle,FlamethrowerEffectsParams.PARTICLE_SPEED,param2,param3,this.sfxData,getBattleRunner().getCollisionDetector(),FlamethrowerEffectsParams.PLANE_WIDTH,FlamethrowerEffectsParams.PLANE_LENGTH,FlamethrowerEffectsParams.PARTICLE_START_SIZE,FlamethrowerEffectsParams.PARTICLE_END_SIZE,FlamethrowerEffectsParams.FLAME_MUZZLE_OFFSET,FlamethrowerEffectsParams.FLAME_MUZZLE_RANDOM_OFFSET);
            battleService.getBattleScene3D().addGraphicEffect(this.graphicEffect);
            _loc4_ = Sound3D.create(this.sfxData.shootingSound,FlamethrowerEffectsParams.SOUND_VOLUME);
            this.soundEffect = MobileSound3DEffect(this.objectPool.getObject(MobileSound3DEffect));
            this.soundEffect.shortInit(_loc4_,param3,this);
            getBattleRunner().getSoundManager().addEffect(this.soundEffect);
            this.muzzleLightEffect = OmniStreamLightEffect(this.objectPool.getObject(OmniStreamLightEffect));
            _loc5_ = MuzzlePositionProvider(this.objectPool.getObject(MuzzlePositionProvider));
            _loc6_ = new Vector3();
            _loc6_.copy(param2);
            _loc6_.z += this.MUZZLE_SHIFT;
            _loc5_.init(param3,param2);
            _loc5_.init(param3,param2,0);
            _loc7_ = MuzzlePositionProvider(this.objectPool.getObject(MuzzlePositionProvider));
            _loc7_.init(param3,_loc6_);
            _loc7_.init(param3,_loc6_,0);
            this.muzzleLightEffect.init(_loc7_,this.sfxData.startLightAnimation,this.sfxData.loopLightAnimation);
            battleService.getBattleScene3D().addGraphicEffect(this.muzzleLightEffect);
            this.lightEffect = OmniStreamLightEffect(this.objectPool.getObject(OmniStreamLightEffect));
            _loc8_ = CollisionObject3DPositionProvider(this.objectPool.getObject(CollisionObject3DPositionProvider));
            _loc8_.init(param3,param2,getBattleRunner().getCollisionDetector(),FlamethrowerEffectsParams.FIRE_LIGHT_OFFSET);
            _loc9_ = StreamWeaponParticlesPositionProvider(this.objectPool.getObject(StreamWeaponParticlesPositionProvider));
            _loc9_.init(this.graphicEffect,_loc8_);
            this.lightEffect.init(_loc9_,this.sfxData.startFireAnimation,this.sfxData.loopFireAnimation);
            battleService.getBattleScene3D().addGraphicEffect(this.lightEffect);
         }
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

