package alternativa.tanks.models.tank
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.command.FormattedOutput;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.logging.LogService;
   import alternativa.osgi.service.logging.Logger;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleRunner;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.events.BattleRestartEvent;
   import alternativa.tanks.battle.events.EffectActivatedEvent;
   import alternativa.tanks.battle.events.EffectStoppedEvent;
   import alternativa.tanks.battle.events.InventoryItemActivationEvent;
   import alternativa.tanks.battle.events.LocalTankActivationEvent;
   import alternativa.tanks.battle.events.TankActivationEvent;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
   import alternativa.tanks.battle.events.TankUnloadedEvent;
   import alternativa.tanks.battle.events.death.TankKilledEvent;
   import alternativa.tanks.battle.objects.tank.LocalHullTransformUpdater;
   import alternativa.tanks.battle.objects.tank.RemoteHullTransformUpdater;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.TankControlLockBits;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.controllers.ChassisControlListener;
   import alternativa.tanks.battle.objects.tank.controllers.ChassisController;
   import alternativa.tanks.battle.objects.tank.controllers.ITurretControllerListener;
   import alternativa.tanks.battle.objects.tank.controllers.LocalChassisController;
   import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.display.usertitle.TitleConfigFlags;
   import alternativa.tanks.display.usertitle.UserTitle;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.battle.gui.drone.IDroneModel;
   import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
   import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
   import alternativa.tanks.models.inventory.IInventoryModel;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.inventory.InventoryLock;
   import alternativa.tanks.models.sfx.smoke.HullSmoke;
   import alternativa.tanks.models.statistics.IClientUserInfo;
   import alternativa.tanks.models.statistics.IStatisticsModel;
   import alternativa.tanks.models.tank.armor.Armor;
   import alternativa.tanks.models.tank.configuration.TankConfiguration;
   import alternativa.tanks.models.tank.engine.Engine;
   import alternativa.tanks.models.tank.event.LocalTankLoadListener;
   import alternativa.tanks.models.tank.event.LocalTankUnloadListener;
   import alternativa.tanks.models.tank.event.TankEntityCreationListener;
   import alternativa.tanks.models.tank.hullcommon.HullCommon;
   import alternativa.tanks.models.tank.killhandlers.LocalTankDieHandler;
   import alternativa.tanks.models.tank.killhandlers.RemoteTankDieHandler;
   import alternativa.tanks.models.tank.killhandlers.TankDeathConfirmationHandler;
   import alternativa.tanks.models.tank.killhandlers.TankDieHandler;
   import alternativa.tanks.models.tank.pause.ITankPause;
   import alternativa.tanks.models.tank.resistance.TankResistances;
   import alternativa.tanks.models.tank.spawn.ITankSpawner;
   import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
   import alternativa.tanks.models.tank.support.BattleInputLockSupport;
   import alternativa.tanks.models.tank.support.ClientDeactivationSupport;
   import alternativa.tanks.models.tank.support.StateCorrectionSupport;
   import alternativa.tanks.models.tank.support.TankSettingsSupport;
   import alternativa.tanks.models.tank.ultimate.IUltimateModel;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.WeaponConst;
   import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
   import alternativa.tanks.models.weapon.common.WeaponSound;
   import alternativa.tanks.models.weapon.turret.TurretStateSender;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.services.initialeffects.ClientBattleEffect;
   import alternativa.tanks.services.initialeffects.IInitialEffectsService;
   import alternativa.tanks.services.memoryleakguard.MemoryLeakTrackerService;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import alternativa.tanks.sfx.TankSoundEffects;
   import alternativa.tanks.utils.DataUnitValidator;
   import alternativa.types.Long;
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.user.tank.ITankModelBase;
   import projects.tanks.client.battlefield.models.user.tank.TankLogicState;
   import projects.tanks.client.battlefield.models.user.tank.TankModelBase;
   import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
   import projects.tanks.client.battlefield.types.DamageType;
   import projects.tanks.client.battlefield.types.TankState;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import utils.TankNameGameObjectMapper;
   
   [ModelInfo]
   public class TankModel extends TankModelBase implements ITankModelBase, ObjectLoadListener, ObjectUnloadListener, ITankModel, LocalTankInfoService, ChassisControlListener, BattleEventListener, ITurretControllerListener
   {
      
      [Inject]
      public static var logService:LogService;
      
      [Inject]
      public static var settings:ISettingsService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var battleUserInfoService:BattleUserInfoService;
      
      [Inject]
      public static var modelRegistry:ModelRegistry;
      
      [Inject]
      public static var memoryLeakTrackerService:MemoryLeakTrackerService;
      
      [Inject]
      public static var tankUsersRegistry:TankUsersRegistry;
      
      [Inject]
      public static var inventoryPanel:IInventoryPanel;
      
      [Inject]
      public static var initialEffectsService:IInitialEffectsService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      private static const LOCAL_TITLE_OFFSET_Z:Number = 0;
      
      private static const REMOTE_TITLE_OFFSET_Z:Number = 135;
      
      private static const ZERO_VECTOR_3D:Vector3d = new Vector3d(0,0,0);
      
      private var logger:Logger;
      
      private var damageLogger:Logger;
      
      private const _orientation:Quaternion = new Quaternion();
      
      private const _orientation2:Quaternion = new Quaternion();
      
      private const _eulerAngles:Vector3 = new Vector3();
      
      private var tankUserInfoUpdater:TankUserInfoUpdater;
      
      private const tanksInBattle:Dictionary = new Dictionary();
      
      private var localObject:IGameObject;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var chassisStateCorrectionTask:ChassisStateCorrectionTask;
      
      private var turretDirectionCorrectionTask:TurretDirectionCorrectionTask;
      
      private const _moveCommand:MoveCommand = new MoveCommand(new Vector3d(0,0,0),0,new Vector3d(0,0,0),new Vector3d(0,0,0),new Vector3d(0,0,0));
      
      private var positionBookmarks:PositionBookmarks;
      
      private var overridenTankPositions:OverridenTankPositions;
      
      private var lastChassisInput:int;
      
      private var lastTurretInput:int;
      
      private var lastSentMoveCommand:MoveCommand = new MoveCommand(new Vector3d(0,0,0),0,new Vector3d(0,0,0),new Vector3d(0,0,0),new Vector3d(0,0,0));
      
      private var lastFullSentTime:int;
      
      private var lastSentTime:int;
      
      private var lastControlSentTime:int;
      
      private var smokeEffect:HullSmoke;
      
      public function TankModel()
      {
         super();
         this.logger = logService.getLogger("tank");
         this.damageLogger = logService.getLogger("damage");
         OSGi.getInstance().registerService(LocalTankInfoService,this);
         this.tankUserInfoUpdater = new TankUserInfoUpdater();
         this.initMainBattleEventListeners();
      }
      
      private static function getDefaultMaxHealth() : int
      {
         var _loc1_:TankConfiguration = TankConfiguration(object.adapt(TankConfiguration));
         var _loc2_:IGameObject = _loc1_.getHullObject();
         var _loc3_:Armor = Armor(_loc2_.adapt(Armor));
         return _loc3_.getMaxHealth();
      }
      
      private static function createTankSoundEffects(param1:IGameObject, param2:IGameObject) : TankSoundEffects
      {
         var _loc3_:Engine = Engine(param1.adapt(Engine));
         var _loc4_:Sound = _loc3_.getCC().engineIdleSound.sound;
         var _loc5_:Sound = _loc3_.getCC().engineStartMovingSound.sound;
         var _loc6_:Sound = _loc3_.getCC().engineMovingSound.sound;
         var _loc7_:WeaponSound = WeaponSound(param2.adapt(WeaponSound));
         var _loc8_:Sound = _loc7_.getTurretRotationSound().sound;
         return new TankSoundEffects(_loc4_,_loc5_,_loc6_,_loc8_);
      }
      
      private static function setInitialTankState() : void
      {
         var _loc1_:SpeedCharacteristics = SpeedCharacteristics(object.adapt(SpeedCharacteristics));
         _loc1_.setInitialTankState();
      }
      
      private static function setBackTurnMode(param1:LocalChassisController) : void
      {
         param1.setReversedBackTurn(settings.inverseBackDriving);
      }
      
      private static function showInitialEffects(param1:IGameObject) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ITankModel = null;
         var _loc5_:UserTitle = null;
         var _loc6_:ClientBattleEffect = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Vector.<ClientBattleEffect> = initialEffectsService.takeInitialEffects(TankNameGameObjectMapper.getTankNameByGameObject(param1));
         if(_loc2_ != null)
         {
            _loc3_ = getTimer();
            _loc4_ = ITankModel(param1.adapt(ITankModel));
            _loc5_ = _loc4_.getTitle();
            for each(_loc6_ in _loc2_)
            {
               _loc7_ = _loc3_ - _loc6_.receiveTime;
               _loc8_ = _loc6_.duration - _loc7_;
               if(_loc8_ > 0)
               {
                  _loc5_.showIndicator(_loc6_.effectId,_loc8_,false,_loc6_.effectLevel);
               }
            }
         }
      }
      
      private static function configureTankTitle(param1:UserTitle, param2:int, param3:String, param4:int, param5:BattleTeam, param6:int, param7:Boolean) : void
      {
         param1.setHealth(param2);
         param1.setLabelText(param3);
         param1.setRank(param4);
         param1.setTeamType(param5);
         param1.setConfiguration(param6);
         param1.setPremium(param7);
      }
      
      private function initMainBattleEventListeners() : void
      {
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
         this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
         this.battleEventSupport.addEventHandler(EffectActivatedEvent,this.onEffectActivated);
         this.battleEventSupport.addEventHandler(EffectStoppedEvent,this.onEffectStopped);
         this.battleEventSupport.addEventHandler(InventoryItemActivationEvent,this.onInventoryItemActivation);
         this.battleEventSupport.activateHandlers();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         this.registerUser();
         putData(UserInfo,new UserInfo(battleUserInfoService.getUserName(getUserInfo().name),battleUserInfoService.getUserRank(getUserInfo().name),getInitParam().local,battleUserInfoService.getChatModeratorLevel(getUserInfo().name),battleUserInfoService.hasUserPremium(getUserInfo().name)));
         var _loc1_:TankConfiguration = TankConfiguration(object.adapt(TankConfiguration));
         var _loc2_:int = getDefaultMaxHealth();
         var _loc3_:IGameObject = _loc1_.hasDrone() ? _loc1_.getDrone() : null;
         this.initTank(_loc1_.getHullObject(),_loc1_.getTurretObject(),_loc3_,_loc2_,false);
         this.initUltimate();
         this.showLoginMessage();
         this.battleEventSupport.dispatchEvent(new TankLoadedEvent(this.getTank(),this.isLocal()));
         var _loc4_:TankEntityCreationListener = TankEntityCreationListener(object.event(TankEntityCreationListener));
         _loc4_.onTankEntityCreated(this.getTank(),this.isLocal(),getInitParam().logicState);
         if(this.tankShouldBeAddedToBattle())
         {
            this.addExistingTankToBattle();
         }
      }
      
      private function initUltimate() : void
      {
         var _loc1_:IUltimateModel = IUltimateModel(object.adapt(IUltimateModel));
         if(_loc1_.isUltimateEnabled())
         {
            IUltimateModel(object.adapt(IUltimateModel)).initIndicator();
         }
      }
      
      private function registerUser() : void
      {
         tankUsersRegistry.addUser(object);
         if(tankUsersRegistry.getUserCount() == 1)
         {
            battleUserInfoService.addBattleUserInfoListener(this.tankUserInfoUpdater);
         }
      }
      
      private function initTank(param1:IGameObject, param2:IGameObject, param3:IGameObject, param4:int, param5:Boolean) : Tank
      {
         var _loc6_:TankConfiguration = TankConfiguration(object.adapt(TankConfiguration));
         var _loc7_:TurretController = this.createTurretController(param2);
         var _loc8_:LocalTurretController = this.getLocalTurretController();
         var _loc9_:int = 0;
         var _loc10_:UserTitle = getData(UserTitle) as UserTitle;
         if(_loc10_ != null)
         {
            _loc9_ = _loc10_.getResistance();
            _loc10_.removeFromContainer();
         }
         _loc10_ = this.createUserTitle(param4);
         _loc10_.setResistance(_loc9_);
         putData(UserTitle,_loc10_);
         var _loc11_:Weapon = this.createWeapon(param2);
         this.registerWeaponController(_loc11_);
         HullCommon(param1.adapt(HullCommon)).setTankObject(object);
         var _loc12_:Tank = this.createTank(param1,param2,_loc6_.getColoringObject(),_loc7_,_loc8_,_loc11_,_loc10_);
         this.storeTank(_loc12_,param1,param2,param3,param4);
         this.initTankPart(param2,_loc12_);
         if(param5)
         {
            TankPartReset(param2.event(TankPartReset)).resetTankPart(_loc12_);
         }
         this.createTankDataValidator(_loc12_);
         this.createSmokeEffect(param1);
         this.createChassisController(_loc12_);
         this.createTankKillHandler();
         if(this.isLocal())
         {
            this.initLocalObjectBattleEventListeners();
            this.initLocalTank(_loc12_,param5);
            _loc12_.setHullTransformUpdater(new LocalHullTransformUpdater(_loc12_));
         }
         else
         {
            _loc12_.setHullTransformUpdater(new RemoteHullTransformUpdater(_loc12_));
            this.createMovementAnticheatTask();
         }
         setInitialTankState();
         return _loc12_;
      }
      
      private function initTankPart(param1:IGameObject, param2:Tank) : void
      {
         InitTankPart(param1.event(InitTankPart)).initTankPart(param2);
      }
      
      private function storeTank(param1:Tank, param2:IGameObject, param3:IGameObject, param4:IGameObject, param5:int) : void
      {
         putData(Tank,param1);
         this.getWeaponCommon(param3).storeTank(param1);
         putData(TankSet,new TankSet(param2,param3,param4,param5));
      }
      
      public function getTankSet() : TankSet
      {
         return TankSet(getData(TankSet));
      }
      
      private function showLoginMessage() : void
      {
         var _loc3_:ShortUserInfo = null;
         var _loc4_:IStatisticsModel = null;
         var _loc1_:IGameObject = object.space.rootObject;
         var _loc2_:IClientUserInfo = IClientUserInfo(_loc1_.adapt(IClientUserInfo));
         if(!_loc2_.isLoaded(object.id))
         {
            _loc3_ = _loc2_.getShortUserInfo(getUserInfo().name);
            _loc4_ = IStatisticsModel(_loc1_.adapt(IStatisticsModel));
            _loc4_.userConnect(_loc3_);
         }
      }
      
      private function createMovementAnticheatTask() : void
      {
         var _loc1_:MovementTimeoutAndDistanceAnticheatTask = new MovementTimeoutAndDistanceAnticheatTask(this.getTank(),getFunctionWrapper(this.placeTankToServerPosition),getInitParam().movementTimeoutUntilTankCorrection,getInitParam().movementDistanceBorderUntilTankCorrection);
         putData(MovementTimeoutAndDistanceAnticheatTask,_loc1_);
         battleService.getBattleRunner().addLogicUnit(_loc1_);
      }
      
      private function registerWeaponController(param1:Weapon) : void
      {
         if(getInitParam().local)
         {
            putData(IWeaponController,new LocalWeaponController(param1));
         }
         else
         {
            putData(IWeaponController,new RemoteWeaponController(param1));
         }
      }
      
      private function createTurretController(param1:IGameObject) : TurretController
      {
         var _loc2_:TurretController = null;
         var _loc3_:LocalTurretController = null;
         if(this.isLocal())
         {
            _loc3_ = this.getWeaponCommon(param1).getLocalTurretController();
            _loc2_ = _loc3_.getTurretController();
            _loc2_.setListener(this);
            putData(LocalTurretController,_loc3_);
         }
         else
         {
            _loc2_ = this.getWeaponCommon(param1).getTurretController();
         }
         putData(TurretController,_loc2_);
         return _loc2_;
      }
      
      private function getWeaponCommon(param1:IGameObject) : IWeaponCommonModel
      {
         return IWeaponCommonModel(param1.adapt(IWeaponCommonModel));
      }
      
      private function createSmokeEffect(param1:IGameObject) : void
      {
         this.smokeEffect = HullSmoke(param1.adapt(HullSmoke));
      }
      
      private function createChassisController(param1:Tank) : void
      {
         var _loc2_:ChassisController = null;
         var _loc3_:LocalChassisController = null;
         if(getInitParam().local)
         {
            _loc3_ = new LocalChassisController(param1,this);
            _loc3_.lock(TankControlLockBits.DEAD);
            setBackTurnMode(_loc3_);
            _loc2_ = _loc3_;
            putData(TankSettingsSupport,new TankSettingsSupport(_loc3_));
         }
         else
         {
            _loc2_ = new ChassisController(param1,this);
            _loc2_.lock(TankControlLockBits.DEAD);
         }
         putData(ChassisController,_loc2_);
      }
      
      private function createTankKillHandler() : void
      {
         var _loc1_:RemoteTankDieHandler = null;
         if(getInitParam().local)
         {
            putData(TankDieHandler,new LocalTankDieHandler());
         }
         else
         {
            _loc1_ = new RemoteTankDieHandler();
            putData(TankDieHandler,_loc1_);
            putData(TankDeathConfirmationHandler,_loc1_);
         }
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         this.unregisterUser();
         this.destroyTank(false);
         if(!battleInfoService.isSpectatorMode())
         {
            IUltimateModel(object.adapt(IUltimateModel)).resetCharge();
         }
      }
      
      private function unregisterUser() : void
      {
         tankUsersRegistry.removeUser(object);
         if(tankUsersRegistry.getUserCount() == 0)
         {
            battleUserInfoService.removeBattleUserInfoListener(this.tankUserInfoUpdater);
         }
      }
      
      private function destroyTank(param1:Boolean) : void
      {
         var _loc2_:Tank = this.getTank();
         this.removeMovementAnticheatTask();
         this.removeTankFromBattle();
         this.removeTankFromExclusionSet(_loc2_);
         this.dispatchTankUnloadedEvent();
         this.unloadLocalTank(param1);
         _loc2_.destroy();
      }
      
      private function removeMovementAnticheatTask() : void
      {
         var _loc1_:MovementTimeoutAndDistanceAnticheatTask = this.getMovementAnticheatTask();
         if(Boolean(_loc1_))
         {
            battleService.getBattleRunner().removeLogicUnit(_loc1_);
            clearData(MovementTimeoutAndDistanceAnticheatTask);
         }
      }
      
      public function getMovementAnticheatTask() : MovementTimeoutAndDistanceAnticheatTask
      {
         return MovementTimeoutAndDistanceAnticheatTask(getData(MovementTimeoutAndDistanceAnticheatTask));
      }
      
      [Obfuscation(rename="false")]
      public function kill(param1:String, param2:int, param3:DamageType) : void
      {
         this.die(param2);
         battleEventDispatcher.dispatchEvent(new TankKilledEvent(param1,getUserInfo().name,param3));
      }
      
      public function die(param1:int) : void
      {
         var _loc2_:TankDieHandler = TankDieHandler(getData(TankDieHandler));
         _loc2_.handleTankDie(object,param1);
      }
      
      [Obfuscation(rename="false")]
      public function deathConfirmed() : void
      {
         var _loc1_:TankDeathConfirmationHandler = TankDeathConfirmationHandler(getData(TankDeathConfirmationHandler));
         _loc1_.handleDeathConfirmation(object);
      }
      
      [Obfuscation(rename="false")]
      public function setHealth(param1:Number) : void
      {
         if(this.getTank() != null)
         {
            this.doSetHealth(param1);
         }
      }
      
      [Obfuscation(rename="false")]
      public function activateTank() : void
      {
         var _loc1_:Tank = this.getTank();
         if(_loc1_ != null)
         {
            _loc1_.setActivatedState();
            this.getWeaponController().activateWeapon();
            this.getWeaponController().unlockWeapon(TankControlLockBits.DEAD | TankControlLockBits.DISABLED);
            if(object == this.localObject)
            {
               _loc1_.setBodyCollisionGroup(_loc1_.getBodyCollisionGroup() | CollisionGroup.BONUS_WITH_TANK);
               this.battleEventSupport.dispatchEvent(new LocalTankActivationEvent(_loc1_));
            }
            this.battleEventSupport.dispatchEvent(new TankActivationEvent(_loc1_));
            this.removeTankFromExclusionSet(_loc1_);
         }
      }
      
      [Obfuscation(rename="false")]
      public function move(param1:MoveCommand) : void
      {
         this.adjustIncomingCommandAndUpdateAnticheatTask(param1);
         this.evaluateMove(param1);
      }
      
      private function evaluateMove(param1:MoveCommand) : void
      {
         this.setChassisState(param1.position,param1.orientation,param1.linearVelocity,param1.angularVelocity,param1.control,param1.turnSpeedNumber);
      }
      
      private function adjustIncomingCommandAndUpdateAnticheatTask(param1:MoveCommand) : void
      {
         var _loc2_:MovementTimeoutAndDistanceAnticheatTask = this.getMovementAnticheatTask();
         _loc2_.updateLatestServerTankPosition(param1.position,param1.orientation);
         this.adjustIncomingMovementCommand(param1);
      }
      
      private function placeTankToServerPosition(param1:Vector3d, param2:Vector3d) : void
      {
         this.setChassisState(param1,param2,ZERO_VECTOR_3D,ZERO_VECTOR_3D,0,0);
         this.getTank().getBody().saveState();
      }
      
      private function adjustIncomingMovementCommand(param1:MoveCommand) : void
      {
         var _loc3_:Body = null;
         var _loc4_:Number = NaN;
         var _loc2_:Tank = this.getTank();
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getBody();
            _loc4_ = 0.5;
            this.interpolateVector3d(_loc4_,_loc3_.state.position,param1.position,param1.position);
            this.interpolateVector3d(_loc4_,_loc3_.state.velocity,param1.linearVelocity,param1.linearVelocity);
            this.interpolateVector3d(_loc4_,_loc3_.state.angularVelocity,param1.angularVelocity,param1.angularVelocity);
            this.interpolateOrientation(_loc4_,_loc3_.state.orientation,param1.orientation,param1.orientation);
         }
      }
      
      private function interpolateVector3d(param1:Number, param2:Vector3, param3:Vector3d, param4:Vector3d) : void
      {
         param4.x = param2.x + (param3.x - param2.x) * param1;
         param4.y = param2.y + (param3.y - param2.y) * param1;
         param4.z = param2.z + (param3.z - param2.z) * param1;
      }
      
      private function interpolateOrientation(param1:Number, param2:Quaternion, param3:Vector3d, param4:Vector3d) : void
      {
         this._orientation.setFromEulerAnglesXYZ(param3.x,param3.y,param3.z);
         this._orientation2.slerp(param2,this._orientation,param1);
         this._orientation2.getEulerAngles(this._eulerAngles);
         param4.x = this._eulerAngles.x;
         param4.y = this._eulerAngles.y;
         param4.z = this._eulerAngles.z;
      }
      
      [Obfuscation(rename="false")]
      public function movementControl(param1:int, param2:int) : void
      {
         this.getChassisController().setControlState(param1,param2);
      }
      
      public function enableStateCorrection() : void
      {
         battleService.getBattleRunner().addPostPhysicsController(this.chassisStateCorrectionTask);
         this.chassisStateCorrectionTask.reset();
         battleService.getBattleRunner().addPostPhysicsController(this.turretDirectionCorrectionTask);
         this.turretDirectionCorrectionTask.reset();
      }
      
      public function disableStateCorrection() : void
      {
         battleService.getBattleRunner().removePostPhysicsController(this.chassisStateCorrectionTask);
         battleService.getBattleRunner().removePostPhysicsController(this.turretDirectionCorrectionTask);
      }
      
      public function onTurretDirectionCorrection(param1:Boolean) : void
      {
         this.sendTurretStateToServer();
         this.turretDirectionCorrectionTask.reset();
      }
      
      private function sendTurretStateToServer() : void
      {
         var _loc1_:ITankModel = null;
         var _loc2_:IGameObject = null;
         if(this.localObject != null)
         {
            _loc1_ = ITankModel(this.localObject.adapt(ITankModel));
            _loc2_ = _loc1_.getTankSet().turret;
            TurretStateSender(_loc2_.event(TurretStateSender)).sendTurretState();
         }
      }
      
      public function sendStateCorrection(param1:Boolean) : void
      {
         var _loc2_:ChassisController = this.getChassisController();
         this.sendMoveCommandWithCurrentState(_loc2_.getControlState(),param1);
         this.chassisStateCorrectionTask.reset();
      }
      
      public function onPrevStateCorrection(param1:Boolean) : void
      {
         var _loc2_:ITankModel = ITankModel(this.localObject.adapt(ITankModel));
         var _loc3_:ChassisController = _loc2_.getChassisController();
         this.sendMoveCommandWithPreviousState(_loc3_.getControlState(),true);
      }
      
      public function handleCollisionWithOtherTank(param1:Tank) : void
      {
         server.handleCollisionWithOtherTank(param1.getBody().state.velocity.z);
      }
      
      public function lockMovementControl(param1:int) : void
      {
         this.getChassisController().lock(param1);
         this.getTurretController().lock(param1);
      }
      
      public function unlockMovementControl(param1:int) : void
      {
         this.getChassisController().unlock(param1);
         this.getTurretController().unlock(param1);
      }
      
      public function getWeaponController() : IWeaponController
      {
         return IWeaponController(getData(IWeaponController));
      }
      
      public function getChassisController() : ChassisController
      {
         return ChassisController(getData(ChassisController));
      }
      
      public function getTurretController() : TurretController
      {
         return TurretController(getData(TurretController));
      }
      
      public function getLocalTurretController() : LocalTurretController
      {
         return LocalTurretController(getData(LocalTurretController));
      }
      
      public function getTitle() : UserTitle
      {
         return UserTitle(getData(UserTitle));
      }
      
      public function getUserInfo() : UserInfo
      {
         return UserInfo(getData(UserInfo));
      }
      
      public function getTank() : Tank
      {
         return Tank(getData(Tank));
      }
      
      public function onChassisControlChanged(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            this.chassisStateCorrectionTask.controlChanged();
         }
         this.smokeEffect.controlChanged(object != null ? object : this.localObject,param1);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function onTurretControlStateChanged(param1:int) : void
      {
         this.sendTurretStateToServer();
         this.turretDirectionCorrectionTask.reset();
         this.updateIdleTracker(param1);
      }
      
      private function updateIdleTracker(param1:int) : void
      {
         if(this.lastTurretInput != param1)
         {
            this.lastTurretInput = param1;
            this.resetIdleKickTime();
         }
      }
      
      private function sendMoveCommandWithCurrentState(param1:int, param2:Boolean) : void
      {
         var _loc3_:ITankModel = null;
         var _loc4_:Tank = null;
         if(this.tanksInBattle[this.localObject.id] != null)
         {
            _loc3_ = ITankModel(this.localObject.adapt(ITankModel));
            _loc4_ = _loc3_.getTank();
            this.updateLastChassisInput(param1);
            _loc4_.getPhysicsState(this._moveCommand.position,this._moveCommand.orientation,this._moveCommand.linearVelocity,this._moveCommand.angularVelocity);
            this._moveCommand.control = param1;
            this._moveCommand.turnSpeedNumber = TrackedChassis.TURN_SPEED_COUNT;
            this.sendMoveCommandFunc(battleService.getBattleRunner().getPhysicsTime(),param2);
         }
      }
      
      private function sendMoveCommandWithPreviousState(param1:int, param2:Boolean) : void
      {
         var _loc3_:ITankModel = null;
         var _loc4_:Tank = null;
         var _loc5_:int = 0;
         if(this.tanksInBattle[this.localObject.id] != null)
         {
            _loc3_ = ITankModel(this.localObject.adapt(ITankModel));
            _loc4_ = _loc3_.getTank();
            this.updateLastChassisInput(param1);
            _loc4_.getPreviousPhysicsState(this._moveCommand.position,this._moveCommand.orientation,this._moveCommand.linearVelocity,this._moveCommand.angularVelocity);
            this._moveCommand.control = param1;
            this._moveCommand.turnSpeedNumber = TrackedChassis.TURN_SPEED_COUNT;
            _loc5_ = battleService.getBattleRunner().getPhysicsTime() - BattleRunner.PHYSICS_STEP_IN_MS;
            this.sendMoveCommandFunc(_loc5_,param2);
         }
      }
      
      private function sendMoveCommandFunc(param1:int, param2:Boolean) : void
      {
         if(param1 <= this.lastFullSentTime)
         {
            return;
         }
         if(param2)
         {
            Model.object = this.localObject;
            server.moveCommand(param1,LocalTankParams.getSpecificationId(),this._moveCommand);
            Model.popObject();
            MoveCommandUtils.copyMoveCommand(this._moveCommand,this.lastSentMoveCommand);
            this.sendTurretStateToServer();
            this.lastFullSentTime = param1;
         }
         else if(MoveCommandUtils.isMoveCommandsAlmostEquals(this._moveCommand,this.lastSentMoveCommand))
         {
            if(this._moveCommand.control != this.lastSentMoveCommand.control)
            {
               this.sendMovementControlCommand(param1,this._moveCommand.control,this._moveCommand.turnSpeedNumber);
            }
         }
         else
         {
            this.sendMoveCommandImpl(param1,this._moveCommand);
         }
      }
      
      private function sendMoveCommandImpl(param1:int, param2:MoveCommand) : void
      {
         if(param1 <= this.lastSentTime)
         {
            return;
         }
         Model.object = this.localObject;
         server.moveCommand(param1,LocalTankParams.getSpecificationId(),param2);
         Model.popObject();
         MoveCommandUtils.copyMoveCommand(param2,this.lastSentMoveCommand);
         this.lastSentTime = param1;
      }
      
      private function sendMovementControlCommand(param1:int, param2:int, param3:int) : void
      {
         if(param1 <= this.lastSentTime || param1 <= this.lastControlSentTime)
         {
            return;
         }
         Model.object = this.localObject;
         server.movementControlCommand(param1,LocalTankParams.getSpecificationId(),param2,param3);
         Model.popObject();
         this.lastSentMoveCommand.control = param2;
         this.lastSentMoveCommand.turnSpeedNumber = param3;
         this.lastControlSentTime = param1;
      }
      
      private function updateLastChassisInput(param1:int) : void
      {
         if(this.lastChassisInput != param1)
         {
            this.lastChassisInput = param1;
            this.resetIdleKickTime();
         }
      }
      
      private function resetIdleKickTime() : void
      {
         var _loc1_:ITankPause = ITankPause(this.localObject.adapt(ITankPause));
         _loc1_.resetIdleKickTime();
      }
      
      private function logError(param1:String, param2:Error) : void
      {
      }
      
      private function showTankLogs(param1:FormattedOutput) : void
      {
      }
      
      private function addConsoleCommands() : void
      {
      }
      
      private function initLocalObjectBattleEventListeners() : void
      {
         this.battleEventSupport.deactivateHandlers();
         this.battleEventSupport.activateHandlers();
      }
      
      private function handleCameraTarget(param1:FormattedOutput, param2:String) : void
      {
      }
      
      private function listCameraTargets(param1:FormattedOutput) : void
      {
      }
      
      private function getTanksList() : Vector.<String>
      {
         return new Vector.<String>();
      }
      
      private function createTankDataValidator(param1:Tank) : void
      {
         var _loc2_:DataUnitValidator = param1.getValidator();
         putData(TankDataValidatorWrapper,new TankDataValidatorWrapper(_loc2_));
      }
      
      private function dispatchTankUnloadedEvent() : void
      {
         try
         {
            this.battleEventSupport.dispatchEvent(new TankUnloadedEvent(this.getTank(),this.isLocal()));
         }
         catch(e:Error)
         {
         }
      }
      
      private function unloadLocalTank(param1:Boolean) : void
      {
         var _loc2_:TankConfiguration = null;
         if(this.isLocal())
         {
            LocalTankUnloadListener(object.event(LocalTankUnloadListener)).localTankUnloaded(param1);
            _loc2_ = TankConfiguration(object.adapt(TankConfiguration));
            LocalTankUnloadListener(_loc2_.getTurretObject().event(LocalTankUnloadListener)).localTankUnloaded(param1);
            battleService.setCameraTarget(null);
            this.localObject = null;
            this.chassisStateCorrectionTask = null;
            this.turretDirectionCorrectionTask = null;
            RegularUserTitleRenderer(getData(RegularUserTitleRenderer)).close();
            BattleInputLockSupport(getData(BattleInputLockSupport)).close();
            StateCorrectionSupport(getData(StateCorrectionSupport)).close();
            MainLoopExecutionErrorHandler(getData(MainLoopExecutionErrorHandler)).close();
            ClientDeactivationSupport(getData(ClientDeactivationSupport)).close();
            clearData(RegularUserTitleRenderer);
            clearData(BattleInputLockSupport);
            clearData(StateCorrectionSupport);
            clearData(MainLoopExecutionErrorHandler);
            clearData(ClientDeactivationSupport);
         }
      }
      
      private function createWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:IWeaponModel = IWeaponModel(param1.adapt(IWeaponModel));
         if(this.isLocal())
         {
            return _loc2_.createLocalWeapon(object);
         }
         return _loc2_.createRemoteWeapon(object);
      }
      
      public function setChassisState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d, param5:int, param6:int) : void
      {
         var _loc7_:Tank = this.getTank();
         if(_loc7_ != null)
         {
            if(BattleUtils.isFiniteVector3d(param1) && BattleUtils.isFiniteVector3d(param2) && BattleUtils.isFiniteVector3d(param3) && BattleUtils.isFiniteVector3d(param4))
            {
               _loc7_.setPhysicsState(param1,param2,param3,param4);
            }
            this.getChassisController().setControlState(param5,param6);
         }
      }
      
      private function initLocalTank(param1:Tank, param2:Boolean) : void
      {
         this.localObject = object;
         this.chassisStateCorrectionTask = new ChassisStateCorrectionTask(param1,this.tanksInBattle);
         this.turretDirectionCorrectionTask = new TurretDirectionCorrectionTask(param1);
         var _loc3_:RegularUserTitleRenderer = new RegularUserTitleRenderer(param1,this.tanksInBattle);
         putData(RegularUserTitleRenderer,_loc3_);
         battleService.getBattleScene3D().setUserTitleRenderer(_loc3_);
         battleService.setCameraTarget(param1);
         putData(BattleInputLockSupport,new BattleInputLockSupport(object));
         putData(StateCorrectionSupport,new StateCorrectionSupport(object));
         putData(ClientDeactivationSupport,new ClientDeactivationSupport(object));
         putData(MainLoopExecutionErrorHandler,new MainLoopExecutionErrorHandler(object));
         var _loc4_:LocalTankLoadListener = LocalTankLoadListener(object.event(LocalTankLoadListener));
         _loc4_.localTankLoaded(param2);
      }
      
      private function tankShouldBeAddedToBattle() : Boolean
      {
         return getInitParam().tankState != null && getInitParam().health > 0;
      }
      
      private function addExistingTankToBattle() : void
      {
         var _loc1_:Tank = this.getTank();
         var _loc2_:ITankSpawner = ITankSpawner(object.adapt(ITankSpawner));
         _loc1_.spawn(getInitParam().team,_loc2_.getIncarnationId());
         this.doSetHealth(getInitParam().health);
         if(getInitParam().health <= 0)
         {
            _loc1_.getSkin().setDeadState();
            this.getTitle().hide();
            this.lockMovementControl(TankControlLockBits.DEAD);
         }
         else
         {
            this.unlockMovementControl(TankControlLockBits.ALL);
            this.getTitle().show();
            this.configureTankTitleAsRemote(object);
            this.getWeaponController().activateWeapon();
            this.getWeaponController().unlockWeapon(TankControlLockBits.ALL);
         }
         var _loc3_:TankState = getInitParam().tankState;
         this.setChassisState(_loc3_.position,_loc3_.orientation,ZERO_VECTOR_3D,ZERO_VECTOR_3D,_loc3_.chassisControl,_loc3_.chassisTurnSpeedNumber);
         switch(getInitParam().logicState)
         {
            case TankLogicState.ACTIVATING:
               _loc1_.setSemiActivatedState();
               break;
            case TankLogicState.ACTIVE:
               _loc1_.setActivatedState();
         }
         this.addTankToBattle(_loc1_);
      }
      
      public function doSetHealth(param1:Number) : void
      {
         var _loc2_:IGameObject = null;
         var _loc3_:Boolean = false;
         this.getTank().health = param1;
         this.getTitle().setHealth(param1);
         if(this.isLocal())
         {
            _loc2_ = battleService.getBattle();
            _loc3_ = param1 >= this.getTankSet().maxHealth && !IDroneModel(object.adapt(IDroneModel)).canOverheal();
            IInventoryModel(_loc2_.adapt(IInventoryModel)).lockItem(InventoryItemType.FIRST_AID,InventoryLock.FORCED,_loc3_);
         }
      }
      
      private function createTank(param1:IGameObject, param2:IGameObject, param3:IGameObject, param4:TurretController, param5:LocalTurretController, param6:Weapon, param7:UserTitle) : Tank
      {
         var _loc8_:HullCommon = HullCommon(param1.adapt(HullCommon));
         var _loc9_:Armor = Armor(param1.adapt(Armor));
         var _loc10_:TankSkin = new TankSkin(param1,param2,param3);
         var _loc11_:TankSoundEffects = createTankSoundEffects(param1,param2);
         var userInfo:UserInfo = this.getUserInfo();
         return new Tank(object,userInfo.name,_loc8_.getMass(),_loc8_.getDamping(),_loc11_,_loc10_,param4,param5,param6,param7,battleEventDispatcher,_loc9_.getMaxHealth());
      }
      
      public function configureRemoteTankTitles() : void
      {
         var _loc1_:IGameObject = null;
         var _loc2_:ITankModel = null;
         var _loc3_:Tank = null;
         for each(_loc1_ in tankUsersRegistry.getUsers())
         {
            if(_loc1_ != this.localObject)
            {
               _loc2_ = ITankModel(_loc1_.adapt(ITankModel));
               _loc3_ = _loc2_.getTank();
               if(_loc3_ != null)
               {
                  this.configureTankTitleAsRemote(_loc1_);
                  showInitialEffects(_loc1_);
               }
            }
         }
      }
      
      public function configureTankTitleAsRemote(param1:IGameObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ITankModel = null;
         var _loc4_:UserInfo = null;
         var _loc5_:Tank = null;
         var _loc6_:ITankModel = null;
         var _loc7_:Tank = null;
         if(this.localObject != null)
         {
            _loc6_ = ITankModel(this.localObject.adapt(ITankModel));
            _loc7_ = _loc6_.getTank();
            if(_loc7_.teamType != null)
            {
               _loc2_ = TitleConfigFlags.LABEL | TitleConfigFlags.EFFECTS;
               _loc3_ = ITankModel(param1.adapt(ITankModel));
               _loc4_ = _loc3_.getUserInfo();
               _loc5_ = _loc3_.getTank();
               if(this.localObject != null && _loc5_.isSameTeam(_loc7_.teamType))
               {
                  _loc2_ |= TitleConfigFlags.HEALTH;
               }
               configureTankTitle(_loc3_.getTitle(),_loc5_.health,_loc4_.name,_loc4_.rank,_loc5_.teamType,_loc2_,_loc4_.hasPremium);
            }
         }
         if(battleInfoService.isSpectatorMode())
         {
            _loc2_ = TitleConfigFlags.LABEL | TitleConfigFlags.EFFECTS | TitleConfigFlags.HEALTH;
            _loc3_ = ITankModel(param1.adapt(ITankModel));
            _loc4_ = _loc3_.getUserInfo();
            _loc5_ = _loc3_.getTank();
            configureTankTitle(_loc3_.getTitle(),_loc5_.health,_loc4_.name,_loc4_.rank,_loc5_.teamType,_loc2_,_loc4_.hasPremium);
         }
      }
      
      private function createUserTitle(param1:int) : UserTitle
      {
         var _loc2_:UserTitle = null;
         var _loc3_:BattleScene3D = battleService.getBattleScene3D();
         var _loc4_:UserInfo = this.getUserInfo();
         if(this.isLocal())
         {
            _loc2_ = new UserTitle(LOCAL_TITLE_OFFSET_Z,_loc3_.getFrontContainer(),param1,true);
            _loc2_.setRank(_loc4_.rank);
            _loc2_.setLabelText(_loc4_.name);
            _loc2_.setConfiguration(TitleConfigFlags.HEALTH | TitleConfigFlags.WEAPON | TitleConfigFlags.EFFECTS);
         }
         else
         {
            _loc2_ = new UserTitle(REMOTE_TITLE_OFFSET_Z,_loc3_.getMapContainer(),param1,false,Model.object);
            _loc2_.setSuspicious(battleUserInfoService.isUserSuspected(getUserInfo().name));
         }
         return _loc2_;
      }
      
      private function onBattleFinish(param1:BattleFinishEvent) : void
      {
         this.disableAllTanks();
      }
      
      private function disableAllTanks() : void
      {
         var _loc1_:IGameObject = null;
         var _loc2_:ITankModel = null;
         var _loc3_:Tank = null;
         for each(_loc1_ in tankUsersRegistry.getUsers())
         {
            _loc2_ = ITankModel(_loc1_.adapt(ITankModel));
            _loc3_ = _loc2_.getTank();
            if(_loc3_ != null)
            {
               _loc3_.disable();
               _loc2_.lockMovementControl(TankControlLockBits.DISABLED);
               _loc2_.getWeaponController().lockWeapon(TankControlLockBits.DISABLED,false);
            }
         }
      }
      
      private function onBattleRestart(param1:BattleRestartEvent) : void
      {
         var _loc2_:IGameObject = null;
         var _loc3_:ITankModel = null;
         for each(_loc2_ in tankUsersRegistry.getUsers())
         {
            _loc3_ = ITankModel(_loc2_.adapt(ITankModel));
            _loc3_.removeTankFromBattle();
         }
      }
      
      private function onInventoryItemActivation(param1:InventoryItemActivationEvent) : void
      {
         var _loc2_:ITankModel = null;
         var _loc3_:Tank = null;
         if(this.localObject != null)
         {
            _loc2_ = ITankModel(this.localObject.adapt(ITankModel));
            _loc3_ = _loc2_.getTank();
            param1.item.doActivate(_loc3_.getBody().state.position);
         }
      }
      
      private function onEffectActivated(param1:EffectActivatedEvent) : void
      {
         var _loc4_:ITankModel = null;
         var _loc5_:UserTitle = null;
         var _loc6_:int = 0;
         var _loc2_:IGameObject = tankUsersRegistry.getUser(getUserInfo().name);
         var _loc3_:Boolean = true;
         if(_loc2_ != null)
         {
            _loc4_ = ITankModel(_loc2_.adapt(ITankModel));
            _loc5_ = _loc4_.getTitle();
            if(_loc5_ != null)
            {
               if(_loc5_.hasAnyFlag(TitleConfigFlags.EFFECTS))
               {
                  _loc3_ = false;
                  _loc6_ = this.getEffectDuration(param1);
                  _loc5_.showIndicator(param1.effectId,_loc6_,param1.activeAfterDeath,param1.effectLevel);
               }
            }
            if(Boolean(_loc4_.isLocal()) && !this.isUltimate(param1.effectId))
            {
               inventoryPanel.changeEffectTime(param1.effectId,param1.duration,param1.inventory,param1.infinite);
            }
         }
         if(_loc3_)
         {
            initialEffectsService.addInitialEffect(param1.userId,param1.effectId,param1.duration,param1.effectLevel);
         }
      }
      
      private function getEffectDuration(param1:EffectActivatedEvent) : int
      {
         return param1.effectId == InventoryItemType.FIRST_AID ? 1000 : param1.duration;
      }
      
      private function isUltimate(param1:int) : Boolean
      {
         return param1 == InventoryItemType.ULTIMATE;
      }
      
      private function onEffectStopped(param1:EffectStoppedEvent) : void
      {
         var _loc3_:ITankModel = null;
         var _loc4_:UserTitle = null;
         if(this.isClientDurationEffect(param1))
         {
            return;
         }
         initialEffectsService.removeInitialEffect(param1.userId,param1.effectId);
         var _loc2_:IGameObject = tankUsersRegistry.getUser(getUserInfo().name);
         if(_loc2_ != null)
         {
            _loc3_ = ITankModel(_loc2_.adapt(ITankModel));
            _loc4_ = _loc3_.getTitle();
            if(_loc4_ != null)
            {
               _loc4_.hideIndicator(param1.effectId,param1.activeAfterDeath);
            }
            if(Boolean(_loc3_.isLocal()) && !this.isUltimate(param1.effectId))
            {
               inventoryPanel.stopEffect(param1.effectId);
            }
         }
      }
      
      private function isClientDurationEffect(param1:EffectStoppedEvent) : Boolean
      {
         return param1.effectId == InventoryItemType.FIRST_AID;
      }
      
      public function addTankToExclusionSet(param1:Tank) : void
      {
         var _loc2_:Dictionary = battleService.getExcludedObjects3D();
         _loc2_[param1.getSkin().getTurret3D()] = true;
         _loc2_[param1.getSkin().getHullMesh()] = true;
      }
      
      private function removeTankFromExclusionSet(param1:Tank) : void
      {
         var _loc2_:Dictionary = battleService.getExcludedObjects3D();
         delete _loc2_[param1.getSkin().getTurret3D()];
         delete _loc2_[param1.getSkin().getHullMesh()];
      }
      
      public function addTankToBattle(param1:Tank) : void
      {
         this.tanksInBattle[param1.getUser().id] = param1;
         param1.addToBattle(battleService);
         this.battleEventSupport.dispatchEvent(new TankAddedToBattleEvent(param1,this.isLocal()));
      }
      
      public function removeTankFromBattle() : void
      {
         var _loc1_:Tank = this.getTank();
         if(Boolean(this.tanksInBattle[_loc1_.getUser().id]))
         {
            delete this.tanksInBattle[_loc1_.getUser().id];
            _loc1_.removeFromBattle();
            battleEventDispatcher.dispatchEvent(new TankRemovedFromBattleEvent(_loc1_));
         }
      }
      
      public function getTanksInBattle() : Dictionary
      {
         return null;
      }
      
      public function sendDeathConfirmationCommand() : void
      {
         server.deathConfirmationCommand();
      }
      
      public function isLocal() : Boolean
      {
         return getInitParam().local;
      }
      
      public function isLocalTankLoaded() : Boolean
      {
         return this.localObject != null;
      }
      
      public function getLocalTankObject() : IGameObject
      {
         if(!this.isLocalTankLoaded())
         {
            throw new Error("Incorrect call method \'getLocalTank\' because local tank was not loaded");
         }
         return this.localObject;
      }
      
      public function getLocalTank() : Tank
      {
         return ITankModel(this.getLocalTankObject().adapt(ITankModel)).getTank();
      }
      
      public function getTurret3D() : Object3D
      {
         return this.getLocalTank().getTurret3D();
      }
      
      public function resetConfiguration(param1:Long, param2:Long, param3:Long, param4:int) : void
      {
         var _loc5_:TankSet = TankSet(getData(TankSet));
         var _loc6_:IGameObject = object.space.getObject(param1);
         var _loc7_:IGameObject = object.space.getObject(param2);
         var _loc8_:IGameObject = param3 == Long.ZERO ? null : object.space.getObject(param3);
         if(_loc5_.eqParts(_loc6_,_loc7_,_loc8_))
         {
            return;
         }
         var _loc9_:Boolean = this.tanksInBattle[object.id] != null;
         this.destroyTank(true);
         var _loc10_:Tank = this.initTank(_loc6_,_loc7_,_loc8_,param4,true);
         IDroneModel(object.adapt(IDroneModel)).initDrones(_loc10_,this.isLocal(),TankLogicState.NEW);
         this.battleEventSupport.dispatchEvent(new TankLoadedEvent(this.getTank(),this.isLocal()));
         if(_loc9_)
         {
            this.addExistingTankToBattle();
            this.unlockMovementControl(TankControlLockBits.ALL);
         }
         if(object == this.localObject)
         {
            TankResistances(object.adapt(TankResistances)).updateOthersResistances();
         }
      }
      
      public function push(param1:Vector3d, param2:Vector3d) : void
      {
         var _loc3_:Vector3 = new Vector3(param2.x,param2.y,param2.z);
         var _loc4_:Vector3 = _loc3_.clone().normalize();
         var _loc5_:Tank = object.adapt(ITankModel).getTank();
         var _loc6_:Vector3 = new Vector3(param1.x,param1.y,param1.z);
         _loc5_.applyWeaponHit(_loc6_,_loc4_,_loc3_.length() * WeaponConst.BASE_IMPACT_FORCE.getNumber());
      }
   }
}

