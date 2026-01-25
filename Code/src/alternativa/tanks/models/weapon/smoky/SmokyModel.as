package alternativa.tanks.models.weapon.smoky
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.StateCorrectionEvent;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
   import alternativa.tanks.battle.events.TankUnloadedEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.WeaponForces;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
   import alternativa.tanks.models.weapon.smoky.sfx.ISmokySFXModel;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModel;
   import alternativa.tanks.models.weapons.targeting.CommonTargetingSystem;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.smoky.ISmokyModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.smoky.SmokyModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   import alternativa.tanks.models.weapons.targeting.CheatCommonTargetingSystem;
   
   [ModelInfo]
   public class SmokyModel extends SmokyModelBase implements ISmokyModelBase, IWeaponModel, SmokyCallback, BattleEventListener
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private static const MAX_TARGETING_DISTANCE:Number = 1000000;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var weapons:Dictionary = new Dictionary();
      
      private var tanksInBattle:Dictionary = new Dictionary();
      
      private var localWeapon:SmokyWeapon;
      
      public function SmokyModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.activateHandlers();
      }
      
      private static function getWeaponCommonData() : WeaponCommonData
      {
         var _loc1_:IWeaponCommonModel = IWeaponCommonModel(object.adapt(IWeaponCommonModel));
         return _loc1_.getCommonData();
      }
      
      private static function getWeakening() : DistanceWeakening
      {
         var _loc1_:IWeaponWeakeningModel = IWeaponWeakeningModel(object.adapt(IWeaponWeakeningModel));
         return _loc1_.getDistanceWeakening();
      }
      
      private static function getEffects() : ISmokyEffects
      {
         var _loc1_:ISmokySFXModel = ISmokySFXModel(object.adapt(ISmokySFXModel));
         return _loc1_.getEffects();
      }
      
      [Obfuscation(rename="false")]
      public function shoot(param1:IGameObject) : void
      {
         var _loc2_:RemoteSmokyWeapon = this.weapons[param1];
         if(_loc2_ != null)
         {
            _loc2_.simulateShot();
         }
      }
      
      [Obfuscation(rename="false")]
      public function shootStatic(param1:IGameObject, param2:Vector3d) : void
      {
         var _loc3_:RemoteSmokyWeapon = this.weapons[param1];
         if(_loc3_ != null)
         {
            _loc3_.simulateStaticShot(BattleUtils.getVector3(param2));
         }
      }
      
      [Obfuscation(rename="false")]
      public function shootTarget(param1:IGameObject, param2:IGameObject, param3:Vector3d, param4:Number, param5:Boolean) : void
      {
         var _loc7_:Tank = null;
         var _loc8_:Vector3 = null;
         var _loc6_:RemoteSmokyWeapon = this.weapons[param1];
         if(_loc6_ != null)
         {
            _loc7_ = this.tanksInBattle[param2];
            if(_loc7_ != null)
            {
               _loc8_ = BattleUtils.getVector3(param3);
               BattleUtils.localToGlobal(_loc7_.getBody(),_loc8_);
               _loc6_.simulateTargetShot(_loc7_,_loc8_,param4,param5);
            }
         }
      }
      
      [Obfuscation(rename="false")]
      public function localCriticalHit(param1:IGameObject) : void
      {
         var _loc2_:Tank = this.tanksInBattle[param1];
         this.localWeapon.createCriticalHitEffect(_loc2_.getBody().state.position);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:WeaponObject = new WeaponObject(object);
         var targetingSystem:TargetingSystem = new CommonTargetingSystem(param1,_loc2_,MAX_TARGETING_DISTANCE);
         var cheatTargetingSystem:CheatCommonTargetingSystem = new CheatCommonTargetingSystem(param1,_loc2_,MAX_TARGETING_DISTANCE);
         var _loc4_:WeaponCommonData = getWeaponCommonData();
         var _loc5_:WeaponForces = new WeaponForces(_loc4_.getImpactForce(),_loc4_.getRecoilForce());
         this.localWeapon = new SmokyWeapon(_loc2_.getReloadTimeMS(),_loc5_,targetingSystem,cheatTargetingSystem,getWeakening(),getEffects(),SmokyCallback(object.adapt(SmokyCallback)),new SimpleWeaponController());
         this.weapons[param1] = this.localWeapon;
         return this.localWeapon;
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:WeaponCommonData = getWeaponCommonData();
         var _loc3_:WeaponForces = new WeaponForces(_loc2_.getImpactForce(),_loc2_.getRecoilForce());
         var _loc4_:Weapon = new RemoteSmokyWeapon(_loc3_,getEffects());
         this.weapons[param1] = _loc4_;
         return _loc4_;
      }
      
      public function onShot(param1:int) : void
      {
         server.fireCommand(param1);
      }
      
      public function onShotStatic(param1:int, param2:Vector3) : void
      {
         server.fireStaticCommand(param1,BattleUtils.getVector3d(param2));
      }
      
      public function onShotTarget(param1:int, param2:Vector3, param3:Body) : void
      {
         var _loc4_:Tank = param3.tank;
         var _loc5_:Vector3 = param2.clone();
         BattleUtils.globalToLocal(param3,_loc5_);
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         server.fireTargetCommand(param1,_loc4_.getUser(),_loc4_.incarnation,BattleUtils.getVector3d(param3.state.position),BattleUtils.getVector3d(_loc5_),BattleUtils.getVector3d(param2));
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         this.tanksInBattle[param1.tank.getUser()] = param1.tank;
      }
      
      private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void
      {
         delete this.tanksInBattle[param1.tank.getUser()];
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         var _loc2_:Weapon = this.weapons[param1.tank.getUser()];
         if(_loc2_ == this.localWeapon)
         {
            this.localWeapon = null;
         }
         delete this.weapons[param1.tank.getUser()];
      }
   }
}

