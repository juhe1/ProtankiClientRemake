package alternativa.tanks.models.weapon.railgun
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RayIntersectionData;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.AnimatedSpriteEffect;
   import alternativa.tanks.sfx.DistanceScaledAnimatedPlaneEffect;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.sfx.GraphicsEffectDestructionListener;
   import alternativa.tanks.sfx.ISound3DEffect;
   import alternativa.tanks.sfx.ISoundEffectDestructionListener;
   import alternativa.tanks.sfx.MuzzlePositionProvider;
   import alternativa.tanks.sfx.NormalObject3DPositionProvider;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.sfx.TubeLightEffect;
   import flash.geom.Vector3D;
   
   public class RailgunEffects implements IRailgunEffects, GraphicsEffectDestructionListener, ISoundEffectDestructionListener
   {
      
      public static const CHARGE_EFFECT_SIZE:int = 300;
      
      public static const RINGS_SIZE:Number = 300;
      
      public static const SPHERE_SIZE:Number = 200;
      
      public static const POW_WIDTH:Number = 30;
      
      private static const DECAL_RADIUS:Number = 50;
      
      private static const TRAIL_WIDTH:Number = 25;
      
      private static const TRAIL_BEGIN_SCALE:Number = 0.5;
      
      private static const TRAIL_END_SCALE:Number = 1.5;
      
      private static const TRAIL_MOVE_DISTANCE:Number = 20;
      
      private static const TRAIL_LIFE_TIME:int = 500;
      
      private static const SMOKE_WIDTH:Number = 80;
      
      private static const SMOKE_BEGIN_SCALE:Number = 0.5;
      
      private static const SMOKE_END_SCALE:Number = 2;
      
      private static const SMOKE_MOVE_DISTANCE:Number = 100;
      
      private static const SMOKE_LIFE_TIME:int = 2200;
      
      private static const SOUND_VOLUME:Number = 1;
      
      private static const _rayOrigin:Vector3D = new Vector3D();
      
      private static const _rayDirection:Vector3D = new Vector3D();
      
      private static const _effectPosition:Vector3 = new Vector3();
      
      private static const _effectNormal:Vector3 = new Vector3();
      
      private static const _effectDirection:Vector3 = new Vector3();
      
      private static const _rotation:Vector3 = new Vector3();
      
      private static const v:Vector3 = new Vector3();
      
      private var sfxData:RailgunSFXData;
      
      private var battleService:BattleService;
      
      private var chargeEffect:ChargeEffect;
      
      private var chargeLightEffect:AnimatedLightEffect;
      
      private var soundEffect:Sound3DEffect;
      
      public function RailgunEffects(param1:RailgunSFXData, param2:BattleService)
      {
         super();
         this.sfxData = param1;
         this.battleService = param2;
      }
      
      private static function projectHitPoint(param1:Vector3, param2:Vector3, param3:Vector3, param4:Vector3) : void
      {
         param4.copy(param1).subtract(param2);
         var _loc5_:Number = param4.dot(param3);
         param4.copy(param2).addScaled(_loc5_,param3);
      }
      
      private static function getRaycastData(param1:Vector3D, param2:Vector3D, param3:TankSkin) : RayIntersectionData
      {
         var _loc4_:RayIntersectionData = raycast(param3.getHullMesh(),param1,param2);
         var _loc5_:RayIntersectionData = raycast(param3.getTurret3D(),param1,param2);
         if(_loc4_ == null)
         {
            return _loc5_;
         }
         if(_loc5_ == null)
         {
            return _loc4_;
         }
         if(_loc5_.time < _loc4_.time)
         {
            return _loc5_;
         }
         return _loc4_;
      }
      
      private static function raycast(param1:Object3D, param2:Vector3D, param3:Vector3D) : RayIntersectionData
      {
         var _loc4_:Vector3D = param1.globalToLocal(param2);
         var _loc5_:Vector3D = param3.clone();
         _loc5_.x += param1.x;
         _loc5_.y += param1.y;
         _loc5_.z += param1.z;
         var _loc6_:Vector3D = param1.globalToLocal(_loc5_);
         return param1.intersectRay(_loc4_,_loc6_);
      }
      
      private static function getRotation(param1:Vector3) : Vector3
      {
         _rotation.x = Math.atan2(param1.z,Math.sqrt(param1.x * param1.x + param1.y * param1.y)) - Math.PI / 2;
         _rotation.y = 0;
         _rotation.z = -Math.atan2(param1.x,param1.y);
         return _rotation;
      }
      
      public function createChargeEffect(param1:Vector3, param2:Object3D, param3:int) : void
      {
         if(this.chargeEffect != null)
         {
            this.chargeEffect.kill();
         }
         this.chargeEffect = ChargeEffect(this.battleService.getObjectPool().getObject(ChargeEffect));
         this.chargeEffect.init(CHARGE_EFFECT_SIZE,CHARGE_EFFECT_SIZE,this.sfxData.chargingAnimation,param1,param2,0,this.getChargingEffectFPS(param3),this);
         this.battleService.addGraphicEffect(this.chargeEffect);
         this.createChargeLightEffect(param1,param2,param3);
      }
      
      public function createChargeLightEffect(param1:Vector3, param2:Object3D, param3:int) : void
      {
         if(this.chargeLightEffect != null)
         {
            this.chargeLightEffect.kill();
         }
         this.chargeLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc4_:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
         _loc4_.init(param2,param1);
         this.chargeLightEffect.initFromTime(_loc4_,param3,this.sfxData.chargeLightAnimation);
         this.battleService.addGraphicEffect(this.chargeLightEffect);
      }
      
      private function getChargingEffectFPS(param1:int) : Number
      {
         return 1000 * this.sfxData.chargingAnimation.frames.length / param1;
      }
      
      public function createSoundEffect(param1:Vector3) : void
      {
         if(this.soundEffect != null)
         {
            this.soundEffect.kill();
         }
         var _loc2_:Sound3D = Sound3D.create(this.sfxData.sound,SOUND_VOLUME);
         this.soundEffect = Sound3DEffect.create(param1,_loc2_,0,0,this);
         this.battleService.addSound3DEffect(this.soundEffect);
      }
      
      public function createShotTrail(param1:Vector3, param2:Vector3, param3:Vector3) : void
      {
         var _loc4_:ShotTrailEffect = null;
         var _loc5_:ShotSmokeEffect = null;
         if(param2 == null)
         {
            param2 = RailgunUtils.getDistantPoint(param1,param3);
         }
         v.diff(param2,param1);
         if(v.dot(param3) > 0)
         {
            _loc4_ = ShotTrailEffect(this.battleService.getObjectPool().getObject(ShotTrailEffect));
            _loc4_.init(param1,param2,this.sfxData.trailMaterial,TRAIL_WIDTH,TRAIL_BEGIN_SCALE,TRAIL_END_SCALE,TRAIL_MOVE_DISTANCE,TRAIL_LIFE_TIME);
            this.battleService.addGraphicEffect(_loc4_);
            _loc5_ = ShotSmokeEffect(this.battleService.getObjectPool().getObject(ShotSmokeEffect));
            _loc5_.init(param1,param2,this.sfxData.smokeMaterial,SMOKE_WIDTH,SMOKE_BEGIN_SCALE,SMOKE_END_SCALE,SMOKE_MOVE_DISTANCE,SMOKE_LIFE_TIME);
            this.battleService.addGraphicEffect(_loc5_);
         }
         this.createShotLightEffect(param1);
         this.createRailLightEffect(param1,param2);
      }
      
      private function createRailLightEffect(param1:Vector3, param2:Vector3) : void
      {
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         var _loc4_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         _loc3_.init(param1,0);
         _loc4_.init(param2,0);
         var _loc5_:TubeLightEffect = TubeLightEffect(this.battleService.getObjectPool().getObject(TubeLightEffect));
         _loc5_.init(_loc3_,_loc4_,this.sfxData.railLightAnimation);
         this.battleService.addGraphicEffect(_loc5_);
      }
      
      public function createShotLightEffect(param1:Vector3) : void
      {
         var _loc2_:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc3_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         _loc3_.init(param1,0);
         _loc2_.init(_loc3_,this.sfxData.shotLightAnimation);
         this.battleService.addGraphicEffect(_loc2_);
      }
      
      public function createStaticHitMark(param1:Vector3, param2:Vector3) : void
      {
         if(param2 != null)
         {
            this.battleService.getBattleScene3D().addDecal(param2,param1,DECAL_RADIUS,this.sfxData.hitMarkMaterial);
         }
      }
      
      public function stopEffects() : void
      {
         if(this.chargeEffect != null)
         {
            this.chargeEffect.kill();
            this.chargeEffect = null;
         }
         if(this.chargeLightEffect != null)
         {
            this.chargeLightEffect.kill();
            this.chargeLightEffect = null;
         }
         if(this.soundEffect != null)
         {
            this.soundEffect.kill();
            this.soundEffect = null;
         }
      }
      
      public function onGraphicsEffectDestroyed(param1:GraphicEffect) : void
      {
         if(this.chargeEffect == param1)
         {
            this.chargeEffect = null;
         }
      }
      
      public function onSoundEffectDestroyed(param1:ISound3DEffect) : void
      {
         if(this.soundEffect == param1)
         {
            this.soundEffect = null;
         }
      }
      
      public function createTargetHitEffects(param1:Vector3, param2:Vector3, param3:Vector.<Vector3>, param4:Vector.<Body>) : void
      {
         var _loc6_:Body = null;
         var _loc7_:Tank = null;
         var _loc8_:RayIntersectionData = null;
         var _loc9_:Object3D = null;
         var _loc10_:Vector3D = null;
         _rayOrigin.x = param1.x;
         _rayOrigin.y = param1.y;
         _rayOrigin.z = param1.z;
         _rayDirection.x = param2.x - param1.x;
         _rayDirection.y = param2.y - param1.y;
         _rayDirection.z = param2.z - param1.z;
         _effectDirection.copy(param2).subtract(param1).normalize();
         var _loc5_:int = 0;
         while(_loc5_ < param4.length)
         {
            _loc6_ = param4[_loc5_];
            if(_loc6_ != null && _loc6_.tank != null)
            {
               _loc7_ = _loc6_.tank;
               _loc8_ = getRaycastData(_rayOrigin,_rayDirection,_loc7_.getSkin());
               if(_loc8_ == null)
               {
                  projectHitPoint(param3[_loc5_],param1,_effectDirection,_effectPosition);
                  _effectNormal.copy(_effectDirection);
               }
               else
               {
                  _loc9_ = _loc8_.object;
                  _effectPosition.copyFromVector3D(_loc9_.localToGlobal(_loc8_.point));
                  _loc10_ = _loc9_.localToGlobal(_loc8_.face.normal);
                  _effectNormal.x = _loc10_.x - _loc9_.x;
                  _effectNormal.y = _loc10_.y - _loc9_.y;
                  _effectNormal.z = _loc10_.z - _loc9_.z;
               }
               this.createHitEffect(_effectPosition,_effectNormal,_effectDirection);
               this.createHitLightEffect(_effectPosition,_effectNormal);
            }
            _loc5_++;
         }
      }
      
      private function createHitLightEffect(param1:Vector3, param2:Vector3) : void
      {
         var _loc3_:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc4_:NormalObject3DPositionProvider = NormalObject3DPositionProvider(this.battleService.getObjectPool().getObject(NormalObject3DPositionProvider));
         _loc4_.init(param1,param2,50);
         _loc3_.init(_loc4_,this.sfxData.hitLightAnimation);
         this.battleService.addGraphicEffect(_loc3_);
      }
      
      private function createHitEffect(param1:Vector3, param2:Vector3, param3:Vector3) : void
      {
         var _loc4_:DistanceScaledAnimatedPlaneEffect = DistanceScaledAnimatedPlaneEffect(this.battleService.getObjectPool().getObject(DistanceScaledAnimatedPlaneEffect));
         _loc4_.init(RINGS_SIZE,param1,getRotation(param2),this.sfxData.ringsAnimation,1);
         this.battleService.getBattleScene3D().addGraphicEffect(_loc4_);
         var _loc5_:AnimatedSpriteEffect = AnimatedSpriteEffect(this.battleService.getObjectPool().getObject(AnimatedSpriteEffect));
         var _loc6_:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
         _loc6_.init(param1,30);
         _loc5_.init(SPHERE_SIZE,SPHERE_SIZE,this.sfxData.ringsAnimation,0,_loc6_,0.5,0.5,null,0);
         this.battleService.getBattleScene3D().addGraphicEffect(_loc5_);
         var _loc7_:RailgunPowEffect = RailgunPowEffect(this.battleService.getObjectPool().getObject(RailgunPowEffect));
         _loc7_.init(param1,param3,this.sfxData.powAnimation);
         this.battleService.getBattleScene3D().addGraphicEffect(_loc7_);
      }
      
      public function createStaticHitEffect(param1:Vector3, param2:Vector3, param3:Vector3) : void
      {
         _effectDirection.copy(param2).subtract(param1).normalize();
         this.createHitEffect(param2,param3,_effectDirection);
         this.createHitLightEffect(param2,param3);
      }
   }
}

