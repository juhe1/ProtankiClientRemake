package alternativa.tanks.models.weapon.shotgun.sfx
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.shotgun.ShotgunObject;
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
   
   public class ShotgunEffects implements AutoClosable, ISoundEffectDestructionListener
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const SHOT_VOLUME:Number = 1;
      
      private static const RELOAD_SOUND_SHIFT:int = 500;
      
      private static const MAGAZINE_RELOAD_SOUND_SHIFT:int = 1000;
      
      private var shotgunSFX:ShotgunSFXData;
      
      private var reloadSoundEffect:MobileSound3DEffect;
      
      public function ShotgunEffects(param1:ShotgunSFXData)
      {
         super();
         this.shotgunSFX = param1;
      }
      
      public function createShotEffects(param1:ShotgunObject, param2:AllGlobalGunParams, param3:WeaponPlatform, param4:Vector3) : void
      {
         this.createGraphicEffect(param1,param2,param3,param4);
         this.createSoundEffect(param2);
         this.createShotLightEffects(param3);
      }
      
      private function createSoundEffect(param1:AllGlobalGunParams) : void
      {
         var _loc2_:Sound3D = Sound3D.create(this.shotgunSFX.shotSound,SHOT_VOLUME);
         battleService.addSound3DEffect(Sound3DEffect.create(param1.muzzlePosition,_loc2_));
      }
      
      private function createGraphicEffect(param1:ShotgunObject, param2:AllGlobalGunParams, param3:WeaponPlatform, param4:Vector3) : void
      {
         var _loc5_:ShotgunShotEffect = ShotgunShotEffect(battleService.getObjectPool().getObject(ShotgunShotEffect));
         _loc5_.init(param1,param2,param3,param4,this.shotgunSFX);
         battleService.addGraphicEffect(_loc5_);
      }
      
      public function createReloadSoundEffect(param1:Object3D, param2:int) : void
      {
         var _loc3_:Sound = this.shotgunSFX.reloadSound;
         this.addReloadSound(_loc3_,param2,RELOAD_SOUND_SHIFT,param1);
      }
      
      public function createMagazineReloadSoundEffect(param1:Object3D, param2:int) : void
      {
         var _loc3_:Sound = this.shotgunSFX.magazineReloadSound;
         this.addReloadSound(_loc3_,param2,MAGAZINE_RELOAD_SOUND_SHIFT,param1);
      }
      
      public function stopEffects() : void
      {
         if(this.reloadSoundEffect != null)
         {
            this.reloadSoundEffect.kill();
         }
      }
      
      private function addReloadSound(param1:Sound, param2:int, param3:int, param4:Object3D) : void
      {
         var _loc5_:Sound3D = Sound3D.create(param1,SHOT_VOLUME);
         var _loc6_:ObjectPool = battleService.getObjectPool();
         this.reloadSoundEffect = MobileSound3DEffect(_loc6_.getObject(MobileSound3DEffect));
         var _loc7_:int = param2 - param1.length + param3;
         var _loc8_:int = 0;
         if(_loc7_ < 0)
         {
            _loc8_ = -_loc7_;
            _loc7_ = 0;
         }
         this.reloadSoundEffect.init(_loc5_,param4,_loc7_,1,_loc8_,this);
         battleService.addSound3DEffect(this.reloadSoundEffect);
      }
      
      private function createShotLightEffects(param1:WeaponPlatform) : void
      {
         var _loc2_:TankSkin = param1.getSkin();
         var _loc3_:Object3D = _loc2_.getTurret3D();
         var _loc4_:Vector3 = param1.getLocalMuzzlePosition();
         var _loc5_:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
         var _loc6_:MuzzlePositionProvider = MuzzlePositionProvider(battleService.getObjectPool().getObject(MuzzlePositionProvider));
         _loc6_.init(_loc3_,_loc4_);
         _loc5_.init(_loc6_,this.shotgunSFX.shotLightAnimation);
         battleService.addGraphicEffect(_loc5_);
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.shotgunSFX = null;
         if(this.reloadSoundEffect != null)
         {
            this.reloadSoundEffect.kill();
         }
      }
      
      public function onSoundEffectDestroyed(param1:ISound3DEffect) : void
      {
         if(this.reloadSoundEffect == param1)
         {
            this.reloadSoundEffect = null;
         }
      }
   }
}

