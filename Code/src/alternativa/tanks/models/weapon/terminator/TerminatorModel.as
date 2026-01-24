package alternativa.tanks.models.weapon.terminator
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
   import alternativa.tanks.battle.objects.tank.tankskin.terminator.TerminatorTurretSkin;
   import alternativa.tanks.battle.objects.tank.tankskin.turret.CustomTurretSkin;
   import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkin;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.WeaponForces;
   import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.railgun.RailgunData;
   import alternativa.tanks.models.weapons.shell.TargetShellWeaponListener;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.terminator.ITerminatorModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.terminator.TerminatorModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   [ModelInfo]
   public class TerminatorModel extends TerminatorModelBase implements TargetShellWeaponListener, ITerminatorModelBase, BattleEventListener, ObjectLoadListener, CustomTurretSkin, TerminatorSkin, IWeaponModel, Terminator
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var tanksOnField:Dictionary = new Dictionary();
      
      public function TerminatorModel()
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
         return IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getCommonData();
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
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:RocketLauncherCC = getInitParam().secondaryCC;
         _loc1_.minSpeed = BattleUtils.toClientScale(_loc1_.minSpeed);
         _loc1_.maxSpeed = BattleUtils.toClientScale(_loc1_.maxSpeed);
         _loc1_.shellRadius = BattleUtils.toClientScale(_loc1_.shellRadius);
         _loc1_.shotRange = BattleUtils.toClientScale(_loc1_.shotRange);
         var _loc2_:RailgunCC = getInitParam().primaryCC;
         putData(RailgunData,new RailgunData(_loc2_.chargingTimeMsec,_loc2_.weakeningCoeff));
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:TerminatorObject = new TerminatorObject(object);
         return new TerminatorWeapon(RailgunData(getData(RailgunData)),this.createCommonWeapon(param1,_loc2_));
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:TerminatorObject = new TerminatorObject(object);
         _loc2_.markAsRemote();
         var _loc3_:* = RailgunData(getData(RailgunData));
         var _loc4_:* = getWeaponCommonData();
         var _loc5_:* = new WeaponForces(_loc4_.getImpactForce(),_loc4_.getRecoilForce());
         var _loc6_:* = new RemoteTerminatorWeapon(this.createCommonWeapon(param1,_loc2_),_loc5_,_loc3_);
         putData(RemoteTerminatorWeapon,_loc6_);
         return _loc6_;
      }
      
      private function createCommonWeapon(param1:IGameObject, param2:TerminatorObject) : TerminatorCommonWeapon
      {
         return new TerminatorCommonWeapon(object,param1,param2,getInitParam());
      }
      
      private function remoteWeapon() : RemoteTerminatorWeapon
      {
         return RemoteTerminatorWeapon(getData(RemoteTerminatorWeapon));
      }
      
      public function createSkin(param1:Tanks3DSResource) : TurretSkin
      {
         var _loc2_:TerminatorTurretSkin = new TerminatorTurretSkin(param1);
         putData(TerminatorTurretSkin,_loc2_);
         return _loc2_;
      }
      
      public function getSkin() : TerminatorTurretSkin
      {
         return TerminatorTurretSkin(getData(TerminatorTurretSkin));
      }
      
      public function onShotWithTarget(param1:int, param2:int, param3:Vector3, param4:Tank, param5:Vector3) : void
      {
         this.remoteWeapon().secondaryShoot(param1,param3,param4,param5);
      }
      
      public function onDummyShot(param1:int) : void
      {
         this.remoteWeapon().secondaryDummyShoot(param1);
      }
      
      public function secondaryOpen(param1:int) : void
      {
         server.secondaryOpen(param1);
      }
      
      public function secondaryHide(param1:int) : void
      {
         server.secondaryHide(param1);
      }
      
      public function primaryCharge(param1:int, param2:int) : void
      {
         server.primaryCharge(param1,param2);
      }
      
      public function primaryShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>, param5:int) : void
      {
         var _loc6_:Vector.<IGameObject> = null;
         var _loc7_:Vector.<Vector3d> = null;
         var _loc8_:Vector.<int> = null;
         var _loc9_:Vector.<Vector3d> = null;
         var _loc11_:Vector.<Vector3d> = null;
         var _loc13_:int = 0;
         var _loc14_:Body = null;
         var _loc15_:Vector3 = null;
         var _loc16_:Vector3 = null;
         var _loc17_:Tank = null;
         var _loc10_:int = int(param3.length);
         if(_loc10_ > 0)
         {
            _loc6_ = new Vector.<IGameObject>(_loc10_);
            _loc7_ = new Vector.<Vector3d>(_loc10_);
            _loc8_ = new Vector.<int>(_loc10_);
            _loc9_ = new Vector.<Vector3d>(_loc10_);
            _loc11_ = new Vector.<Vector3d>(_loc10_);
            _loc13_ = 0;
            while(_loc13_ < _loc10_)
            {
               _loc14_ = param3[_loc13_];
               _loc15_ = param4[_loc13_];
               _loc16_ = new Vector3();
               _loc16_.copy(_loc15_);
               BattleUtils.globalToLocal(_loc14_,_loc15_);
               _loc17_ = _loc14_.tank;
               _loc8_[_loc13_] = _loc17_.incarnation;
               _loc6_[_loc13_] = _loc17_.getUser();
               _loc7_[_loc13_] = BattleUtils.getVector3d(_loc15_);
               _loc9_[_loc13_] = BattleUtils.getVector3d(_loc14_.state.position);
               _loc11_[_loc13_] = BattleUtils.getVector3d(_loc16_);
               _loc13_++;
            }
         }
         var _loc12_:Vector3d = BattleUtils.getVector3dOrNull(param2);
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         server.primaryShot(param1,_loc12_,_loc6_,_loc7_,_loc8_,_loc9_,_loc11_,param5);
      }
      
      public function secondaryRemoteHide(param1:IGameObject) : void
      {
         this.remoteWeapon().commonWeapon.effects.createHideEffect();
      }
      
      public function secondaryRemoteOpen(param1:IGameObject) : void
      {
         this.remoteWeapon().commonWeapon.effects.createOpenEffect();
      }
      
      public function primaryRemoteCharge(param1:IGameObject, param2:int) : void
      {
         this.remoteWeapon().commonWeapon.createPrimaryChargeEffects(param2);
      }
      
      public function primaryRemoteShot(param1:IGameObject, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>, param5:int) : void
      {
         var _loc7_:Vector.<Body> = null;
         var _loc8_:int = 0;
         var _loc9_:Body = null;
         var _loc6_:Vector.<Vector3> = convertHitPoints(param4);
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
         this.remoteWeapon().createPrimaryShotEffect(BattleUtils.getVector3OrNull(param2),_loc7_,_loc6_,param5);
      }
      
      public function primaryRemoteDummy(param1:IGameObject, param2:int) : void
      {
         this.remoteWeapon().createPrimaryDummyShotEffect(param2);
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
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function primaryDummyShot(param1:int, param2:int) : void
      {
         server.primaryDummyShot(param1,param2);
      }
   }
}

