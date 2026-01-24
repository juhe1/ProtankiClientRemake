package alternativa.tanks.models.weapon.artillery.sfx
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.artillery.ArtilleryCannonEffect;
   import alternativa.tanks.models.weapon.artillery.ArtilleryObject;
   import alternativa.tanks.sfx.AnimatedLightEffect;
   import alternativa.tanks.sfx.ISound3DEffect;
   import alternativa.tanks.sfx.ISoundEffectDestructionListener;
   import alternativa.tanks.sfx.MobileSound3DEffect;
   import alternativa.tanks.sfx.MuzzlePositionProvider;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   import flash.media.Sound;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class ArtilleryEffects implements ISoundEffectDestructionListener, AutoClosable
   {
      
      [Inject] // added
      public static var localTankService:LocalTankInfoService;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const SHOT_SOUND_BY_POWER:Vector.<Number> = Vector.<Number>([0.3,0.6,0.9,1]);
      
      public static const FAR_SHOT_SOUND_DISTANCE:Number = 10000;
      
      public static const POWER_FOR_FAR_SHOT:Number = 0.5;
      
      private var sfxData:ArtillerySfxData;
      
      private var reloadSoundEffect:MobileSound3DEffect;
      
      private var chargingSound:MobileSound3DEffect;
      
      private var cannonEffect:ArtilleryCannonEffect;
      
      private var shotEffect:ArtilleryShotEffect;
      
      private var weaponObject:ArtilleryObject;
      
      public function ArtilleryEffects(param1:ArtilleryObject)
      {
         super();
         this.weaponObject = param1;
         this.sfxData = param1.sfx().getSfxData();
         this.shotEffect = this.createShotGraphicEffect();
      }
      
      private function createShotLightEffect(param1:Vector3, param2:Object3D) : void
      {
         var _loc3_:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc4_:MuzzlePositionProvider = MuzzlePositionProvider(battleService.getObjectPool().getObject(MuzzlePositionProvider));
         _loc4_.init(param2,param1);
         _loc3_.init(_loc4_,this.sfxData.shotLightAnimation);
         battleService.addGraphicEffect(_loc3_);
      }
      
      private function createShotGraphicEffect() : ArtilleryShotEffect
      {
         return new ArtilleryShotEffect(this.sfxData);
      }
      
      private function createShotSoundEffect(param1:Vector3, param2:Number, param3:Vector3, param4:Number) : void
      {
         var _loc6_:int = 0;
         var _loc5_:Number = Vector3.distanceBetween(param1,param3);
         if(_loc5_ < FAR_SHOT_SOUND_DISTANCE)
         {
            _loc6_ = this.getShotSoundIndex(param2);
            battleService.addSound3DEffect(Sound3DEffect.create(param1,Sound3D.create(this.sfxData.shotSounds[_loc6_],0.8)));
         }
         else if(param2 >= POWER_FOR_FAR_SHOT && param4 >= 15)
         {
            battleService.addSound3DEffect(Sound3DEffect.create(param3,Sound3D.create(this.sfxData.farShotSound,0.8)));
         }
      }
      
      private function getShotSoundIndex(param1:Number) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < SHOT_SOUND_BY_POWER.length)
         {
            if(param1 < SHOT_SOUND_BY_POWER[_loc2_])
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return SHOT_SOUND_BY_POWER.length - 1;
      }
      
      public function createReloadSoundEffect(param1:Object3D, param2:Number) : void
      {
         var _loc3_:Sound = this.sfxData.reloadSound;
         var _loc4_:Sound3D = Sound3D.create(_loc3_,0.8);
         var _loc5_:ObjectPool = battleService.getObjectPool();
         this.reloadSoundEffect = MobileSound3DEffect(_loc5_.getObject(MobileSound3DEffect));
         var _loc6_:int = param2 - _loc3_.length + 1300;
         this.reloadSoundEffect.init(_loc4_,param1,_loc6_,1,0,this);
         battleService.addSound3DEffect(this.reloadSoundEffect);
      }
      
      public function createChargingSoundEffect(param1:Object3D) : void
      {
         var _loc2_:Sound = this.sfxData.chargingSound;
         var _loc3_:Sound3D = Sound3D.create(_loc2_,0.8);
         var _loc4_:ObjectPool = battleService.getObjectPool();
         this.chargingSound = MobileSound3DEffect(_loc4_.getObject(MobileSound3DEffect));
         this.chargingSound.init(_loc3_,param1,0,1,0,null);
         battleService.addSound3DEffect(this.chargingSound);
      }
      
      public function createShotEffect(param1:WeaponPlatform, param2:AllGlobalGunParams, param3:Number, param4:Number, param5:int) : void
      {
         this.killChargingSound();
         this.cannonEffect.run();
         this.shotEffect.run(param2);
         this.createShotLightEffect(param1.getLocalMuzzlePosition(),param1.getTurret3D());
         if(localTankService.isLocalTankLoaded())
         {
            this.createShotSoundEffect(param1.getBody().state.position,param3,localTankService.getLocalTank().getBody().state.position,param4);
            if(this.isLocalWeapon())
            {
               this.createReloadSoundEffect(param1.getTurret3D(),param5);
            }
         }
      }
      
      private function killChargingSound() : void
      {
         if(this.chargingSound != null)
         {
            this.chargingSound.kill();
            this.chargingSound = null;
         }
      }
      
      public function onSoundEffectDestroyed(param1:ISound3DEffect) : void
      {
         if(this.reloadSoundEffect == param1)
         {
            this.reloadSoundEffect = null;
         }
      }
      
      public function reset() : void
      {
         this.killChargingSound();
         if(this.cannonEffect == null)
         {
            this.cannonEffect = new ArtilleryCannonEffect(this.weaponObject);
         }
      }
      
      public function close() : void
      {
         this.weaponObject = null;
         this.sfxData = null;
         this.reloadSoundEffect = null;
         this.cannonEffect = null;
         this.killChargingSound();
      }
      
      private function isLocalWeapon() : Boolean
      {
         return this.weaponObject.isLocal();
      }
   }
}

