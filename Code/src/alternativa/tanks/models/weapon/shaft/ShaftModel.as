package alternativa.tanks.models.weapon.shaft
{
   import alternativa.math.Vector3;
   import alternativa.osgi.service.display.IDisplay;
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
   import alternativa.tanks.battle.objects.tank.controllers.LocalShaftController;
   import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
   import alternativa.tanks.battle.objects.tank.controllers.LocalTurretControllerFactory;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.WeaponConst;
   import alternativa.tanks.models.weapon.WeaponForces;
   import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.laser.LaserPointer;
   import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModel;
   import alternativa.tanks.models.weapons.targeting.ShaftTargetingSystem;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.IShaftModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   [ModelInfo]
   public class ShaftModel extends ShaftModelBase implements IShaftModelBase, IWeaponModel, IShaftWeaponCallback, BattleEventListener, LocalTurretControllerFactory, ObjectLoadListener
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private static const MAX_DISTANCE:Number = 10000000000;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var object3DToTank:Dictionary = new Dictionary();
      
      private var weapons:Dictionary = new Dictionary();
      
      private var localUser:IGameObject;
      
      private var tanksOnField:Dictionary = new Dictionary();
      
      public function ShaftModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattleEvent);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
         this.battleEventSupport.activateHandlers();
      }
      
      private static function getWeakening() : DistanceWeakening
      {
         var _loc1_:IWeaponWeakeningModel = IWeaponWeakeningModel(object.adapt(IWeaponWeakeningModel));
         return _loc1_.getDistanceWeakening();
      }
      
      private static function getEffects() : ShaftEffects
      {
         var _loc1_:IShaftSFXModel = IShaftSFXModel(object.adapt(IShaftSFXModel));
         return _loc1_.getEffects();
      }
      
      private static function createServerShotData(param1:Vector3, param2:Body, param3:Vector3) : ServerShotData
      {
         var _loc4_:Vector3d = null;
         var _loc5_:Vector3d = null;
         var _loc6_:Vector3d = null;
         var _loc7_:IGameObject = null;
         var _loc8_:int = 0;
         var _loc9_:Vector3 = null;
         if(param2 != null)
         {
            _loc7_ = param2.tank.getUser();
            _loc8_ = param2.tank.incarnation;
            _loc9_ = param3;
            _loc6_ = BattleUtils.getVector3d(_loc9_);
            BattleUtils.globalToLocal(param2,_loc9_);
            _loc4_ = BattleUtils.getVector3d(_loc9_);
            _loc5_ = BattleUtils.getVector3d(param2.state.position);
         }
         return new ServerShotData(BattleUtils.getVector3dOrNull(param1),_loc4_,_loc7_,_loc8_,_loc5_,_loc6_);
      }
      
      public function objectLoaded() : void
      {
         var _loc1_:ShaftCC = getInitParam();
         _loc1_.shrubsHidingRadiusMin = BattleUtils.toClientScale(_loc1_.shrubsHidingRadiusMin);
         _loc1_.shrubsHidingRadiusMax = BattleUtils.toClientScale(_loc1_.shrubsHidingRadiusMax);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      [Obfuscation(rename="false")]
      public function stopManulaTargeting(param1:IGameObject) : void
      {
         var _loc2_:RemoteShaftWeapon = this.weapons[param1];
         if(_loc2_ != null)
         {
            _loc2_.stopManualTargeting();
         }
      }
      
      [Obfuscation(rename="false")]
      public function fire(param1:IGameObject, param2:Vector3d, param3:IGameObject, param4:Vector3d, param5:Number) : void
      {
         var _loc7_:Vector3 = null;
         var _loc8_:Body = null;
         var _loc9_:Tank = null;
         var _loc6_:RemoteShaftWeapon = this.weapons[param1];
         if(_loc6_ != null)
         {
            _loc6_.stopManualTargeting();
            if(param3 != null)
            {
               _loc9_ = this.tanksOnField[param3];
               if(_loc9_ == null)
               {
                  _loc8_ = null;
               }
               else
               {
                  _loc8_ = _loc9_.getBody();
                  _loc7_ = BattleUtils.getVector3(param4);
                  BattleUtils.localToGlobal(_loc9_.getBody(),_loc7_);
               }
            }
            _loc6_.showShotEffects(BattleUtils.getVector3OrNull(param2),_loc8_,_loc7_,param5);
         }
      }
      
      [Obfuscation(rename="false")]
      public function activateManualTargeting(param1:IGameObject) : void
      {
         var _loc2_:RemoteShaftWeapon = this.weapons[param1];
         if(_loc2_ != null)
         {
            _loc2_.startManualTargeting();
         }
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         this.localUser = param1;
         var _loc2_:IWeaponCommonModel = IWeaponCommonModel(object.adapt(IWeaponCommonModel));
         var _loc3_:WeaponCommonData = _loc2_.getCommonData();
         var _loc4_:SimpleWeaponController = new SimpleWeaponController();
         var _loc5_:ShaftObject = new ShaftObject(object);
         var _loc6_:TargetingSystem = new ShaftTargetingSystem(param1,_loc5_,MAX_DISTANCE);
         var _loc7_:WeaponForces = new WeaponForces(getInitParam().aimingImpact * WeaponConst.BASE_IMPACT_FORCE.getNumber(),_loc3_.getRecoilForce());
         var _loc8_:Weapon = new ShaftWeapon(_loc5_,battleService,battleEventDispatcher,IShaftWeaponCallback(object.adapt(IShaftWeaponCallback)),getInitParam(),_loc7_,_loc4_,this.object3DToTank,LocalShaftController(_loc2_.getLocalTurretController()),param1,_loc6_,getWeakening());
         this.weapons[param1] = _loc8_;
         return _loc8_;
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:IWeaponCommonModel = IWeaponCommonModel(object.adapt(IWeaponCommonModel));
         var _loc3_:WeaponCommonData = _loc2_.getCommonData();
         var _loc4_:ShaftEffects = getEffects();
         var _loc5_:TurretController = _loc2_.getTurretController();
         var _loc6_:SpeedCharacteristics = SpeedCharacteristics(param1.adapt(SpeedCharacteristics));
         var _loc7_:Weapon = new RemoteShaftWeapon(_loc3_.getRecoilForce(),getInitParam(),_loc4_,_loc5_,_loc6_);
         this.weapons[param1] = _loc7_;
         return _loc7_;
      }
      
      public function onAimedShot(param1:int, param2:Vector3, param3:Body, param4:Vector3) : void
      {
         var _loc5_:ServerShotData = createServerShotData(param2,param3,param4);
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         server.aimedShotCommand(param1,_loc5_.staticHitPoint,_loc5_.tank,_loc5_.hitPoint,_loc5_.incarnation,_loc5_.tankPosition,_loc5_.targetPositionGlobal);
      }
      
      public function onQuickShot(param1:int, param2:Vector3, param3:Body, param4:Vector3) : void
      {
         var _loc5_:ServerShotData = createServerShotData(param2,param3,param4);
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         server.quickShotCommand(param1,_loc5_.staticHitPoint,_loc5_.tank,_loc5_.hitPoint,_loc5_.incarnation,_loc5_.tankPosition,_loc5_.targetPositionGlobal);
      }
      
      public function onBeginEnergyDrain(param1:int) : void
      {
         server.beginEnergyDrainCommand(param1);
      }
      
      public function onManualTargetingStart() : void
      {
         server.activateManualTargetingCommand();
      }
      
      public function onManualTargetingStop() : void
      {
         server.stopManualTargetingCommand();
      }
      
      private function onTankAddedToBattleEvent(param1:TankAddedToBattleEvent) : void
      {
         this.addTankSkinAssociation(param1.tank);
         this.tanksOnField[param1.tank.getUser()] = param1.tank;
      }
      
      private function addTankSkinAssociation(param1:Tank) : void
      {
         var _loc2_:TankSkin = param1.getSkin();
         this.object3DToTank[_loc2_.getHullMesh()] = param1;
         this.object3DToTank[_loc2_.getTurret3D()] = param1;
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         var _loc2_:IGameObject = param1.tank.getUser();
         if(_loc2_ == this.localUser)
         {
            this.localUser = null;
         }
         delete this.weapons[_loc2_];
      }
      
      private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void
      {
         delete this.tanksOnField[param1.tank.getUser()];
         this.removeTankSkinAssociation(param1.tank.getSkin());
      }
      
      private function removeTankSkinAssociation(param1:TankSkin) : void
      {
         delete this.object3DToTank[param1.getHullMesh()];
         delete this.object3DToTank[param1.getTurret3D()];
      }
      
      public function enteredInManualMode() : void
      {
         server.activateManualTargetingCommand();
      }
      
      public function createLocalTurretController(param1:TurretController) : LocalTurretController
      {
         var _loc2_:ShaftCC = getInitParam();
         var _loc3_:uint = uint(LaserPointer(object.adapt(LaserPointer)).getLaserPointerRedColor());
         var _loc4_:ReticleDisplay = new ReticleDisplay(_loc2_.reticleImage,_loc3_);
         return new LocalShaftController(param1,_loc4_,_loc2_.verticalTargetingSpeed);
      }
   }
}

