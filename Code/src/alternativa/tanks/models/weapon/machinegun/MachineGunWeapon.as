package alternativa.tanks.models.weapon.machinegun
{
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.common.HitInfo;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunSFXData;
   import alternativa.tanks.models.weapons.common.CommonLocalWeapon;
   import alternativa.tanks.models.weapons.stream.StreamWeaponCommunication;
   import alternativa.tanks.models.weapons.targeting.TargetingResult;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.cc.MachineGunCC;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class MachineGunWeapon extends CommonLocalWeapon
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private var gunParams:AllGlobalGunParams;
      
      private var hitInfo:HitInfo = new HitInfo();
      
      private var targetingSystem:TargetingSystem;
      
      private var commonWeapon:MachineGunCommonWeapon;
      
      private var callback:StreamWeaponCommunication;
      
      private var target:Tank;
      
      private var lastTarget:Tank;
      
      private var weapon:WeaponObject;
      
      private var hittingTime:int;
      
      private var temperatureHittingTime:int;
      
      private var params:MachineGunCC;
      
      private var lastTime:int = 0;
      
      private var stopTime:int = 0;
      
      private var lastChangedTargetTime:int;
      
      private var statusUpSpeed:Number = 0;
      
      public function MachineGunWeapon(param1:TargetingSystem, param2:IGameObject, param3:MachineGunCC, param4:MachineGunSFXData, param5:WeaponCommonData, param6:StreamWeaponCommunication, param7:IGameObject)
      {
         this.commonWeapon = new MachineGunCommonWeapon(param2,param3,param4,param5);
         this.targetingSystem = param1;
         this.callback = param6;
         this.weapon = new WeaponObject(param7);
         this.params = param3;
         super(this.weapon);
      }
      
      override public function init(param1:WeaponPlatform) : void
      {
         super.init(param1);
         this.commonWeapon.init(param1);
      }
      
      override public function activate() : void
      {
         super.activate();
         this.commonWeapon.activate();
      }
      
      override protected function start(param1:int) : void
      {
         super.start(param1);
         this.commonWeapon.start();
         this.lastTime = param1;
         this.hittingTime = param1 + this.params.spinUpTime;
         this.temperatureHittingTime = this.hittingTime + this.params.temperatureHittingTime;
         this.gunParams = this.commonWeapon.updateGunParams();
         this.callback.fireStarted(param1);
      }
      
      override protected function stop(param1:int, param2:Boolean) : void
      {
         var _loc3_:Number = this.getStatus();
         super.stop(param1,param2);
         this.commonWeapon.stop();
         var _loc4_:int = this.commonWeapon.state * this.params.spinDownTime;
         this.stopTime = param1 + _loc4_;
         if(_loc4_ == 0)
         {
            this.statusUpSpeed = 0;
         }
         else
         {
            this.statusUpSpeed = (1 - _loc3_) / _loc4_;
         }
         if(param2)
         {
            this.callback.fireStopped(param1);
         }
         this.lastTarget = null;
         this.target = null;
      }
      
      override public function runLogic(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         super.runLogic(param1,param2);
         this.commonWeapon.updateCharacteristicsAndEffects(param2,isShooting());
         if(isShooting())
         {
            this.gunParams = this.commonWeapon.updateGunParams();
            _loc3_ = this.calculateTargets();
            _loc4_ = this.commonWeapon.getPowerCoeff(param2,this.lastTime,this.hittingTime);
            if(_loc4_ > 0)
            {
               this.commonWeapon.addRecoilForShooter(this.gunParams.direction,_loc4_);
               _loc5_ = BattleUtils.isTurretAboveGround(this.getWeaponPlatform().getBody(),this.gunParams);
               if(_loc5_ && this.target != null && this.target.getUser() != null)
               {
                  this.commonWeapon.addImpactForTarget(this.hitInfo.body,this.hitInfo.position,this.gunParams.direction,_loc4_);
               }
               else
               {
                  this.target = null;
               }
               if(this.target != this.lastTarget || param1 > this.lastChangedTargetTime + 250)
               {
                  if(_loc5_)
                  {
                     this.callback.targetUpdate(param1,this.hitInfo.direction,this.target,this.hitInfo.position);
                  }
                  else
                  {
                     this.callback.targetsUpdateDummy(param1,this.gunParams.direction);
                  }
                  this.lastChangedTargetTime = param1;
               }
            }
            if(_loc3_)
            {
               this.commonWeapon.setTargetPosition(this.hitInfo.position,this.target != null);
            }
            else
            {
               this.commonWeapon.clearTargetPosition();
            }
         }
         this.lastTime = param1;
      }
      
      private function calculateTargets() : Boolean
      {
         var _loc2_:RayHit = null;
         if(this.commonWeapon.state < 1)
         {
            return false;
         }
         var _loc1_:TargetingResult = this.targetingSystem.target(this.gunParams);
         this.hitInfo.setResult(this.gunParams,_loc1_);
         this.lastTarget = this.target;
         if(_loc1_.hasTankHit())
         {
            _loc2_ = _loc1_.getSingleHit();
            this.target = _loc2_.shape.body.tank;
         }
         else
         {
            this.target = null;
         }
         return _loc1_.hasAnyHit();
      }
      
      override public function getStatus() : Number
      {
         if(isShooting())
         {
            return Math.max(Math.min((this.temperatureHittingTime - this.lastTime) / this.params.temperatureHittingTime,1),0);
         }
         return 1 - Math.max(this.stopTime - this.lastTime,0) * this.statusUpSpeed;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.commonWeapon.reset();
         this.target = this.lastTarget = null;
      }
      
      override protected function canStart() : Boolean
      {
         return this.lastTime >= this.stopTime;
      }
      
      override public function getWeaponPlatform() : WeaponPlatform
      {
         return super.getWeaponPlatform();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.callback = null;
         this.params = null;
         this.weapon = null;
         this.targetingSystem = null;
         this.commonWeapon.destroy();
      }
      
      override public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.MACHINE_GUN_RESISTANCE;
      }
   }
}

