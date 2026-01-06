package alternativa.tanks.models.weapon.shaft
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.models.weapon.shaft.sfx.ShaftTrailEffect;
   import alternativa.tanks.models.weapon.shaft.sfx.TrailEffect1;
   import alternativa.tanks.models.weapon.shaft.sfx.TrailEffect2;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.AnimatedSpriteEffect;
   import alternativa.tanks.sfx.MobileSound3DEffect;
   import alternativa.tanks.sfx.MuzzlePositionProvider;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   import flash.media.SoundChannel;
   
   public class ShaftEffects
   {
      
      public static const MUZZLE_FLASH_SIZE:Number = 200;
      
      public static const EXPLOSION_WIDTH:Number = 200;
      
      private static const EXPLOSION_OFFSET_TO_CAMERA:Number = 110;
      
      private static const SHOT_SOUND_VOLUME:Number = 0.4;
      
      private static const EXPLOSION_SOUND_VOLUME:Number = 0.8;
      
      private static const ZOOM_MODE_SOUND_VOLUME:Number = 0.35;
      
      private static const CHARGING_SOUND_FADE_TIME_MS:int = 1000;
      
      private static const vectorToHitPoint:Vector3 = new Vector3();
      
      private static const TRAIL_DURATION:int = 300;
      
      private var sfxData:ShaftSFXData;
      
      private var battleService:BattleService;
      
      private var turretSoundChannel:SoundChannel;
      
      private var manualModeEffect:MobileSound3DEffect;
      
      public function ShaftEffects(param1:ShaftSFXData, param2:BattleService)
      {
         super();
         this.sfxData = param1;
         this.battleService = param2;
      }
      
      public function playTargetingSound(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.turretSoundChannel == null)
            {
               this.turretSoundChannel = this.battleService.soundManager.playSound(this.sfxData.targetingSound,0,9999);
            }
         }
         else if(this.turretSoundChannel != null)
         {
            this.battleService.soundManager.stopSound(this.turretSoundChannel);
            this.turretSoundChannel = null;
         }
      }
      
      public function createManualModeEffects(param1:Object3D) : void
      {
         var _loc2_:Sound3D = null;
         if(this.manualModeEffect == null)
         {
            this.manualModeEffect = MobileSound3DEffect(this.battleService.getObjectPool().getObject(MobileSound3DEffect));
            _loc2_ = Sound3D.create(this.sfxData.zoomModeSound,ZOOM_MODE_SOUND_VOLUME);
            this.manualModeEffect.init(_loc2_,param1,0,9999);
            this.battleService.addSound3DEffect(this.manualModeEffect);
         }
      }
      
      public function stopManualTargetingEffects() : void
      {
         if(this.manualModeEffect != null)
         {
            this.manualModeEffect.kill();
            this.manualModeEffect = null;
         }
      }
      
      public function fadeChargingEffect() : void
      {
         if(this.manualModeEffect != null)
         {
            this.manualModeEffect.fade(CHARGING_SOUND_FADE_TIME_MS);
         }
      }
      
      public function createShotSoundEffect(param1:Vector3) : void
      {
         var _loc2_:Sound3D = Sound3D.create(this.sfxData.shotSound,SHOT_SOUND_VOLUME);
         var _loc3_:Sound3DEffect = Sound3DEffect.create(param1,_loc2_);
         this.battleService.addSound3DEffect(_loc3_);
      }
      
      public function createMuzzleFlashEffect(param1:Vector3, param2:Object3D) : void
      {
         var _loc3_:ObjectPool = this.battleService.getObjectPool();
         var _loc4_:MuzzlePositionProvider = MuzzlePositionProvider(_loc3_.getObject(MuzzlePositionProvider));
         _loc4_.init(param2,param1,10);
         var _loc5_:AnimatedSpriteEffect = AnimatedSpriteEffect(_loc3_.getObject(AnimatedSpriteEffect));
         _loc5_.init(MUZZLE_FLASH_SIZE,MUZZLE_FLASH_SIZE,this.sfxData.muzzleFlashAnimation,0,_loc4_);
         this.battleService.addGraphicEffect(_loc5_);
         this.createLightMuzzleFlashEffect(param1,param2);
      }
      
      public function createLightMuzzleFlashEffect(param1:Vector3, param2:Object3D) : void
      {
         var _loc3_:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc4_:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
         _loc4_.init(param2,param1);
         _loc3_.init(_loc4_,this.sfxData.shotLightAnimation);
         this.battleService.addGraphicEffect(_loc3_);
      }
      
      public function createHitPointsGraphicEffects(param1:Vector3, param2:Vector3, param3:Vector3, param4:Vector3, param5:Vector3) : void
      {
         if(param1 != null)
         {
            this.createEffectsForPoint(param1,param3,param4,param5,false);
         }
         if(param2 != null)
         {
            this.createEffectsForPoint(param2,param3,param4,param5,true);
         }
      }
      
      private function createEffectsForPoint(param1:Vector3, param2:Vector3, param3:Vector3, param4:Vector3, param5:Boolean) : void
      {
         var _loc7_:Number = NaN;
         var _loc6_:Number = this.sfxData.trailLength;
         vectorToHitPoint.diff(param1,param2);
         if(vectorToHitPoint.dot(param3) > 0)
         {
            _loc7_ = vectorToHitPoint.length();
            if(_loc7_ > _loc6_)
            {
               _loc7_ = _loc6_;
            }
            this.createTrailEffect(TrailEffect1,param1,param4,_loc7_,_loc7_ / _loc6_);
            if(param5)
            {
               this.createTrailEffect(TrailEffect2,param1,param4,_loc7_,0.5);
            }
         }
         this.createExplosionGraphicEffect(param1);
         this.createExplosionSoundEffect(param1);
      }
      
      private function createExplosionGraphicEffect(param1:Vector3) : void
      {
         var _loc2_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         _loc2_.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
         var _loc3_:AnimatedSpriteEffect = AnimatedSpriteEffect(this.battleService.getObjectPool().getObject(AnimatedSpriteEffect));
         _loc3_.init(EXPLOSION_WIDTH,2.5 * EXPLOSION_WIDTH,this.sfxData.explosionAnimation,0,_loc2_);
         this.battleService.addGraphicEffect(_loc3_);
         this.createExplosionLightEffect(param1);
      }
      
      private function createExplosionLightEffect(param1:Vector3) : void
      {
         var _loc2_:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         _loc3_.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
         _loc2_.init(_loc3_,this.sfxData.hitLightAnimation);
         this.battleService.addGraphicEffect(_loc2_);
      }
      
      private function createExplosionSoundEffect(param1:Vector3) : void
      {
         var _loc2_:Sound3D = Sound3D.create(this.sfxData.explosionSound,EXPLOSION_SOUND_VOLUME);
         var _loc3_:Sound3DEffect = Sound3DEffect(this.battleService.getObjectPool().getObject(Sound3DEffect));
         _loc3_.init(param1,_loc2_,100);
         this.battleService.addSound3DEffect(_loc3_);
      }
      
      private function createTrailEffect(param1:Class, param2:Vector3, param3:Vector3, param4:Number, param5:Number) : void
      {
         var _loc6_:ShaftTrailEffect = ShaftTrailEffect(this.battleService.getObjectPool().getObject(param1));
         _loc6_.init(param2,param3,param4,param5,this.sfxData.trailMaterial,TRAIL_DURATION);
         this.battleService.addGraphicEffect(_loc6_);
      }
      
      public function destroy() : void
      {
         if(this.turretSoundChannel != null)
         {
            this.battleService.soundManager.stopSound(this.turretSoundChannel);
            this.turretSoundChannel = null;
         }
         this.stopManualTargetingEffects();
      }
      
      public function createHitMark(param1:Vector3, param2:Vector3) : void
      {
         if(param2 != null)
         {
            this.battleService.getBattleScene3D().addDecal(param2,param1,50,this.sfxData.hitMarkMaterial);
         }
      }
   }
}

