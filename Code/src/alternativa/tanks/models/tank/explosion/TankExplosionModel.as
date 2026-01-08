package alternativa.tanks.models.tank.explosion
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.AnimatedPlaneEffect;
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
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.armor.explosion.ITankExplosionModelBase;
   import projects.tanks.client.battlefield.models.tankparts.armor.explosion.TankExplosionModelBase;
   
   [ModelInfo]
   public class TankExplosionModel extends TankExplosionModelBase implements ITankExplosionModelBase, ObjectLoadListener, ObjectUnloadListener, ITankExplosionModel
   {
      
      [Inject]
      public static var materialRegistry:EffectsMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const EXPLOSION_SIZE:Number = 800;
      
      private static const SMOKE_SIZE:Number = 400;
      
      private static const SHOCKWAVE_SIZE:Number = 1000;
      
      private static const BASE_DIAGONAL:Number = 600;
      
      private static const MIN_SMOKE_SPEED:Number = 800;
      
      private static const SMOKE_SPEED_DELTA:Number = 200;
      
      private static const SMOKE_ACCELERATION:Number = -2000;
      
      private static const EXPLOSION_FIRE_OFFSET_TO_CAMERA:int = 200;
      
      private static const EXPLOSION_SOUND_VOLUME:Number = 0.4;
      
      private const rayHit:RayHit = new RayHit();
      
      private const position:Vector3 = new Vector3();
      
      private const eulerAngles:Vector3 = new Vector3();
      
      private const velocity:Vector3 = new Vector3();
      
      private const matrix:Matrix3 = new Matrix3();
      
      public function TankExplosionModel()
      {
         super();
      }
      
      private static function getEffectScale(param1:Tank) : Number
      {
         var _loc2_:Mesh = param1.getSkin().getHullMesh();
         var _loc3_:Number = _loc2_.boundMaxX - _loc2_.boundMinX;
         var _loc4_:Number = _loc2_.boundMaxY - _loc2_.boundMinY;
         var _loc5_:Number = _loc2_.boundMaxZ - _loc2_.boundMinZ;
         var _loc6_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_ + _loc5_ * _loc5_);
         return _loc6_ / BASE_DIAGONAL;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:TextureAnimation = this.getTextureAnimation(getInitParam().explosionTexture,EXPLOSION_SIZE);
         var _loc2_:TextureAnimation = this.getTextureAnimation(getInitParam().shockWaveTexture,SHOCKWAVE_SIZE);
         var _loc3_:TextureAnimation = this.getTextureAnimation(getInitParam().smokeTextureId,SMOKE_SIZE);
         var _loc4_:ExplosionData = new ExplosionData(_loc1_,_loc2_,_loc3_);
         putData(ExplosionData,_loc4_);
      }
      
      private function getTextureAnimation(param1:MultiframeImageResource, param2:Number) : TextureAnimation
      {
         var _loc3_:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
         _loc3_.material.resolution = param2 / param1.frameWidth;
         return _loc3_;
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         this.releaseMaterials(ExplosionData(getData(ExplosionData)));
      }
      
      public function createExplosionEffects(param1:IGameObject, param2:Tank, param3:LightAnimation) : void
      {
         var _loc4_:ExplosionData = ExplosionData(getData(ExplosionData));
         var _loc5_:ObjectPool = battleService.getObjectPool();
         var _loc6_:Number = getEffectScale(param2);
         this.createExplosionShockWave(param2,_loc5_,_loc6_,_loc4_);
         this.createExplosionFire(_loc5_,_loc6_,_loc4_);
         this.createExplosionSmoke(_loc5_,_loc6_,_loc4_);
         this.createExplosionLighting(_loc5_,param3);
         this.createExplosionSound(param2);
      }
      
      private function createExplosionSound(param1:Tank) : void
      {
         var _loc3_:Sound3D = null;
         var _loc4_:Object3D = null;
         var _loc2_:Sound = battleService.getTankExplosionSound();
         if(_loc2_ != null)
         {
            _loc3_ = Sound3D.create(_loc2_,EXPLOSION_SOUND_VOLUME);
            _loc4_ = param1.getSkin().getTurret3D();
            battleService.addSound3DEffect(Sound3DEffect.create(new Vector3(_loc4_.x,_loc4_.y,_loc4_.z),_loc3_,0,0));
         }
      }
      
      private function createExplosionLighting(param1:ObjectPool, param2:LightAnimation) : void
      {
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(param1.getObject(StaticObject3DPositionProvider));
         var _loc4_:AnimatedLightEffect = AnimatedLightEffect(param1.getObject(AnimatedLightEffect));
         _loc3_.init(this.position,0);
         _loc4_.init(_loc3_,param2);
         battleService.addGraphicEffect(_loc4_);
      }
      
      private function releaseMaterials(param1:ExplosionData) : void
      {
         materialRegistry.releaseMaterial(param1.flameAnimation.material);
         materialRegistry.releaseMaterial(param1.shockWaveAnimation.material);
         materialRegistry.releaseMaterial(param1.smokeAnimation.material);
      }
      
      private function createExplosionShockWave(param1:Tank, param2:ObjectPool, param3:Number, param4:ExplosionData) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Vector3 = null;
         var _loc10_:Number = NaN;
         var _loc11_:Vector3 = null;
         var _loc12_:AnimatedPlaneEffect = null;
         var _loc5_:Vector3 = new Vector3(0,0,-1);
         var _loc6_:Number = 500;
         this.position.copy(param1.getBody().state.position);
         if(battleService.getBattleRunner().getCollisionDetector().raycastStatic(this.position,_loc5_,255,_loc6_,null,this.rayHit))
         {
            this.rayHit.position.z += 10;
            _loc7_ = SHOCKWAVE_SIZE;
            _loc8_ = 200;
            if(this.rayHit.t > _loc8_)
            {
               _loc7_ *= (_loc6_ - this.rayHit.t) / (_loc6_ - _loc8_);
            }
            _loc9_ = this.rayHit.normal;
            _loc10_ = Math.acos(_loc9_.z);
            _loc11_ = new Vector3(-_loc9_.y,_loc9_.x,0);
            _loc11_.normalize();
            this.matrix.fromAxisAngle(_loc11_,_loc10_);
            this.matrix.getEulerAngles(this.eulerAngles);
            _loc12_ = AnimatedPlaneEffect(param2.getObject(AnimatedPlaneEffect));
            _loc12_.init(param3 * _loc7_,this.rayHit.position,this.eulerAngles,param4.shockWaveAnimation,1);
            battleService.getBattleScene3D().addGraphicEffect(_loc12_);
         }
      }
      
      private function createExplosionFire(param1:ObjectPool, param2:Number, param3:ExplosionData) : void
      {
         this.position.z += 50;
         var _loc4_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(param1.getObject(StaticObject3DPositionProvider));
         _loc4_.init(this.position,EXPLOSION_FIRE_OFFSET_TO_CAMERA);
         var _loc5_:AnimatedSpriteEffect = AnimatedSpriteEffect(param1.getObject(AnimatedSpriteEffect));
         var _loc6_:Number = EXPLOSION_SIZE * param2;
         _loc5_.init(_loc6_,_loc6_,param3.flameAnimation,Math.random() * 2 * Math.PI,_loc4_);
         battleService.getBattleScene3D().addGraphicEffect(_loc5_);
      }
      
      private function createExplosionSmoke(param1:ObjectPool, param2:Number, param3:ExplosionData) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:MovingObject3DPositionProvider = null;
         var _loc7_:AnimatedSpriteEffect = null;
         var _loc8_:Number = NaN;
         var _loc4_:int = 0;
         while(_loc4_ < 3)
         {
            _loc5_ = MIN_SMOKE_SPEED + Math.random() * SMOKE_SPEED_DELTA;
            this.velocity.x = _loc5_ * (1 - 2 * Math.random());
            this.velocity.y = _loc5_ * (1 - 2 * Math.random());
            this.velocity.z = _loc5_ * 0.5 * (1 + Math.random());
            _loc6_ = MovingObject3DPositionProvider(param1.getObject(MovingObject3DPositionProvider));
            _loc6_.init(this.position,this.velocity,SMOKE_ACCELERATION);
            _loc7_ = AnimatedSpriteEffect(param1.getObject(AnimatedSpriteEffect));
            _loc8_ = SMOKE_SIZE * param2;
            _loc7_.init(_loc8_,_loc8_,param3.smokeAnimation,Math.random() * 2 * Math.PI,_loc6_);
            battleService.getBattleScene3D().addGraphicEffect(_loc7_);
            _loc4_++;
         }
      }
   }
}

