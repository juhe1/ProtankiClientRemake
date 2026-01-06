package alternativa.tanks.models.weapon.twins
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.engine3d.AnimatedSprite3D;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.splash.Splash;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapons.shell.InelasticShell;
   import alternativa.tanks.models.weapons.shell.states.DummyShellStates;
   import alternativa.tanks.models.weapons.shell.states.ShellStates;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.AnimatedSpriteEffect;
   import alternativa.tanks.sfx.DecalEffect;
   import alternativa.tanks.sfx.ExternalObject3DPositionProvider;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.utils.MathUtils;
   import alternativa.tanks.utils.objectpool.Pool;
   import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsCC;
   import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
   
   public class TwinsShot extends InelasticShell
   {
      
      private var weakening:DistanceWeakening;
      
      private var sfxData:TwinsSFXData;
      
      private var callback:TwinsWeaponCallback;
      
      private var twinsInitParams:TwinsCC;
      
      private var impactForce:Number;
      
      private var sprite:AnimatedSprite3D;
      
      private var lightEffect:AnimatedLightEffect;
      
      private var lightEffectPositionProvider:ExternalObject3DPositionProvider;
      
      private var splash:Splash;
      
      public function TwinsShot(param1:Pool)
      {
         super(param1);
         this.sprite = new AnimatedSprite3D(TwinsShotParams.SPRITE_SIZE,TwinsShotParams.SPRITE_SIZE);
         this.sprite.looped = true;
      }
      
      override protected function createShellStates() : ShellStates
      {
         return DummyShellStates.INSTANCE;
      }
      
      public function init(param1:Number, param2:TwinsCC, param3:TwinsSFXData, param4:DistanceWeakening, param5:TwinsWeaponCallback, param6:Splash) : void
      {
         this.impactForce = param1;
         this.twinsInitParams = param2;
         this.weakening = param4;
         this.sfxData = param3;
         this.callback = param5;
         this.splash = param6;
         this.sprite.setAnimationData(param3.shotAnimation);
         this.sprite.setFrameIndex(this.sprite.getNumFrames() * Math.random());
         this.sprite.alpha = 1;
         this.sprite.rotation = MathUtils.PI2 * Math.random();
         this.lightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
         this.lightEffectPositionProvider = ExternalObject3DPositionProvider(battleService.getObjectPool().getObject(ExternalObject3DPositionProvider));
         this.lightEffect.init(this.lightEffectPositionProvider,param3.shellLightingAnimation,AnimatedLightEffect.DEFAULT_MAX_DISTANCE,true);
      }
      
      override public function addToGame(param1:AllGlobalGunParams, param2:Vector3, param3:Body, param4:Boolean, param5:int) : void
      {
         super.addToGame(param1,param2,param3,param4,param5);
         battleService.getBattleScene3D().addObject(this.sprite);
         battleService.addGraphicEffect(this.lightEffect);
      }
      
      override protected function getSpeed() : Number
      {
         return this.twinsInitParams.speed;
      }
      
      override protected function getMaxDistance() : Number
      {
         return this.weakening.getDistance();
      }
      
      override protected function processHitImpl(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:int) : void
      {
         var _loc8_:Tank = null;
         super.processHitImpl(param1,param2,param3,param4,param5);
         var _loc6_:Number = this.weakening.getImpactCoeff(param4);
         this.createExplosionEffect(param2,_loc6_);
         var _loc7_:Boolean = Boolean(this.splash.applySplashForce(param2,_loc6_,param1));
         if(BattleUtils.isTankBody(param1))
         {
            _loc8_ = param1.tank;
            _loc8_.applyWeaponHit(param2,param3,this.impactForce * _loc6_);
            if(Boolean(this.callback))
            {
               this.callback.onTargetHit(getShotId(),param1,param2);
            }
         }
         else
         {
            if(Boolean(this.callback) && _loc7_)
            {
               this.callback.onStaticHit(getShotId(),param2);
            }
            this.createHitMark(param2);
         }
         this.destroy();
      }
      
      override public function render(param1:int, param2:int) : void
      {
         var _loc3_:Number = param2 / thousandth.getInt();
         this.sprite.update(_loc3_);
         this.sprite.x = interpolatedPosition.x;
         this.sprite.y = interpolatedPosition.y;
         this.sprite.z = interpolatedPosition.z;
         this.sprite.rotation -= 3 * _loc3_;
         var _loc4_:Number = this.twinsInitParams.distance - totalDistance;
         if(_loc4_ < TwinsShotParams.ALPHA_FADE_DISTANCE)
         {
            this.sprite.alpha = _loc4_ / TwinsShotParams.ALPHA_FADE_DISTANCE;
         }
         this.lightEffectPositionProvider.setPosition(interpolatedPosition);
      }
      
      override protected function destroy() : void
      {
         super.destroy();
         battleService.getBattleScene3D().removeObject(this.sprite);
         this.twinsInitParams = null;
         this.callback = null;
         shooterBody = null;
         this.weakening = null;
         this.sfxData = null;
         this.sprite.material = null;
         this.sprite.colorTransform = null;
         this.lightEffect.kill();
         this.lightEffect = null;
         this.lightEffectPositionProvider = null;
      }
      
      override protected function getRadius() : Number
      {
         return this.twinsInitParams.shellRadius;
      }
      
      private function createExplosionEffect(param1:Vector3, param2:Number) : void
      {
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         _loc3_.init(param1,TwinsShotParams.EXPLOSION_OFFSET_TO_CAMERA);
         var _loc4_:Number = TwinsShotParams.EXPLOSION_SPRITE_SIZE * (1 + param2) / 2;
         var _loc5_:AnimatedSpriteEffect = AnimatedSpriteEffect(battleService.getObjectPool().getObject(AnimatedSpriteEffect));
         _loc5_.init(_loc4_,_loc4_,this.sfxData.explosionAnimation,MathUtils.PI2 * Math.random(),_loc3_,0.5,0.5);
         battleService.addGraphicEffect(_loc5_);
         this.createExplosionLightEffect(param1);
      }
      
      private function createExplosionLightEffect(param1:Vector3) : void
      {
         var _loc2_:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         _loc3_.init(param1,TwinsShotParams.EXPLOSION_OFFSET_TO_CAMERA);
         _loc2_.init(_loc3_,this.sfxData.hitLightingAnimation);
         battleService.addGraphicEffect(_loc2_);
      }
      
      private function createHitMark(param1:Vector3) : void
      {
         var _loc2_:DecalEffect = null;
         if(GPUCapabilities.gpuEnabled)
         {
            _loc2_ = DecalEffect(battleService.getObjectPool().getObject(DecalEffect));
            _loc2_.init(param1,this.sfxData.hitMarkMaterial,barrelOrigin,TwinsShotParams.HIT_MARK_RADIUS,TwinsShotParams.HIT_MARK_LIFE_TIME,TwinsShotParams.HIT_MARK_FADE_TIME);
            battleService.addGraphicEffect(_loc2_);
         }
      }
   }
}

