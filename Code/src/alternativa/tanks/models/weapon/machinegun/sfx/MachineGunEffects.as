package alternativa.tanks.models.weapon.machinegun.sfx
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.models.weapon.machinegun.sfx.sound.MachineGunSoundManager;
   import alternativa.tanks.sfx.MuzzlePositionProvider;
   import alternativa.tanks.sfx.OmniStreamLightEffect;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.utils.objectpool.ObjectPool;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.cc.MachineGunCC;
   import alternativa.tanks.battle.objects.tank.tankskin.dynamic.DynamicSkin;
   import alternativa.tanks.battle.objects.tank.tankskin.TankTurretDynamicSkin;
   
   public class MachineGunEffects
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const HIT_EFFECT_INTERVAL:Number = 0.1;
      private static const HIT_EFFECT_OFFSET_TO_CAMERA:Number = 50;
      
      private static const BARREL_MIN_SPEED:Number = 0.001;
      private static const BARREL_MAX_SPEED:Number = 15;

      private static const BAND_STEP:Number = 0.59;
      private static const BAND_STEP_TIME:Number = 0.1;

      private static const POW:Number = 3;
      
      private const targetPosition:Vector3 = new Vector3();
      
      private var spinUpTime:Number;
      
      private var spinDownTime:Number;
      
      private var sfxData:MachineGunSFXData;
      
      private var turret:Object3D;
      
      private var localMuzzlePoint:Vector3;
      
      private var shotEffect:MachineGunShotEffect;
      
      private var fireLightEffect:OmniStreamLightEffect;
      
      private var soundManager:MachineGunSoundManager;
      
      private var hasHit:Boolean = false;
      
      private var isHitInTank:Boolean;
      
      private var hitEffectTime:Number;
      
      private var tankSkin:TankSkin;
      
      private var wasShooting:Boolean = false;

      private var barrelSkin:DynamicSkin;
      private var muzzleSkin:DynamicSkin;
      private var bandSkin:DynamicSkin;
      private var bandMSkin:DynamicSkin;

      private var bandTime:Number = 0;
      
      public function MachineGunEffects(param1:WeaponPlatform, param2:MachineGunCC, param3:MachineGunSFXData)
      {
         super();
         var _loc4_:TankSkin = param1.getSkin();
         var _loc5_:TankTurretDynamicSkin = _loc4_.getTurretDynamicSkin();
         this.tankSkin = _loc4_;
         this.turret = _loc4_.getTurret3D();
         this.spinUpTime = param2.spinUpTime;
         this.spinDownTime = param2.spinDownTime;
         this.localMuzzlePoint = param1.getLocalMuzzlePosition();
         this.sfxData = param3;
         this.barrelSkin = _loc5_.barrelSkin;
         this.muzzleSkin = _loc5_.muzzleSkin;
         this.bandSkin = _loc5_.bandSkin;
         this.bandMSkin = _loc5_.bandMSkin;
         this.soundManager = new MachineGunSoundManager(this.turret,param3,this.spinUpTime);
         this.hitEffectTime = 0;
      }
      
      public function setTargetPosition(param1:Vector3, param2:Boolean) : void
      {
         this.hasHit = true;
         this.isHitInTank = param2;
         this.targetPosition.copy(param1);
         this.soundManager.playHitSound(param1,param2);
         if(this.shotEffect != null)
         {
            this.shotEffect.setTargetPosition(param1,param2);
         }
      }
      
      public function clearTargetPosition(param1:Boolean) : void
      {
         this.hasHit = false;
         this.soundManager.stopHitSounds();
         if(this.shotEffect != null)
         {
            this.shotEffect.clearTargetPosition(param1);
         }
      }
      
      public function update(param1:int, param2:Number, param3:Boolean) : void
      {
         this.playSound(param2,param3);
         var _loc4_:Boolean = param2 == 1;
         var _loc5_:Number = param1 / 1000;
         this.hitEffectTime += _loc5_;
         if(_loc4_)
         {
            this.updateEffectsForShooting(_loc5_);
         }
         else
         {
            this.destroyEffects();
         }
         this.updateBarrelSkin(_loc5_,param2);
      }
      
      public function destroy() : void
      {
         this.destroyMuzzleFlashGraphicEffect();
         this.destroyFireLightEffect();
         this.soundManager.destroy();
         this.soundManager = null;
         this.localMuzzlePoint = null;
         this.turret = null;
         this.sfxData = null;
         this.tankSkin = null;
         this.barrelSkin = null;
         this.muzzleSkin = null;
         this.bandSkin = null;
         this.bandMSkin = null;
      }
      
      private function playSound(param1:Number, param2:Boolean) : void
      {
         if(param2)
         {
            if(param1 == 1)
            {
               this.soundManager.playShootSound();
               this.wasShooting = true;
            }
            else
            {
               this.soundManager.playBeginSound(this.spinUpTime * param1);
            }
         }
         else if(param1 == 0)
         {
            this.wasShooting = false;
            this.soundManager.stopSound();
         }
         else if(this.wasShooting)
         {
            this.soundManager.playEndSound();
         }
         else
         {
            this.soundManager.playEndFailSound(param1 * this.spinDownTime);
         }
      }
      
      private function updateEffectsForShooting(param1:Number) : void
      {
         this.createShotEffect();
         this.createFireLightEffect();
         if(this.hasHit && this.hitEffectTime >= HIT_EFFECT_INTERVAL)
         {
            this.hitEffectTime = 0;
            this.createHitGraphicEffect();
         }
         this.bandTime += param1;
         var _loc2_:Number = this.bandTime % BAND_STEP_TIME;
         var _loc3_:int = this.bandTime / BAND_STEP_TIME;
         var _loc4_:Number = _loc3_ * BAND_STEP + BAND_STEP * this.ease(_loc2_ / BAND_STEP_TIME,POW);
         this.bandSkin.reset();
         this.bandMSkin.reset();
         this.bandSkin.rotate(_loc4_ % BAND_STEP);
         this.bandMSkin.rotate(-_loc4_ * 0.7);
      }

      private function ease(param1:Number, param2:Number) : Number
      {
         if(param1 < 0.5)
         {
            param1 *= 2;
            param1 = Math.pow(param1,param2);
            return param1 / 2;
         }
         param1 = 1 - (param1 - 0.5) * 2;
         param1 = Math.pow(param1,param2);
         return (1 - param1) / 2 + 0.5;
      }
      
      private function createShotEffect() : void
      {
         if(this.shotEffect == null)
         {
            this.shotEffect = MachineGunShotEffect(battleService.getObjectPool().getObject(MachineGunShotEffect));
            this.shotEffect.init(this.turret,this.localMuzzlePoint,this.sfxData);
            battleService.addGraphicEffect(this.shotEffect);
         }
      }
      
      private function createFireLightEffect() : void
      {
         var _loc1_:ObjectPool = null;
         var _loc2_:MuzzlePositionProvider = null;
         if(this.fireLightEffect == null)
         {
            _loc1_ = battleService.getObjectPool();
            this.fireLightEffect = OmniStreamLightEffect(_loc1_.getObject(OmniStreamLightEffect));
            _loc2_ = MuzzlePositionProvider(_loc1_.getObject(MuzzlePositionProvider));
            _loc2_.init(this.turret,this.localMuzzlePoint);
            this.fireLightEffect.init(_loc2_,this.sfxData.fireStartLightAnimation,this.sfxData.fireLoopLightAnimation);
            battleService.addGraphicEffect(this.fireLightEffect);
         }
      }
      
      private function createHitGraphicEffect() : void
      {
         var _loc1_:StaticObject3DPositionProvider = null;
         var _loc2_:MachineGunHitEffect = null;
         if(!this.isHitInTank)
         {
            _loc1_ = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
            _loc1_.init(this.targetPosition,HIT_EFFECT_OFFSET_TO_CAMERA);
            _loc2_ = MachineGunHitEffect(battleService.getObjectPool().getObject(MachineGunHitEffect));
            _loc2_.init(_loc1_,this.sfxData);
            battleService.addGraphicEffect(_loc2_);
         }
      }
      
      private function destroyEffects() : void
      {
         this.clearTargetPosition(false);
         this.destroyMuzzleFlashGraphicEffect();
         this.destroyFireLightEffect();
         this.bandTime = 0;
      }
      
      private function destroyMuzzleFlashGraphicEffect() : void
      {
         if(this.shotEffect != null)
         {
            this.shotEffect.stop();
            this.shotEffect = null;
         }
      }
      
      private function destroyFireLightEffect() : void
      {
         if(this.fireLightEffect != null)
         {
            this.fireLightEffect.stop();
            this.fireLightEffect = null;
         }
      }

      private function updateBarrelSkin(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = BARREL_MAX_SPEED * param2;
         if(_loc3_ > BARREL_MIN_SPEED)
         {
            this.barrelSkin.rotate(_loc3_ * param1);
            this.muzzleSkin.rotate(_loc3_ * param1);
         }
      }  
   }
}

