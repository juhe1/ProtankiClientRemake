package alternativa.tanks.models.weapon.railgun
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
   import alternativa.tanks.models.weapons.targeting.PenetratingTargetingSystem;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.IRailgunModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   [ModelInfo]
   public class RailgunModel extends RailgunModelBase implements IRailgunModelBase, ObjectLoadListener, IWeaponModel, BattleEventListener, RailgunCallback
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private var weapons:Dictionary = new Dictionary();
      
      private var tanksOnField:Dictionary = new Dictionary();
      
      private var battleEventSupport:BattleEventSupport;
      
      private var localWeapon:RailgunWeapon;
      
      public function RailgunModel()
      {
         super();
         this.initBattleEventListeners();
      }
      
      private static function getWeaponCommonData() : WeaponCommonData
      {
         var _loc1_:IWeaponCommonModel = IWeaponCommonModel(object.adapt(IWeaponCommonModel));
         return _loc1_.getCommonData();
      }
      
      private static function getWeaponObject() : WeaponObject
      {
         return new WeaponObject(object);
      }
      
      private static function getEffects() : IRailgunEffects
      {
         var _loc1_:IRailgunSFXModel = IRailgunSFXModel(object.adapt(IRailgunSFXModel));
         return _loc1_.getEffects();
      }
      
      private static function convertHitPoints(param1:Vector.<Vector3d>) : Vector.<Vector3>
      {
         var _loc2_:Vector.<Vector3> = null;
         var _loc3_:int = 0;
         var _loc4_:Vector3d = null;
         if(param1 != null)
         {
            _loc2_ = new Vector.<Vector3>(param1.length);
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc4_ = param1[_loc3_];
               if(!BattleUtils.isFiniteVector3d(_loc4_))
               {
                  return null;
               }
               _loc2_[_loc3_] = BattleUtils.getVector3(_loc4_);
               _loc3_++;
            }
            return _loc2_;
         }
         return null;
      }
      
      private static function convertTargets(param1:Vector.<IGameObject>, param2:Dictionary) : Vector.<Body>
      {
         var _loc3_:Vector.<Body> = null;
         var _loc4_:int = 0;
         var _loc5_:Tank = null;
         if(param1 != null)
         {
            _loc3_ = new Vector.<Body>(param1.length);
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc5_ = param2[param1[_loc4_]];
               if(_loc5_ == null)
               {
                  _loc3_[_loc4_] = null;
               }
               else
               {
                  _loc3_[_loc4_] = _loc5_.getBody();
               }
               _loc4_++;
            }
            return _loc3_;
         }
         return null;
      }
      
      private function initBattleEventListeners() : void
      {
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.activateHandlers();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:RailgunCC = getInitParam();
         putData(RailgunData,new RailgunData(_loc1_.chargingTimeMsec,_loc1_.weakeningCoeff));
      }
      
      [Obfuscation(rename="false")]
      public function startCharging(param1:IGameObject) : void
      {
         var _loc2_:RemoteRailgunWeapon = this.weapons[param1];
         if(_loc2_ != null)
         {
            _loc2_.startCharging();
         }
      }
      
      [Obfuscation(rename="false")]
      public function fire(param1:IGameObject, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>) : void
      {
         var _loc6_:Vector.<Vector3> = null;
         var _loc7_:Vector.<Body> = null;
         var _loc8_:int = 0;
         var _loc9_:Body = null;
         var _loc5_:RemoteRailgunWeapon = this.weapons[param1];
         if(_loc5_ != null)
         {
            _loc6_ = convertHitPoints(param4);
            if(_loc6_ != null)
            {
               _loc7_ = convertTargets(param3,this.tanksOnField);
               if(param3 != null)
               {
                  if(param3.length == _loc6_.length)
                  {
                     _loc8_ = 0;
                     while(_loc8_ < param3.length)
                     {
                        _loc9_ = _loc7_[_loc8_];
                        if(_loc9_ != null && _loc9_.tank != null)
                        {
                           BattleUtils.localToGlobal(_loc9_,_loc6_[_loc8_]);
                        }
                        _loc8_++;
                     }
                  }
                  else
                  {
                     param3 = null;
                     _loc6_ = null;
                  }
               }
            }
            _loc5_.fire(BattleUtils.getVector3OrNull(param2),_loc7_,_loc6_);
         }
      }
      
      [Obfuscation(rename="false")]
      public function fireDummy(param1:IGameObject) : void
      {
         var _loc2_:RemoteRailgunWeapon = this.weapons[param1];
         if(_loc2_ != null)
         {
            _loc2_.fireDummy();
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:WeaponCommonData = getWeaponCommonData();
         var _loc3_:WeaponObject = getWeaponObject();
         var _loc4_:RailgunData = RailgunData(getData(RailgunData));
         var _loc5_:IRailgunEffects = getEffects();
         var _loc6_:TargetingSystem = new PenetratingTargetingSystem(param1,_loc3_,_loc4_.getWeakeningCoeff());
         var _loc7_:WeaponForces = new WeaponForces(_loc2_.getImpactForce(),_loc2_.getRecoilForce());
         this.localWeapon = new RailgunWeapon(_loc6_,new SimpleWeaponController(),_loc3_.getReloadTimeMS(),_loc7_,_loc4_.getWeakeningCoeff(),_loc4_.getChargingTime(),_loc5_,RailgunCallback(object.adapt(RailgunCallback)));
         this.weapons[param1] = this.localWeapon;
         return this.localWeapon;
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:WeaponCommonData = getWeaponCommonData();
         var _loc3_:RailgunData = RailgunData(getData(RailgunData));
         var _loc4_:IRailgunEffects = getEffects();
         var _loc5_:WeaponForces = new WeaponForces(_loc2_.getImpactForce(),_loc2_.getRecoilForce());
         var _loc6_:Weapon = new RemoteRailgunWeapon(_loc5_,_loc3_,_loc4_);
         this.weapons[param1] = _loc6_;
         return _loc6_;
      }
      
      public function onStartCharging(param1:int) : void
      {
         server.startChargingCommand(param1);
      }
      
      public function onShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>) : void
      {
         var _loc5_:Vector.<IGameObject> = null;
         var _loc6_:Vector.<Vector3d> = null;
         var _loc7_:Vector.<int> = null;
         var _loc8_:Vector.<Vector3d> = null;
         var _loc10_:Vector.<Vector3d> = null;
         var _loc12_:int = 0;
         var _loc13_:Body = null;
         var _loc14_:Vector3 = null;
         var _loc15_:Vector3 = null;
         var _loc16_:Tank = null;
         var _loc9_:int = int(param3.length);
         if(_loc9_ > 0)
         {
            _loc5_ = new Vector.<IGameObject>(_loc9_);
            _loc6_ = new Vector.<Vector3d>(_loc9_);
            _loc7_ = new Vector.<int>(_loc9_);
            _loc8_ = new Vector.<Vector3d>(_loc9_);
            _loc10_ = new Vector.<Vector3d>(_loc9_);
            _loc12_ = 0;
            while(_loc12_ < _loc9_)
            {
               _loc13_ = param3[_loc12_];
               _loc14_ = param4[_loc12_];
               _loc15_ = new Vector3();
               _loc15_.copy(_loc14_);
               BattleUtils.globalToLocal(_loc13_,_loc14_);
               _loc16_ = _loc13_.tank;
               _loc7_[_loc12_] = _loc16_.incarnation;
               _loc5_[_loc12_] = _loc16_.getUser();
               _loc6_[_loc12_] = BattleUtils.getVector3d(_loc14_);
               _loc8_[_loc12_] = BattleUtils.getVector3d(_loc13_.state.position);
               _loc10_[_loc12_] = BattleUtils.getVector3d(_loc15_);
               _loc12_++;
            }
         }
         var _loc11_:Vector3d = BattleUtils.getVector3dOrNull(param2);
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         server.fireCommand(param1,_loc11_,_loc5_,_loc6_,_loc7_,_loc8_,_loc10_);
      }
      
      public function onShotDummy(param1:int) : void
      {
         server.fireDummyCommand(param1);
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         this.tanksOnField[param1.tank.getUser()] = param1.tank;
      }
      
      private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void
      {
         delete this.tanksOnField[param1.tank.getUser()];
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         delete this.tanksOnField[param1.tank.getUser()];
      }
      
      public function immediateReload() : void
      {
         this.localWeapon.immediateReload();
      }
   }
}

