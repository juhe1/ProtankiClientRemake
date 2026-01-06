package alternativa.tanks.models.battle.rugby.explosion
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.AnimatedSpriteEffect;
   import alternativa.tanks.sfx.LightAnimation;
   import alternativa.tanks.sfx.MovingObject3DPositionProvider;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.utils.GraphicsUtils;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   import flash.media.Sound;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.MultiframeTextureResource;
   import projects.tanks.client.battlefield.models.battle.pointbased.rugby.explosion.BallExplosionModelBase;
   import projects.tanks.client.battlefield.models.battle.pointbased.rugby.explosion.IBallExplosionModelBase;
   
   [ModelInfo]
   public class BallExplosionModel extends BallExplosionModelBase implements IBallExplosionModelBase, ObjectLoadListener, ObjectUnloadListener, BallExplosion
   {
      
      [Inject]
      public static var materialRegistry:EffectsMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const EXPLOSION_SIZE:Number = 800;
      
      private static const SMOKE_SIZE:Number = 400;
      
      private static const MIN_SMOKE_SPEED:Number = 800;
      
      private static const SMOKE_SPEED_DELTA:Number = 200;
      
      private static const SMOKE_ACCELERATION:Number = -2000;
      
      private static const EXPLOSION_FIRE_OFFSET_TO_CAMERA:int = 200;
      
      private static const EXPLOSION_SOUND_VOLUME:Number = 0.4;
      
      private static const SCALE:Number = 1;
      
      private const velocity:Vector3 = new Vector3();
      
      private var flameAnimation:TextureAnimation;
      
      private var smokeAnimation:TextureAnimation;
      
      private var lightAnimation:LightAnimation;
      
      private var explosionSound:Sound;
      
      public function BallExplosionModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         this.flameAnimation = this.getTextureAnimation(getInitParam().explosionTexture,EXPLOSION_SIZE);
         this.smokeAnimation = this.getTextureAnimation(getInitParam().smokeTextureId,SMOKE_SIZE);
         var _loc1_:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
         this.lightAnimation = _loc1_.createAnimation("ball_explosion");
         this.explosionSound = getInitParam().explosionSound.sound;
      }
      
      private function getTextureAnimation(param1:MultiframeTextureResource, param2:Number) : TextureAnimation
      {
         var _loc3_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc3_.material.resolution = param2 / param1.frameWidth;
         return _loc3_;
      }
      
      public function objectUnloaded() : void
      {
         this.releaseMaterials();
      }
      
      public function createExplosionEffects(param1:Vector3) : void
      {
         var _loc2_:ObjectPool = battleService.getObjectPool();
         this.createExplosionFire(param1,_loc2_);
         this.createExplosionSmoke(param1,_loc2_);
         this.createExplosionLighting(param1,_loc2_);
         this.createExplosionSound(param1);
      }
      
      private function createExplosionSound(param1:Vector3) : void
      {
         var _loc2_:Sound3D = Sound3D.create(this.explosionSound,EXPLOSION_SOUND_VOLUME);
         battleService.addSound3DEffect(Sound3DEffect.create(param1,_loc2_,0,0));
      }
      
      private function createExplosionLighting(param1:Vector3, param2:ObjectPool) : void
      {
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(param2.getObject(StaticObject3DPositionProvider));
         var _loc4_:AnimatedLightEffect = AnimatedLightEffect(param2.getObject(AnimatedLightEffect));
         _loc3_.init(param1,0);
         _loc4_.init(_loc3_,this.lightAnimation);
         battleService.addGraphicEffect(_loc4_);
      }
      
      private function releaseMaterials() : void
      {
         materialRegistry.releaseMaterial(this.flameAnimation.material);
         materialRegistry.releaseMaterial(this.smokeAnimation.material);
      }
      
      private function createExplosionFire(param1:Vector3, param2:ObjectPool) : void
      {
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(param2.getObject(StaticObject3DPositionProvider));
         _loc3_.init(param1,EXPLOSION_FIRE_OFFSET_TO_CAMERA);
         var _loc4_:AnimatedSpriteEffect = AnimatedSpriteEffect(param2.getObject(AnimatedSpriteEffect));
         var _loc5_:Number = EXPLOSION_SIZE * SCALE;
         _loc4_.init(_loc5_,_loc5_,this.flameAnimation,Math.random() * 2 * Math.PI,_loc3_);
         battleService.getBattleScene3D().addGraphicEffect(_loc4_);
      }
      
      private function createExplosionSmoke(param1:Vector3, param2:ObjectPool) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:MovingObject3DPositionProvider = null;
         var _loc6_:AnimatedSpriteEffect = null;
         var _loc7_:Number = NaN;
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            _loc4_ = MIN_SMOKE_SPEED + Math.random() * SMOKE_SPEED_DELTA;
            this.velocity.x = _loc4_ * (1 - 2 * Math.random());
            this.velocity.y = _loc4_ * (1 - 2 * Math.random());
            this.velocity.z = _loc4_ * 0.5 * (1 + Math.random());
            _loc5_ = MovingObject3DPositionProvider(param2.getObject(MovingObject3DPositionProvider));
            _loc5_.init(param1,this.velocity,SMOKE_ACCELERATION);
            _loc6_ = AnimatedSpriteEffect(param2.getObject(AnimatedSpriteEffect));
            _loc7_ = SMOKE_SIZE * SCALE;
            _loc6_.init(_loc7_,_loc7_,this.smokeAnimation,Math.random() * 2 * Math.PI,_loc5_);
            battleService.getBattleScene3D().addGraphicEffect(_loc6_);
            _loc3_++;
         }
      }
   }
}

