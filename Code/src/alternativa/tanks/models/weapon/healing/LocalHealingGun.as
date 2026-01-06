package alternativa.tanks.models.weapon.healing
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.LogicUnit;
   import alternativa.tanks.battle.objects.tank.LocalWeapon;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.BasicGlobalGunParams;
   import alternativa.tanks.models.weapon.healing.targeting.IsisDirectionCalculator;
   import alternativa.tanks.models.weapon.healing.targeting.IsisTargetPriorityCalculator;
   import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
   import alternativa.tanks.models.weapons.targeting.TargetingResult;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
   import alternativa.tanks.models.weapons.targeting.processor.SingleTargetDirectionProcessor;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import flash.utils.getTimer;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class LocalHealingGun extends BattleRunnerProvider implements Weapon, LocalWeapon, HealingGun, LogicUnit
   {
      
      private static const MINIMAL_UPDATE_HIT_TIME_MS:int = 250;
      
      private static const thousand:EncryptedInt = new EncryptedIntImpl(1000);
      
      private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private static const basicGunParams:BasicGlobalGunParams = new BasicGlobalGunParams();
      
      private static const localHitPoint:Vector3 = new Vector3();
      
      private static const bonusDirection:Vector3 = new Vector3();
      
      private static const rotationMatrix:Matrix3 = new Matrix3();
      
      private var controller:SimpleWeaponController;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var callback:HealingGunCallback;
      
      private var effects:HealingGunEffects;
      
      private var targetingSystem:TargetingSystem;
      
      private var isisCC:IsisCC;
      
      private var shooting:Boolean;
      
      private var triggerPulled:Boolean;
      
      private var enabled:Boolean;
      
      private var baseTime:int;
      
      private var state:IsisState;
      
      private var nextTickTime:EncryptedInt = new EncryptedIntImpl();
      
      private var numTicksLeft:EncryptedInt = new EncryptedIntImpl();
      
      private var currentTarget:Body;
      
      private var turretController:TurretController;
      
      private var currentRayHit:RayHit;
      
      private var updateHitTime:int;
      
      private var isisTargetPriorityCalculator:IsisTargetPriorityCalculator;
      
      private var isisDirectionCalculator:IsisDirectionCalculator;
      
      public function LocalHealingGun(param1:IGameObject, param2:IsisCC, param3:SimpleWeaponController, param4:HealingGunEffects, param5:HealingGunCallback)
      {
         super();
         this.isisTargetPriorityCalculator = new IsisTargetPriorityCalculator(param2);
         this.isisDirectionCalculator = new IsisDirectionCalculator(param2.coneAngle);
         this.targetingSystem = new TargetingSystem(this.isisDirectionCalculator,new SingleTargetDirectionProcessor(param1,param2.radius),new TargetingPriorityCalculator(this.isisTargetPriorityCalculator));
         this.targetingSystem.getProcessor().setShotFromMuzzle();
         this.controller = param3;
         this.callback = param5;
         this.effects = param4;
         this.isisCC = param2;
         this.turretController = this.turretController;
      }
      
      private static function getEffectType(param1:Tank, param2:Tank) : IsisState
      {
         return param1.isSameTeam(param2.teamType) ? IsisState.HEALING : IsisState.DAMAGING;
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
         this.effects.init(param1.getTurret3D(),param1.getLocalMuzzlePosition());
         this.controller.init();
         this.controller.setWeapon(this);
      }
      
      public function destroy() : void
      {
         this.targetingSystem = null;
         this.effects = null;
         this.callback = null;
         this.deactivate();
         this.controller.destroy();
         this.turretController = null;
      }
      
      public function activate() : void
      {
         getBattleRunner().addLogicUnit(this);
      }
      
      public function deactivate() : void
      {
         this.disable(false);
         getBattleRunner().removeLogicUnit(this);
      }
      
      public function enable() : void
      {
         if(!this.enabled)
         {
            this.enabled = true;
            this.triggerPulled = this.controller.isTriggerPulled();
         }
      }
      
      public function disable(param1:Boolean) : void
      {
         if(this.enabled)
         {
            this.enabled = false;
            this.stop(getBattleRunner().getPhysicsTime(),param1);
         }
      }
      
      public function reset() : void
      {
         this.isisTargetPriorityCalculator.resetTarget();
         this.currentTarget = null;
         this.shooting = false;
         this.triggerPulled = false;
         this.baseTime = 0;
         this.numTicksLeft.setInt(0);
         this.nextTickTime.setInt(0);
         this.state = IsisState.OFF;
      }
      
      public function getStatus() : Number
      {
         var _loc1_:Number = NaN;
         if(this.shooting)
         {
            _loc1_ = this.getCurrentEnergyInShootingMode(getTimer(),this.state);
         }
         else
         {
            _loc1_ = this.getCurrentEnergyInIdleMode(getTimer());
         }
         return _loc1_ / this.isisCC.capacity;
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         if(this.enabled)
         {
            if(this.shooting)
            {
               this.runLogicForShootingMode(param1);
            }
            else
            {
               this.runLogicForIdleMode(param1);
            }
         }
      }
      
      private function runLogicForShootingMode(param1:int) : void
      {
         var _loc2_:Body = null;
         if(this.triggerPulled)
         {
            this.weaponPlatform.getAllGunParams(allGunParams);
            if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),allGunParams))
            {
               this.currentRayHit = this.target();
               _loc2_ = Boolean(this.currentRayHit) ? this.currentRayHit.shape.body : null;
            }
            else
            {
               this.currentRayHit = null;
               _loc2_ = null;
            }
            if(_loc2_ != this.currentTarget)
            {
               this.currentTarget = _loc2_;
               this.changeTargetAndNotifyCallback(param1);
            }
            else if(this.currentTarget != null)
            {
               if(this.updateHitTime + MINIMAL_UPDATE_HIT_TIME_MS <= param1)
               {
                  this.updateHit(param1);
               }
               this.setupEffectsForTarget();
            }
            this.tryToTick(param1);
            this.tryToStop(param1);
         }
         else
         {
            this.stop(param1,true);
         }
      }
      
      private function tryToStop(param1:int) : void
      {
         if(this.numTicksLeft.getInt() == 0 && this.getCurrentEnergyInShootingMode(param1,this.state) <= 0)
         {
            this.stop(param1,true);
         }
      }
      
      private function tryToTick(param1:int) : void
      {
         if(this.numTicksLeft.getInt() > 0)
         {
            if(param1 >= this.nextTickTime.getInt())
            {
               this.numTicksLeft.setInt(this.numTicksLeft.getInt() - 1);
               this.tick(param1);
            }
         }
      }
      
      private function runLogicForIdleMode(param1:int) : void
      {
         if(this.triggerPulled)
         {
            this.start(param1);
         }
      }
      
      public function pullTrigger() : void
      {
         if(this.enabled)
         {
            this.triggerPulled = true;
         }
      }
      
      public function releaseTrigger() : void
      {
         this.triggerPulled = false;
      }
      
      public function onTargetLost(param1:Tank) : void
      {
         if(param1 != null)
         {
            if(this.currentTarget == param1.getBody())
            {
               this.currentTarget = null;
               this.changeTarget(getBattleRunner().getPhysicsTime());
            }
         }
      }
      
      private function changeTargetAndNotifyCallback(param1:int) : void
      {
         this.changeTarget(param1);
         this.updateHit(param1);
      }
      
      private function updateHit(param1:int) : void
      {
         this.updateHitTime = param1;
         this.callback.updateHit(param1,this.currentRayHit);
      }
      
      private function changeTarget(param1:int) : void
      {
         var _loc3_:Tank = null;
         var _loc2_:IsisState = this.state;
         if(this.currentTarget == null)
         {
            this.state = IsisState.IDLE;
         }
         else
         {
            _loc3_ = this.weaponPlatform.getBody().tank;
            if(getEffectType(_loc3_,this.currentTarget.tank) == IsisState.HEALING)
            {
               this.state = IsisState.HEALING;
            }
            else
            {
               this.state = IsisState.DAMAGING;
            }
         }
         this.baseTime = this.getBaseTimeInShootingMode(param1,this.getCurrentEnergyInShootingMode(param1,_loc2_),this.state);
         if(this.currentTarget == null)
         {
            this.loseTarget();
         }
         else
         {
            this.onNewTarget(param1);
         }
      }
      
      private function loseTarget() : void
      {
         this.effects.setLocalEffectsType(IsisState.IDLE);
         this.isisTargetPriorityCalculator.resetTarget();
         this.numTicksLeft.setInt(0);
      }
      
      private function onNewTarget(param1:int) : void
      {
         this.calculateNumTicks(param1);
         this.setNextTickTime(param1);
         this.setupEffectsForTarget();
      }
      
      private function setupEffectsForTarget() : void
      {
         var _loc1_:Tank = this.currentTarget.tank;
         var _loc2_:Tank = this.weaponPlatform.getBody().tank;
         localHitPoint.copy(this.currentRayHit.position);
         BattleUtils.globalToLocal(this.currentTarget,localHitPoint);
         this.effects.setLocalEffectsType(getEffectType(_loc2_,_loc1_),_loc1_,localHitPoint);
      }
      
      private function setNextTickTime(param1:int) : void
      {
         this.nextTickTime.setInt(param1 + this.isisCC.checkPeriodMsec);
      }
      
      private function calculateNumTicks(param1:int) : void
      {
         var _loc2_:Number = this.getCurrentEnergyInShootingMode(param1,this.state);
         this.numTicksLeft.setInt(thousand.getInt() * _loc2_ / (this.getEnergyDrainRate(this.state) * this.isisCC.checkPeriodMsec));
      }
      
      private function getEnergyDrainRate(param1:IsisState) : int
      {
         switch(param1)
         {
            case IsisState.DAMAGING:
               return this.isisCC.dischargeDamageRate;
            case IsisState.HEALING:
               return this.isisCC.dischargeHealingRate;
            case IsisState.IDLE:
               return this.isisCC.dischargeIdleRate;
            default:
               return 0;
         }
      }
      
      private function tick(param1:int) : void
      {
         this.nextTickTime.setInt(param1 + this.isisCC.checkPeriodMsec);
         this.weaponPlatform.getBasicGunParams(basicGunParams);
         this.callback.onTick(param1,this.currentRayHit);
      }
      
      private function start(param1:int) : void
      {
         if(!this.shooting)
         {
            this.shooting = true;
            this.currentRayHit = this.target();
            this.currentTarget = Boolean(this.currentRayHit) ? this.currentRayHit.shape.body : null;
            this.baseTime = this.getBaseTimeInShootingMode(param1,this.getCurrentEnergyInIdleMode(param1),this.state);
            this.changeTargetAndNotifyCallback(param1);
         }
      }
      
      private function stop(param1:int, param2:Boolean) : void
      {
         if(this.shooting)
         {
            this.isisTargetPriorityCalculator.resetTarget();
            this.currentTarget = null;
            this.triggerPulled = false;
            this.shooting = false;
            this.baseTime = this.getBaseTimeInIdleMode(param1,this.getCurrentEnergyInShootingMode(param1,this.state));
            this.numTicksLeft.setInt(0);
            this.effects.stopEffects();
            if(param2)
            {
               this.callback.stop(param1);
            }
         }
      }
      
      private function getCurrentEnergyInIdleMode(param1:int) : Number
      {
         var _loc2_:Number = this.isisCC.capacity;
         var _loc3_:Number = this.isisCC.chargeRate * (param1 - this.baseTime) / thousand.getInt();
         return _loc3_ > _loc2_ ? _loc2_ : _loc3_;
      }
      
      private function getCurrentEnergyInShootingMode(param1:int, param2:IsisState) : Number
      {
         var _loc3_:Number = this.isisCC.capacity - this.getEnergyDrainRate(param2) * (param1 - this.baseTime) / thousand.getInt();
         return _loc3_ < 0 ? 0 : Math.min(_loc3_,this.isisCC.capacity);
      }
      
      private function getBaseTimeInIdleMode(param1:int, param2:Number) : int
      {
         return param1 - param2 / this.isisCC.chargeRate * thousand.getInt();
      }
      
      private function getBaseTimeInShootingMode(param1:int, param2:Number, param3:IsisState) : int
      {
         return param1 - (this.isisCC.capacity - param2) / this.getEnergyDrainRate(param3) * thousand.getInt();
      }
      
      private function target() : RayHit
      {
         var _loc2_:RayHit = null;
         var _loc3_:Tank = null;
         this.weaponPlatform.getAllGunParams(allGunParams);
         if(this.currentTarget != null)
         {
            this.initTurretRotationMatrix();
            bonusDirection.transform3(rotationMatrix);
            this.isisDirectionCalculator.setBonusDirection(bonusDirection);
         }
         else
         {
            this.isisDirectionCalculator.resetBonusDirection();
         }
         var _loc1_:TargetingResult = this.targetingSystem.target(allGunParams);
         this.calculateLocalBonusDirection(_loc1_);
         if(_loc1_.hasTankHit())
         {
            _loc2_ = _loc1_.getSingleHit();
            _loc3_ = _loc2_.shape.body.tank;
            if(_loc3_.health == 0)
            {
               return null;
            }
            this.isisTargetPriorityCalculator.setTarget(_loc3_);
            return _loc1_.getSingleHit();
         }
         return null;
      }
      
      private function calculateLocalBonusDirection(param1:TargetingResult) : void
      {
         bonusDirection.copy(param1.getDirection());
         this.initTurretRotationMatrix();
         bonusDirection.transformTransposed3(rotationMatrix);
      }
      
      private function initTurretRotationMatrix() : void
      {
         var _loc1_:Object3D = this.weaponPlatform.getTurret3D();
         rotationMatrix.setRotationMatrix(_loc1_.rotationX,_loc1_.rotationY,_loc1_.rotationZ);
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.ISIS_RESISTANCE;
      }
      
      public function addEnergy(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.shooting)
         {
            _loc3_ = this.getEnergyDrainRate(this.state);
            _loc2_ = param1 / _loc3_ * 1000;
            _loc4_ = _loc2_ / this.isisCC.checkPeriodMsec;
            this.numTicksLeft.setInt(this.numTicksLeft.getInt() + _loc4_);
            this.baseTime += _loc2_;
         }
         else
         {
            _loc2_ = param1 / this.isisCC.chargeRate * 1000;
            this.baseTime -= _loc2_;
         }
      }
   }
}

