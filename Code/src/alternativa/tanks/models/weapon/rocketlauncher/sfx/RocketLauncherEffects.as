package alternativa.tanks.models.weapon.rocketlauncher.sfx
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.AnimatedSpriteEffect;
   import alternativa.tanks.sfx.MobileSound3DEffect;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   
   public class RocketLauncherEffects
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const EXPLOSION_OFFSET_TO_CAMERA:Number = 110;
      
      private static const EXPLOSION_EFFECT_SIZE:int = 700;
      
      private static const DECAL_RADIUS:Number = 250;
      
      private static const projectionOrigin:Vector3 = new Vector3();
      
      private var sfxData:RocketLauncherSfxData;
      
      private var turret:Object3D;
      
      private var aimingEffect:MobileSound3DEffect;
      
      public function RocketLauncherEffects(param1:RocketLauncherSfxData, param2:Object3D)
      {
         super();
         this.sfxData = param1;
         this.turret = param2;
      }
      
      public function playShotEffect(param1:Vector3, param2:int) : void
      {
         var _loc3_:Sound3D = Sound3D.create(this.sfxData.shotSounds[param2 % this.sfxData.shotSounds.length],0.8);
         battleService.addSound3DEffect(Sound3DEffect.create(param1,_loc3_));
      }
      
      public function playExplosionEffect(param1:Vector3, param2:Vector3, param3:int) : void
      {
         var _loc4_:ObjectPool = battleService.getObjectPool();
         var _loc5_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(_loc4_.getObject(StaticObject3DPositionProvider));
         _loc5_.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
         var _loc6_:AnimatedSpriteEffect = AnimatedSpriteEffect(_loc4_.getObject(AnimatedSpriteEffect));
         var _loc7_:Number = -Math.PI / 4 + Math.random() * Math.PI / 2;
         _loc6_.init(EXPLOSION_EFFECT_SIZE,EXPLOSION_EFFECT_SIZE,this.sfxData.explosion,_loc7_,_loc5_);
         battleService.addGraphicEffect(_loc6_);
         this.createHitMark(param1,param2);
         this.createExplosionLightEffect(param1);
         var _loc8_:Sound3D = Sound3D.create(this.sfxData.hitSounds[param3 % this.sfxData.hitSounds.length]);
         battleService.addSound3DEffect(Sound3DEffect.create(param1,_loc8_));
      }
      
      private function createHitMark(param1:Vector3, param2:Vector3) : void
      {
         projectionOrigin.copy(param1).subtract(param2);
         battleService.getBattleScene3D().addDecal(param1,projectionOrigin,DECAL_RADIUS,this.sfxData.explosionMark);
      }
      
      private function createExplosionLightEffect(param1:Vector3) : void
      {
         var _loc2_:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         _loc3_.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
         _loc2_.init(_loc3_,this.sfxData.explosionLightingAnimation);
         battleService.addGraphicEffect(_loc2_);
      }
      
      public function createRocketFlightSoundEffect(param1:Mesh, param2:Vector3) : RocketFlightEffect
      {
         var _loc3_:RocketFlightEffect = RocketFlightEffect(battleService.getObjectPool().getObject(RocketFlightEffect));
         _loc3_.init(param1,param2,this.sfxData.rocketFlightSound,this.sfxData);
         return _loc3_;
      }
      
      public function playAimingSoundEffect() : void
      {
         this.killAimingSoundEffect();
         var _loc1_:Sound3D = Sound3D.create(this.sfxData.aimingSound);
         this.aimingEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
         this.aimingEffect.init(_loc1_,this.turret,0,Sound3D.ETERNAL_LOOP);
         battleService.addSound3DEffect(this.aimingEffect);
      }
      
      public function playTargetLostSoundEffect() : void
      {
         this.killAimingSoundEffect();
         var _loc1_:Sound3D = Sound3D.create(this.sfxData.targetLostSound);
         this.aimingEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
         this.aimingEffect.init(_loc1_,this.turret,0,Sound3D.ETERNAL_LOOP);
         battleService.addSound3DEffect(this.aimingEffect);
      }
      
      public function playAimingCompleteSoundEffect() : void
      {
         var _loc1_:Sound3D = Sound3D.create(this.sfxData.aimingCompleteSound);
         var _loc2_:MobileSound3DEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
         _loc2_.init(_loc1_,this.turret);
         battleService.addSound3DEffect(_loc2_);
      }
      
      public function killAimingSoundEffect() : void
      {
         if(this.aimingEffect != null)
         {
            this.aimingEffect.kill();
            this.aimingEffect = null;
         }
      }
   }
}

