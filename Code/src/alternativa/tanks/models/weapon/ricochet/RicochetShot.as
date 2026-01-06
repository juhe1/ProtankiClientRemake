package alternativa.tanks.models.weapon.ricochet
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.engine3d.AnimatedSprite3D;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.shared.MarginalCollider;
   import alternativa.tanks.models.weapon.splash.Splash;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapons.shell.Shell;
   import alternativa.tanks.models.weapons.shell.states.DummyShellStates;
   import alternativa.tanks.models.weapons.shell.states.ShellStates;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.AnimatedSpriteEffect;
   import alternativa.tanks.sfx.ExternalObject3DPositionProvider;
   import alternativa.tanks.sfx.SFXUtils;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   import alternativa.tanks.utils.objectpool.Pool;
   import flash.media.Sound;
   import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetCC;
   
   public class RicochetShot extends Shell
   {
      
      public static const SPRITE_SIZE:Number = 300;
      
      public static const EXPLOSION_SPRITE_SIZE:Number = 266;
      
      public static const TRAIL_WIDTH:Number = 100;
      
      private static const BUMP_FLASH_SPRITE_SIZE:Number = 80;
      
      private static const TRAIL_LENGTH:Number = 300;
      
      private static const NUM_RADIAL_RAYS:int = 6;
      
      private static const staticHitNormal:Vector3 = new Vector3();
      
      private static const barrelDirection:Vector3 = new Vector3();
      
      private static const staticHitPoint:Vector3 = new Vector3();
      
      private var sfxData:RicochetSFXData;
      
      private var callback:RicochetWeaponCallback;
      
      private var impactPoints:Vector.<Vector3>;
      
      private var ricochetInitParams:RicochetCC;
      
      private var sprite:AnimatedSprite3D;
      
      private var weakening:DistanceWeakening;
      
      private var ricochetCount:int;
      
      private var tailTrail:TailTrail;
      
      private var impactForce:Number;
      
      private var lightingEffect:AnimatedLightEffect;
      
      private var lightEffectPositionProvider:ExternalObject3DPositionProvider;
      
      private var splash:Splash;
      
      public function RicochetShot(param1:Pool)
      {
         super(param1);
         this.sprite = new AnimatedSprite3D(SPRITE_SIZE,SPRITE_SIZE);
         this.sprite.looped = true;
         this.tailTrail = new TailTrail(TRAIL_WIDTH,TRAIL_LENGTH);
         this.impactPoints = new Vector.<Vector3>();
      }
      
      override protected function createShellStates() : ShellStates
      {
         return DummyShellStates.INSTANCE;
      }
      
      public function init(param1:Number, param2:RicochetCC, param3:RicochetSFXData, param4:DistanceWeakening, param5:RicochetWeaponCallback, param6:Splash) : void
      {
         this.impactForce = param1;
         this.ricochetInitParams = param2;
         this.sfxData = param3;
         this.weakening = param4;
         this.callback = param5;
         this.splash = param6;
         this.sprite.rotation = 2 * Math.PI * Math.random();
         this.sprite.setAnimationData(param3.shotAnimation);
         this.sprite.setFrameIndex(this.sprite.getNumFrames() * Math.random());
         this.tailTrail.setMaterialToAllFaces(param3.tailTrailMaterial);
         this.ricochetCount = 0;
         this.impactPoints.length = 0;
         this.lightingEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
         this.lightEffectPositionProvider = ExternalObject3DPositionProvider(battleService.getObjectPool().getObject(ExternalObject3DPositionProvider));
         this.lightingEffect.init(this.lightEffectPositionProvider,param3.shellLightAnimation,AnimatedLightEffect.DEFAULT_MAX_DISTANCE,true);
      }
      
      override public function addToGame(param1:AllGlobalGunParams, param2:Vector3, param3:Body, param4:Boolean, param5:int) : void
      {
         super.addToGame(param1,param2,param3,param4,param5);
         var _loc6_:BattleScene3D = battleService.getBattleScene3D();
         _loc6_.addObject(this.sprite);
         _loc6_.addObject(this.tailTrail);
         _loc6_.addObjectToExclusion(this.tailTrail);
         _loc6_.addGraphicEffect(this.lightingEffect);
      }
      
      override protected function update(param1:Number) : void
      {
         var _loc4_:Body = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Vector3 = null;
         var _loc9_:Boolean = false;
         var _loc10_:Number = NaN;
         if(totalDistance >= this.ricochetInitParams.shotDistance)
         {
            this.destroy();
            return;
         }
         var _loc2_:CollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         var _loc3_:Number = this.ricochetInitParams.shellSpeed * param1;
         prevPosition.copy(currPosition);
         while(_loc3_ > 0)
         {
            _loc5_ = -1;
            _loc6_ = _loc3_;
            if(_loc2_.raycast(currPosition,flightDirection,CollisionGroup.WEAPON,_loc3_,this,_rayHit))
            {
               _loc4_ = _rayHit.shape.body;
               _loc5_ = _rayHit.t;
               if(BattleUtils.isTankBody(_loc4_))
               {
                  this.impactPoints.push(_rayHit.position.clone().add(_rayHit.normal));
                  this.handleTargetHit(_loc4_,_rayHit.position,flightDirection,totalDistance + _loc5_,this.impactPoints);
                  return;
               }
               _loc6_ = _loc5_;
               staticHitPoint.copy(_rayHit.position);
               staticHitNormal.copy(_rayHit.normal);
            }
            _loc7_ = 0;
            while(_loc7_ < NUM_RADIAL_RAYS)
            {
               _loc8_ = radialPoints[_loc7_];
               if(_loc2_.raycast(_loc8_,flightDirection,CollisionGroup.WEAPON,_loc6_,this,_rayHit))
               {
                  _loc4_ = _rayHit.shape.body;
                  _hitPoint.copy(currPosition).addScaled(_rayHit.t,flightDirection);
                  _loc9_ = BattleUtils.isTankBody(_loc4_) && !this.thickRaycast(currPosition,_hitPoint);
                  if(_loc9_)
                  {
                     this.impactPoints.push(_hitPoint.clone());
                     this.handleTargetHit(_loc4_,_hitPoint,flightDirection,totalDistance + _rayHit.t,this.impactPoints);
                     return;
                  }
               }
               _loc8_.addScaled(_loc6_,flightDirection);
               _loc7_++;
            }
            if(_loc5_ > -1)
            {
               totalDistance += _loc5_;
               _loc3_ -= _loc5_;
               if(this.ricochetCount >= this.ricochetInitParams.maxRicochetCount)
               {
                  _loc10_ = this.weakening.getImpactCoeff(totalDistance);
                  this.impactPoints.push(staticHitPoint.clone());
                  this.handleStaticHit(staticHitNormal,_loc10_,_loc4_);
                  return;
               }
               ++this.ricochetCount;
               currPosition.addScaled(_loc5_,flightDirection);
               this.reflectTrajectory(staticHitNormal);
               this.createBumpEffects(currPosition);
               this.impactPoints.push(currPosition.clone());
            }
            else
            {
               totalDistance += _loc3_;
               currPosition.addScaled(_loc3_,flightDirection);
               _loc3_ = 0;
            }
         }
      }
      
      private function handleStaticHit(param1:Vector3, param2:Number = 1, param3:Body = null) : void
      {
         var _loc4_:Vector3 = this.impactPoints[this.impactPoints.length - 1];
         _loc4_.addScaled(0.1,param1);
         var _loc5_:Boolean = Boolean(this.splash.applySplashForce(_loc4_,param2,param3));
         this.createExplosionEffect(_loc4_);
         if(Boolean(this.callback) && _loc5_)
         {
            this.callback.onStaticHit(getShotId(),this.impactPoints);
         }
         this.destroy();
      }
      
      private function thickRaycast(param1:Vector3, param2:Vector3) : Boolean
      {
         return MarginalCollider.segmentWithStaticIntersection(param1,param2);
      }
      
      private function reflectTrajectory(param1:Vector3) : void
      {
         currPosition.addScaled(0.1,param1);
         flightDirection.addScaled(-2 * flightDirection.dot(param1),param1);
         initRadialPoints(currPosition,flightDirection);
      }
      
      override public function render(param1:int, param2:int) : void
      {
         this.sprite.x = interpolatedPosition.x;
         this.sprite.y = interpolatedPosition.y;
         this.sprite.z = interpolatedPosition.z;
         this.sprite.update(param2 / 1000);
         var _loc3_:Number = this.weakening.getImpactCoeff(totalDistance);
         var _loc4_:Number = SPRITE_SIZE * _loc3_;
         this.sprite.width = _loc4_;
         this.sprite.height = _loc4_;
         this.sprite.rotation -= 0.003 * param2;
         var _loc5_:Vector3 = battleService.getBattleScene3D().getCamera().position;
         SFXUtils.alignObjectPlaneToView(this.tailTrail,interpolatedPosition,flightDirection,_loc5_);
         var _loc6_:Number = currPosition.x - _loc5_.x;
         var _loc7_:Number = currPosition.y - _loc5_.y;
         var _loc8_:Number = currPosition.z - _loc5_.z;
         var _loc9_:Number = _loc6_ * _loc6_ + _loc7_ * _loc7_ + _loc8_ * _loc8_;
         if(_loc9_ > 0.00001)
         {
            _loc9_ = 1 / Math.sqrt(_loc9_);
            _loc6_ *= _loc9_;
            _loc7_ *= _loc9_;
            _loc8_ *= _loc9_;
         }
         var _loc10_:Number = _loc6_ * flightDirection.x + _loc7_ * flightDirection.y + _loc8_ * flightDirection.z;
         if(_loc10_ < 0)
         {
            _loc10_ = -_loc10_;
         }
         if(_loc10_ > 0.5)
         {
            this.tailTrail.alpha = 2 * (1 - _loc10_) * _loc3_;
         }
         else
         {
            this.tailTrail.alpha = _loc3_;
         }
         this.lightEffectPositionProvider.setPosition(interpolatedPosition);
      }
      
      override protected function destroy() : void
      {
         var _loc1_:BattleScene3D = null;
         super.destroy();
         _loc1_ = battleService.getBattleScene3D();
         _loc1_.removeObject(this.sprite);
         this.sprite.material = null;
         _loc1_.removeObject(this.tailTrail);
         this.tailTrail.setMaterialToAllFaces(null);
         _loc1_.removeObjectFromExclusion(this.tailTrail);
         shooterBody = null;
         this.ricochetInitParams = null;
         this.sfxData = null;
         this.weakening = null;
         this.callback = null;
         this.lightingEffect.kill();
         this.lightingEffect = null;
         this.lightEffectPositionProvider = null;
      }
      
      override public function considerBody(param1:Body) : Boolean
      {
         return super.considerBody(param1) || this.ricochetCount > 0;
      }
      
      private function createExplosionEffect(param1:Vector3) : void
      {
         var _loc2_:ObjectPool = battleService.getObjectPool();
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(_loc2_.getObject(StaticObject3DPositionProvider));
         var _loc4_:int = 50;
         _loc3_.init(param1,_loc4_);
         var _loc5_:AnimatedSpriteEffect = AnimatedSpriteEffect(_loc2_.getObject(AnimatedSpriteEffect));
         var _loc6_:Number = Math.random() * Math.PI * 2;
         var _loc7_:int = 0;
         _loc5_.init(EXPLOSION_SPRITE_SIZE,EXPLOSION_SPRITE_SIZE,this.sfxData.explosionAnimation,_loc6_,_loc3_,0.5,0.5,null,_loc7_);
         battleService.addGraphicEffect(_loc5_);
         this.addSoundEffect(this.sfxData.explosionSound,param1);
         this.createExplosionLightEffect(param1);
      }
      
      private function createExplosionLightEffect(param1:Vector3) : void
      {
         var _loc2_:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         _loc3_.init(param1,50);
         _loc2_.init(_loc3_,this.sfxData.hitLightAnimation);
         battleService.addGraphicEffect(_loc2_);
      }
      
      private function createRicochetLightEffect(param1:Vector3) : void
      {
         var _loc2_:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         _loc3_.init(param1,50);
         _loc2_.init(_loc3_,this.sfxData.ricochetLightAnimation);
         battleService.addGraphicEffect(_loc2_);
      }
      
      private function addSoundEffect(param1:Sound, param2:Vector3) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Sound3D = null;
         var _loc5_:Sound3DEffect = null;
         if(param1 != null)
         {
            _loc3_ = 0.8;
            _loc4_ = Sound3D.create(param1,_loc3_);
            _loc5_ = Sound3DEffect.create(param2,_loc4_);
            battleService.addSound3DEffect(_loc5_);
         }
      }
      
      private function handleTargetHit(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:Vector.<Vector3>) : void
      {
         this.createExplosionEffect(param2);
         var _loc6_:Number = this.weakening.getImpactCoeff(param4);
         var _loc7_:Tank = param1.tank;
         _loc7_.applyWeaponHit(param2,param3,_loc6_ * this.impactForce);
         this.splash.applySplashForce(param2,_loc6_,param1);
         this.onTargetHit(param1,param5);
         this.destroy();
      }
      
      private function onTargetHit(param1:Body, param2:Vector.<Vector3>) : void
      {
         if(Boolean(this.callback))
         {
            this.callback.onTargetHit(getShotId(),param1,param2);
         }
      }
      
      private function createBumpEffects(param1:Vector3) : void
      {
         var _loc2_:ObjectPool = battleService.getObjectPool();
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(_loc2_.getObject(StaticObject3DPositionProvider));
         var _loc4_:int = 50;
         _loc3_.init(param1,_loc4_);
         var _loc5_:AnimatedSpriteEffect = AnimatedSpriteEffect(_loc2_.getObject(AnimatedSpriteEffect));
         _loc5_.init(BUMP_FLASH_SPRITE_SIZE,BUMP_FLASH_SPRITE_SIZE,this.sfxData.ricochetFlashAnimation,Math.random() * Math.PI * 2,_loc3_,0.5,0.5);
         battleService.addGraphicEffect(_loc5_);
         this.addSoundEffect(this.sfxData.ricochetSound,param1);
         this.createRicochetLightEffect(param1);
      }
      
      override protected function checkIfBarrelIntersectsWithObstacle() : Boolean
      {
         var _loc1_:CollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         barrelDirection.diff(currPosition,barrelOrigin);
         var _loc2_:Number = barrelDirection.length();
         barrelDirection.normalize();
         return this.doRaycastTests(barrelDirection,_loc2_,_loc1_);
      }
      
      private function doRaycastTests(param1:Vector3, param2:Number, param3:CollisionDetector) : Boolean
      {
         if(param3.raycast(barrelOrigin,param1,CollisionGroup.WEAPON,param2,this,_rayHit))
         {
            this.impactPoints.push(_rayHit.position.clone());
            if(BattleUtils.isTankBody(_rayHit.shape.body))
            {
               this.handleTargetHit(_rayHit.shape.body,_rayHit.position,param1,0,this.impactPoints);
               return true;
            }
            if(this.ricochetCount >= this.ricochetInitParams.maxRicochetCount)
            {
               this.handleStaticHit(_rayHit.normal);
               return true;
            }
            ++this.ricochetCount;
            currPosition.copy(_rayHit.position);
            this.reflectTrajectory(_rayHit.normal);
            this.createBumpEffects(_rayHit.position);
            return false;
         }
         return this.checkIfRadialPointsIntersectWithTarget(param1,param2,param3);
      }
      
      private function checkIfRadialPointsIntersectWithTarget(param1:Vector3, param2:Number, param3:CollisionDetector) : Boolean
      {
         var _loc5_:Vector3 = null;
         var _loc6_:Body = null;
         initRadialPoints(barrelOrigin,param1);
         var _loc4_:int = 0;
         while(_loc4_ < NUM_RADIAL_RAYS)
         {
            _loc5_ = radialPoints[_loc4_];
            if(param3.raycast(_loc5_,flightDirection,CollisionGroup.WEAPON,param2,this,_rayHit))
            {
               _loc6_ = _rayHit.shape.body;
               if(BattleUtils.isTankBody(_loc6_))
               {
                  _hitPoint.copy(barrelOrigin).addScaled(_rayHit.t,param1);
                  this.impactPoints.push(_hitPoint.clone());
                  this.handleTargetHit(_loc6_,_hitPoint,param1,0,this.impactPoints);
                  return true;
               }
            }
            _loc4_++;
         }
         return false;
      }
      
      override protected function getRadius() : Number
      {
         return this.ricochetInitParams.shellRadius;
      }
      
      override protected function getNumRadialRays() : int
      {
         return NUM_RADIAL_RAYS;
      }
   }
}

