package alternativa.tanks.models.weapon.shotgun.sfx
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.battle.scene3d.RotationState;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.engine3d.AnimatedSprite3D;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.RayCollisionFilter;
   import alternativa.tanks.models.weapon.shotgun.PelletDirectionCalculator;
   import alternativa.tanks.models.weapon.shotgun.ShotgunObject;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import alternativa.tanks.sfx.AnimatedPlane;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.sfx.SFXUtils;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.BlendMode;
   
   public class ShotgunShotEffect extends PooledObject implements GraphicEffect
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const DECAL_RADIUS:Number = 16;
      
      private static const FIRE_SIZE:Number = 270;
      
      private static const SMOKE_RESP_DISTANCE:Number = 100;
      
      private static const SMOKE_LIFE_TIME:Number = 1.3;
      
      private static const SMOKE_MOVE_DISTANCE:Number = 400;
      
      private static const SMOKE_LIFT_DISTANCE:Number = 150;
      
      private static const SMOKE_SCALE:Number = 2.5;
      
      private static const SMOKE_SIZE:Number = 200;
      
      private static const SMOKE_DELAY_TIME:Number = 0.08;
      
      private static const PELLET_LIFE_TIME:Number = 0.3;
      
      private static const SHIFT_RICOCHET_TIME:Number = 0.05;
      
      private static const MAX_DISTANCE:Number = 5000;
      
      private static const SPARKLE_MIN_SIZE:Number = 6;
      
      private static const SPARKLE_LIFE_TIME:Number = 0.2;
      
      private static const SPARKLE_SCALE:Number = 30;
      
      private static const rayHit:RayHit = new RayHit();
      
      private static const collisionFilter:RayCollisionFilter = new RayCollisionFilter();
      
      private static const originAlong:Vector3 = new Vector3();
      
      private static const pelletOrigin:Vector3 = new Vector3();
      
      private static const pelletRicochetOrigin:Vector3 = new Vector3();
      
      private static const pelletDirection:Vector3 = new Vector3();
      
      private var fireAlong:AnimatedPlane = new AnimatedPlane(FIRE_SIZE,FIRE_SIZE,0,FIRE_SIZE / 2,0);
      
      private var fireAcross:AnimatedPlane = new AnimatedPlane(FIRE_SIZE,FIRE_SIZE,0,0,0);
      
      private var smoke:AnimatedSprite3D = new AnimatedSprite3D(SMOKE_SIZE,SMOKE_SIZE);
      
      private var pellets:Vector.<PelletTrail> = new Vector.<PelletTrail>();
      
      private var ricochetPellets:Vector.<PelletTrail> = new Vector.<PelletTrail>();
      
      private var sparkles:Vector.<Sprite3D> = new Vector.<Sprite3D>();
      
      private var muzzlePosition:Vector3 = new Vector3();
      
      private var muzzleDirection:Vector3 = new Vector3();
      
      private var time:Number = 0;
      
      private var container:Scene3DContainer;
      
      private var shotgunSFX:ShotgunSFXData;
      
      private var maxSmokeDistance:Number;
      
      public function ShotgunShotEffect(param1:Pool)
      {
         super(param1);
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.fireAlong);
         param1.addChild(this.fireAcross);
         param1.addChild(this.smoke);
         var _loc2_:int = 0;
         while(_loc2_ < this.pellets.length)
         {
            param1.addChild(this.pellets[_loc2_]);
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.sparkles.length)
         {
            param1.addChild(this.sparkles[_loc3_]);
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this.ricochetPellets.length)
         {
            param1.addChild(this.ricochetPellets[_loc4_]);
            _loc4_++;
         }
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         if(this.allNotHaveParent())
         {
            return false;
         }
         var _loc3_:Number = param1 / 1000;
         this.playFire(param2);
         this.playPelletTrail(param2,this.pellets);
         this.playSmoke(_loc3_);
         this.playSparkle();
         if(this.time >= SHIFT_RICOCHET_TIME)
         {
            this.playRicochetPelletTrail(param2,this.ricochetPellets);
         }
         this.time += _loc3_;
         this.checkForRemoveChildren();
         return true;
      }
      
      private function allNotHaveParent() : Boolean
      {
         return this.fireAlong.parent == null && this.fireAcross.parent == null && this.smoke.parent == null && this.pellets[0].parent == null && this.sparkles[0].parent == null && this.ricochetPellets[0].parent == null;
      }
      
      private function playFire(param1:GameCamera) : void
      {
         var _loc3_:Number = NaN;
         SFXUtils.calculateAlphaForObject(this.fireAlong,param1.position,this.muzzleDirection,false,8,0.9);
         SFXUtils.calculateAlphaForObject(this.fireAcross,param1.position,this.muzzleDirection,true,4,0.3);
         this.fireAlong.setTime(this.time);
         var _loc2_:int = this.time * this.shotgunSFX.shotAlongAnimation.fps;
         if(_loc2_ == 5)
         {
            _loc3_ = FIRE_SIZE * 0.35;
            originAlong.copy(this.muzzlePosition).addScaled(_loc3_,this.muzzleDirection);
         }
         else if(_loc2_ >= 6)
         {
            _loc3_ = FIRE_SIZE * 0.5;
            originAlong.copy(this.muzzlePosition).addScaled(_loc3_,this.muzzleDirection);
         }
         else
         {
            originAlong.copy(this.muzzlePosition);
         }
         SFXUtils.alignObjectPlaneToView(this.fireAlong,originAlong,this.muzzleDirection,param1.position);
         this.fireAcross.setTime(this.time);
         _loc2_ = this.time * this.shotgunSFX.shotAcrossAnimation.fps;
         _loc3_ = 0.1 * FIRE_SIZE + _loc2_ * 0.1 * FIRE_SIZE;
         this.fireAcross.x = this.muzzlePosition.x + this.muzzleDirection.x * _loc3_;
         this.fireAcross.y = this.muzzlePosition.y + this.muzzleDirection.y * _loc3_;
         this.fireAcross.z = this.muzzlePosition.z + this.muzzleDirection.z * _loc3_;
      }
      
      private function playPelletTrail(param1:GameCamera, param2:Vector.<PelletTrail>) : void
      {
         var _loc4_:PelletTrail = null;
         var _loc3_:Number = this.time / PELLET_LIFE_TIME;
         for each(_loc4_ in param2)
         {
            this.playPellet(_loc4_,_loc3_,param1);
         }
      }
      
      private function playPellet(param1:PelletTrail, param2:Number, param3:GameCamera) : Number
      {
         var _loc4_:Number = param1.distance * param2;
         pelletOrigin.copy(param1.position).addScaled(_loc4_,param1.direction);
         param1.alpha = 1 - 2 * Math.abs(0.5 - param2);
         SFXUtils.alignObjectPlaneToView(param1,pelletOrigin,param1.direction,param3.position);
         param1.visible = true;
         return _loc4_;
      }
      
      private function playRicochetPelletTrail(param1:GameCamera, param2:Vector.<PelletTrail>) : void
      {
         var _loc4_:PelletTrail = null;
         var _loc3_:Number = (this.time - SHIFT_RICOCHET_TIME) / PELLET_LIFE_TIME;
         for each(_loc4_ in param2)
         {
            if(!_loc4_.isRicochet)
            {
               return;
            }
            this.playPellet(_loc4_,_loc3_,param1);
         }
      }
      
      private function playSmoke(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this.time > SMOKE_DELAY_TIME)
         {
            this.smoke.visible = true;
            _loc2_ = this.time * this.smoke.getFps();
            this.smoke.setFrameIndex(_loc2_);
            _loc3_ = this.time - SMOKE_DELAY_TIME;
            _loc4_ = Math.sqrt(_loc3_ / SMOKE_LIFE_TIME);
            if(this.maxSmokeDistance > SMOKE_RESP_DISTANCE)
            {
               _loc7_ = Math.min(this.maxSmokeDistance - SMOKE_RESP_DISTANCE,SMOKE_MOVE_DISTANCE);
               _loc5_ = SMOKE_RESP_DISTANCE + _loc7_ * _loc4_;
            }
            else
            {
               _loc5_ = 0;
               this.smoke.visible = false;
            }
            this.smoke.x = this.muzzlePosition.x + this.muzzleDirection.x * _loc5_;
            this.smoke.y = this.muzzlePosition.y + this.muzzleDirection.y * _loc5_;
            this.smoke.z = this.muzzlePosition.z + this.muzzleDirection.z * _loc5_ + SMOKE_LIFT_DISTANCE * _loc4_;
            _loc6_ = 1 + (SMOKE_SCALE - 1) * _loc4_;
            this.smoke.scaleX = _loc6_;
            this.smoke.scaleY = _loc6_;
            this.smoke.scaleZ = _loc6_;
            this.smoke.alpha = 1 - _loc4_;
            this.smoke.rotation -= 0.3 * param1;
         }
         else
         {
            this.smoke.visible = false;
         }
      }
      
      private function playSparkle() : void
      {
         var _loc3_:Sprite3D = null;
         var _loc1_:Number = (this.time - SHIFT_RICOCHET_TIME) / SPARKLE_LIFE_TIME;
         _loc1_ *= _loc1_;
         var _loc2_:Number = 1 + (SPARKLE_SCALE - 1) * _loc1_;
         for each(_loc3_ in this.sparkles)
         {
            _loc3_.scaleX = _loc2_;
            _loc3_.scaleY = _loc2_;
            _loc3_.scaleZ = _loc2_;
            _loc3_.alpha = 1 - _loc1_;
         }
      }
      
      private function checkForRemoveChildren() : void
      {
         var _loc1_:PelletTrail = null;
         var _loc2_:PelletTrail = null;
         var _loc3_:Sprite3D = null;
         if(this.time > PELLET_LIFE_TIME)
         {
            for each(_loc1_ in this.pellets)
            {
               this.container.removeChild(_loc1_);
            }
         }
         if(this.time > PELLET_LIFE_TIME + SHIFT_RICOCHET_TIME)
         {
            for each(_loc2_ in this.ricochetPellets)
            {
               if(_loc2_.parent != null)
               {
                  this.container.removeChild(_loc2_);
               }
            }
         }
         if(this.time > this.fireAlong.getOneLoopTime())
         {
            this.container.removeChild(this.fireAlong);
         }
         if(this.time > this.fireAcross.getOneLoopTime())
         {
            this.container.removeChild(this.fireAcross);
         }
         if(this.time > SMOKE_DELAY_TIME + SMOKE_LIFE_TIME)
         {
            this.container.removeChild(this.smoke);
         }
         if(this.time > SPARKLE_LIFE_TIME)
         {
            for each(_loc3_ in this.sparkles)
            {
               this.container.removeChild(_loc3_);
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.pellets.length)
         {
            this.pellets[_loc1_].clear();
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.ricochetPellets.length)
         {
            this.ricochetPellets[_loc2_].clear();
            this.ricochetPellets[_loc2_].visible = false;
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.sparkles.length)
         {
            this.sparkles[_loc3_].material = null;
            _loc3_++;
         }
         this.fireAcross.clear();
         this.fireAlong.clear();
         this.smoke.clear();
         recycle();
      }
      
      public function kill() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.pellets.length)
         {
            this.container.removeChild(this.pellets[_loc1_]);
            this.container.removeChild(this.ricochetPellets[_loc1_]);
            this.container.removeChild(this.sparkles[_loc1_]);
            _loc1_++;
         }
         this.container.removeChild(this.fireAlong);
         this.container.removeChild(this.fireAcross);
         this.container.removeChild(this.smoke);
      }
      
      public function init(param1:ShotgunObject, param2:AllGlobalGunParams, param3:WeaponPlatform, param4:Vector3, param5:ShotgunSFXData) : void
      {
         this.shotgunSFX = param5;
         this.muzzlePosition.copy(param2.muzzlePosition);
         this.muzzleDirection.copy(param2.direction);
         this.initShotFire();
         this.initSmoke();
         this.initPelletEffectsAndCorrectMaxSmokeDistance(param1,param2,param4,param3.getBody());
         this.time = 0;
      }
      
      private function initShotFire() : void
      {
         this.fireAlong.blendMode = BlendMode.ADD;
         var _loc1_:TextureAnimation = this.shotgunSFX.shotAlongAnimation;
         this.fireAlong.init(_loc1_,_loc1_.fps);
         this.fireAlong.shadowMapAlphaThreshold = 2;
         this.fireAlong.useShadowMap = false;
         this.fireAlong.depthMapAlphaThreshold = 2;
         this.fireAlong.useLight = false;
         var _loc2_:TextureAnimation = this.shotgunSFX.shotAcrossAnimation;
         this.fireAcross.init(_loc2_,_loc2_.fps);
         this.fireAcross.blendMode = BlendMode.ADD;
         this.fireAcross.rotationX = Math.atan2(this.muzzleDirection.z,Math.sqrt(this.muzzleDirection.x * this.muzzleDirection.x + this.muzzleDirection.y * this.muzzleDirection.y)) - Math.PI / 2;
         this.fireAcross.rotationY = 0;
         this.fireAcross.rotationZ = -Math.atan2(this.muzzleDirection.x,this.muzzleDirection.y);
         this.fireAcross.shadowMapAlphaThreshold = 2;
         this.fireAcross.useShadowMap = false;
         this.fireAcross.depthMapAlphaThreshold = 2;
         this.fireAcross.useLight = false;
      }
      
      private function initSmoke() : void
      {
         this.smoke.setAnimationData(this.shotgunSFX.smokeAnimation);
         this.smoke.setFrameIndex(0);
         this.smoke.rotation = Math.random() * Math.PI * 2;
         this.smoke.shadowMapAlphaThreshold = 2;
         this.smoke.useShadowMap = false;
         this.smoke.depthMapAlphaThreshold = 2;
         this.smoke.useLight = false;
         this.smoke.softAttenuation = 130;
         this.maxSmokeDistance = MAX_DISTANCE;
      }
      
      private function initPelletEffectsAndCorrectMaxSmokeDistance(param1:ShotgunObject, param2:AllGlobalGunParams, param3:Vector3, param4:Body) : void
      {
         var _loc10_:Vector3 = null;
         var _loc5_:Vector.<Vector3> = this.getPelletDirections(param1,param2,param3);
         var _loc6_:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         collisionFilter.exclusion = param4;
         var _loc7_:DistanceWeakening = param1.distanceWeakening();
         var _loc8_:Number = _loc7_.getDistance();
         while(this.pellets.length < _loc5_.length)
         {
            this.addNewPelletAndSparkle();
         }
         var _loc9_:int = 0;
         while(_loc9_ < _loc5_.length)
         {
            _loc10_ = _loc5_[_loc9_];
            this.initPelletTrailAndSparkleEffectsAndCorrectMaxSmokeDistance(_loc9_,_loc6_,_loc10_,param2.barrelOrigin,_loc8_);
            _loc9_++;
         }
      }
      
      private function getPelletDirections(param1:ShotgunObject, param2:AllGlobalGunParams, param3:Vector3) : Vector.<Vector3>
      {
         var _loc4_:PelletDirectionCalculator = param1.pelletDirectionCalculator();
         _loc4_.next();
         return _loc4_.getDirectionsFor(param2.elevationAxis,param3);
      }
      
      private function addNewPelletAndSparkle() : void
      {
         this.pellets.push(this.createPelletTrail());
         this.ricochetPellets.push(this.createPelletTrail());
         var _loc1_:Sprite3D = new Sprite3D(0,0);
         _loc1_.blendMode = BlendMode.ADD;
         _loc1_.shadowMapAlphaThreshold = 2;
         _loc1_.useShadowMap = false;
         _loc1_.depthMapAlphaThreshold = 2;
         _loc1_.useLight = false;
         this.sparkles.push(_loc1_);
      }
      
      private function createPelletTrail() : PelletTrail
      {
         var _loc1_:PelletTrail = new PelletTrail();
         _loc1_.blendMode = BlendMode.ADD;
         _loc1_.shadowMapAlphaThreshold = 2;
         _loc1_.useShadowMap = false;
         _loc1_.depthMapAlphaThreshold = 2;
         _loc1_.useLight = false;
         return _loc1_;
      }
      
      private function initPelletTrailAndSparkleEffectsAndCorrectMaxSmokeDistance(param1:int, param2:TanksCollisionDetector, param3:Vector3, param4:Vector3, param5:Number) : void
      {
         var _loc9_:Boolean = false;
         var _loc10_:Sprite3D = null;
         var _loc6_:Boolean = param2.raycast(param4,param3,CollisionGroup.WEAPON,param5,collisionFilter,rayHit);
         var _loc7_:Number = MAX_DISTANCE;
         var _loc8_:PelletTrail = this.pellets[param1];
         _loc8_.position.copy(this.muzzlePosition);
         if(_loc6_)
         {
            _loc9_ = BattleUtils.isTankBody(rayHit.shape.body);
            _loc8_.direction.diff(rayHit.position,this.muzzlePosition);
            _loc7_ = this.getMaxPelletDistancesAndCorrectMaxSmokeDistance(param4,_loc7_,_loc8_,_loc9_);
            _loc8_.direction.normalize();
            _loc10_ = this.sparkles[param1];
            this.initSparkle(_loc10_,rayHit.position,param3);
            if(!_loc9_)
            {
               this.initPelletTrailAndSparkleEffectsRicochet(param1,param3,_loc10_,param2);
            }
         }
         else
         {
            _loc8_.direction.copy(param3);
         }
         this.initPelletTrail(_loc8_,_loc7_);
      }
      
      private function initPelletTrailAndSparkleEffectsRicochet(param1:int, param2:Vector3, param3:Sprite3D, param4:TanksCollisionDetector) : void
      {
         var _loc8_:Boolean = false;
         pelletRicochetOrigin.copy(rayHit.position);
         pelletDirection.copy(rayHit.normal);
         pelletDirection.scale(-2 * rayHit.normal.dot(param2)).add(param2);
         pelletRicochetOrigin.addScaled(0.1,pelletDirection);
         var _loc5_:Number = MAX_DISTANCE;
         var _loc6_:Boolean = param4.raycast(pelletRicochetOrigin,pelletDirection,CollisionGroup.WEAPON,_loc5_,null,rayHit);
         var _loc7_:PelletTrail = this.ricochetPellets[param1];
         _loc7_.isRicochet = true;
         _loc7_.position.copy(pelletRicochetOrigin);
         if(_loc6_)
         {
            _loc7_.direction.diff(rayHit.position,pelletRicochetOrigin);
            _loc8_ = BattleUtils.isTankBody(rayHit.shape.body);
            _loc5_ = this.getMaxPelletRicochetDistances(pelletRicochetOrigin,_loc7_,_loc8_);
            _loc7_.direction.normalize();
            if(!_loc8_)
            {
               this.showMark(pelletRicochetOrigin,rayHit.position);
            }
            else
            {
               this.initSparkle(param3,rayHit.position,pelletDirection);
            }
         }
         else
         {
            _loc7_.direction.copy(pelletDirection);
         }
         this.initPelletTrail(_loc7_,_loc5_);
      }
      
      private function getMaxPelletDistancesAndCorrectMaxSmokeDistance(param1:Vector3, param2:Number, param3:PelletTrail, param4:Boolean) : Number
      {
         var _loc5_:Number = param1.distanceTo(rayHit.position);
         var _loc6_:Number = param1.distanceTo(this.muzzlePosition);
         if(_loc5_ > _loc6_)
         {
            param2 = param3.direction.length();
         }
         else
         {
            param2 = 0;
         }
         if(!param4)
         {
            this.maxSmokeDistance = Math.min(param2,this.maxSmokeDistance);
         }
         return param2;
      }
      
      private function getMaxPelletRicochetDistances(param1:Vector3, param2:PelletTrail, param3:Boolean) : Number
      {
         if(!param3)
         {
            return param2.direction.length();
         }
         return param1.distanceTo(rayHit.position);
      }
      
      private function initPelletTrail(param1:PelletTrail, param2:Number) : void
      {
         var _loc3_:Number = 3 + Math.random() * 8;
         var _loc4_:Number = 0.3 + Math.random() * 0.3;
         var _loc5_:Number = Math.min(Math.random() * 200,param2);
         var _loc6_:Number = Math.min(400 + Math.random() * 2100,param2);
         var _loc7_:Number = 300 + Math.random() * 500;
         if(_loc7_ + _loc6_ > param2)
         {
            _loc7_ = Math.max(0,param2 - _loc6_);
         }
         param1.init(_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,this.shotgunSFX.pelletTrailMaterial);
      }
      
      private function initSparkle(param1:Sprite3D, param2:Vector3, param3:Vector3) : void
      {
         var _loc4_:Number = SPARKLE_MIN_SIZE + Math.random() * SPARKLE_MIN_SIZE;
         var _loc5_:Number = _loc4_ / 2;
         param1.width = _loc4_;
         param1.height = _loc4_;
         param1.material = this.shotgunSFX.sparkleMaterial;
         param1.x = param2.x - _loc5_ * param3.x;
         param1.y = param2.y - _loc5_ * param3.y;
         param1.z = param2.z - _loc5_ * param3.z;
         param1.rotation = Math.random() * Math.PI * 2;
         param1.visible = true;
      }
      
      private function showMark(param1:Vector3, param2:Vector3) : void
      {
         var _loc3_:Vector.<TextureMaterial> = this.shotgunSFX.explosionMarkMaterials;
         var _loc4_:int = Math.floor(Math.random() * _loc3_.length);
         battleService.getBattleScene3D().addDecal(param2,param1,DECAL_RADIUS,_loc3_[_loc4_],RotationState.WITHOUT_ROTATION);
      }
   }
}

