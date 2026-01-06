package alternativa.tanks.models.battle.commonflag
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.BSP;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.physics.Body;
   import alternativa.physics.BodyState;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.CTFTargetEvaluator;
   import alternativa.tanks.battle.TeamDMTargetEvaluator;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.events.BattleRestartEvent;
   import alternativa.tanks.battle.events.LocalTankActivationEvent;
   import alternativa.tanks.battle.events.LocalTankKilledEvent;
   import alternativa.tanks.battle.events.StateCorrectionEvent;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.battle.events.TankUnloadedEvent;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.battle.battlefield.mine.IBattleMinesModel;
   import alternativa.tanks.models.battle.ctf.CTFCommonTargetEvaluator;
   import alternativa.tanks.models.battle.ctf.CTFRailgunTargetEvaluator;
   import alternativa.tanks.models.battle.ctf.FlagPickupTimeoutTask;
   import alternativa.tanks.models.battle.rugby.explosion.BallExplosion;
   import alternativa.tanks.models.battle.tdm.TDMHealingGunTargetEvaluator;
   import alternativa.tanks.models.inventory.IInventoryModel;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.inventory.InventoryLock;
   import alternativa.tanks.models.weapon.ricochet.CTFRicochetTargetEvaluator;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import alternativa.types.Long;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.StubBitmapData;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
   import projects.tanks.client.battlefield.models.battle.pointbased.IPointBasedBattleModelBase;
   import projects.tanks.client.battlefield.models.battle.pointbased.PointBasedBattleModelBase;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlagFlyingData;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class PointBasedBattleModel extends PointBasedBattleModelBase implements IPointBasedBattleModelBase, ICommonFlagModeModel, ObjectLoadPostListener, ObjectUnloadListener, BattleEventListener, IFlagBaseTrigerEvents
   {
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var materialRegistry:TextureMaterialRegistry;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var userInfoService:BattleUserInfoService;
      
      [Inject]
      public static var battleInputLockService:BattleInputService;
      
      [Inject]
      public static var keysBindingService:KeysBindingService;
      
      private static const FLAG_PICKUP_LOCK_DURATION:int = 5000;
      
      private static const BALL_PICKUP_LOCK_DURATION:int = 200;
      
      private static const TEAM_POINT_EQUIVALENT_RADIUS:int = 200;
      
      private var dropCommandSent:Boolean;
      
      private var battleMinesModel:IBattleMinesModel;
      
      private var inventoryModel:IInventoryModel;
      
      private var flags:Dictionary;
      
      private var basePointDatas:Dictionary;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var loadedTanks:Dictionary;
      
      private var localTank:Tank;
      
      private var triggers:Vector.<FlagBaseTrigger>;
      
      private var targetEvaluators:Vector.<TeamDMTargetEvaluator>;
      
      private var battleObject:IGameObject;
      
      private var ballTouchedServerFunction:Function;
      
      public function PointBasedBattleModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
         this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
         this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.onLocalTankActivated);
         this.battleEventSupport.addEventHandler(LocalTankKilledEvent,this.onLocalTankDie);
      }
      
      private static function createPedestal(param1:Tanks3DSResource) : Object3D
      {
         var _loc2_:Mesh = Mesh(param1.objects[0]);
         var _loc3_:BSP = new BSP();
         _loc3_.createTree(_loc2_);
         var _loc4_:BitmapData = param1.getTextureForObject(0);
         if(_loc4_ == null)
         {
            _loc4_ = new StubBitmapData(16776960);
         }
         var _loc5_:TextureMaterial = materialRegistry.getMaterial(_loc4_);
         _loc5_.resolution = 1;
         _loc3_.setMaterialToAllFaces(_loc5_);
         return _loc3_;
      }
      
      private function ballTouchedImpl(param1:int) : void
      {
         server.ballTouched(param1);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function objectLoadedPost() : void
      {
         var _loc1_:ClientTeamPoint = null;
         var _loc2_:CommonFlag = null;
         this.battleObject = object;
         this.loadedTanks = new Dictionary();
         this.triggers = new Vector.<FlagBaseTrigger>();
         this.flags = new Dictionary();
         this.basePointDatas = new Dictionary();
         this.ballTouchedServerFunction = getFunctionWrapper(this.ballTouchedImpl);
         for each(_loc1_ in getInitParam().teamPoints)
         {
            this.basePointDatas[_loc1_.id] = _loc1_;
         }
         this.inventoryModel = IInventoryModel(object.adapt(IInventoryModel));
         this.battleMinesModel = IBattleMinesModel(object.adapt(IBattleMinesModel));
         display.stage.addEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKeyDown));
         this.battleEventSupport.activateHandlers();
         this.initTargetEvaluators();
         IFlagModeInitilizer(object.event(IFlagModeInitilizer)).init(getInitParam().flags,getInitParam().teamPoints);
         if(battleInfoService.running)
         {
            for each(_loc2_ in this.flags)
            {
               if(_loc2_.carrier != null)
               {
                  FlagNotification(object.adapt(FlagNotification)).guiShowFlagCarried(_loc2_);
               }
            }
         }
      }
      
      public function objectUnloaded() : void
      {
         var _loc1_:CommonFlag = null;
         display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKeyDown));
         for each(_loc1_ in this.flags)
         {
            _loc1_.dispose();
         }
         this.flags = null;
         this.localTank = null;
         this.loadedTanks = null;
         this.triggers = null;
         this.flags = null;
         this.basePointDatas = null;
         this.battleEventSupport.deactivateHandlers();
         this.targetEvaluators = null;
         battleService.setCommonTargetEvaluator(null);
         battleService.setHealingGunTargetEvaluator(null);
         battleService.setRailgunTargetEvaluator(null);
         this.battleObject = null;
      }
      
      public function flagTaken(param1:int, param2:Long) : void
      {
         var _loc5_:CommonFlag = null;
         var _loc3_:CommonFlag = this.getFlag(param1);
         _loc3_.stopFalling();
         var _loc4_:Tank = this.loadedTanks[param2];
         if(_loc4_ == null)
         {
            return;
         }
         if(this.localTank != null && this.localTank == _loc4_)
         {
            this.setLocalFlagCarrier(_loc3_,param2,_loc4_);
         }
         else
         {
            this.setRemoteFlagCarrier(_loc3_,param2,_loc4_);
         }
         if(this.localTank != null || Boolean(battleInfoService.isSpectatorMode()))
         {
            this.disableFlagPickup(_loc3_);
            if(this.localTank != null && _loc4_ == this.localTank)
            {
               for each(_loc5_ in this.flags)
               {
                  if(_loc3_ != _loc5_ && _loc3_.teamType == _loc5_.teamType)
                  {
                     this.disableFlagPickup(_loc5_);
                  }
               }
            }
            FlagNotification(object.adapt(FlagNotification)).notifyFlagTaken(_loc3_,_loc4_);
         }
         FlagNotification(object.adapt(FlagNotification)).guiShowFlagCarried(_loc3_);
      }
      
      private function handleDropIfLocal(param1:CommonFlag, param2:int) : void
      {
         if(this.localTank != null)
         {
            if(this.localTank.isSameTeam(param1.teamType))
            {
               this.setFlagCarrierForEvaluators(param1,null);
            }
            if(param1.carrier == this.localTank)
            {
               if(this.dropCommandSent)
               {
                  this.dropCommandSent = false;
                  battleService.getBattleRunner().addLogicUnit(new FlagPickupTimeoutTask(this,param1,getTimer() + param2));
                  this.disableFlagPickup(param1);
               }
            }
            else
            {
               this.enableFlagPickupWithoutCheck(param1);
            }
         }
      }
      
      public function flagDelivered(param1:int, param2:int, param3:Long) : void
      {
         var _loc5_:Tank = null;
         var _loc4_:CommonFlag = this.getFlag(param1);
         this.returnFlag(_loc4_);
         if(this.localTank != null || Boolean(battleInfoService.isSpectatorMode()))
         {
            _loc5_ = this.loadedTanks[param3];
            if(_loc5_ != null)
            {
               FlagNotification(object.adapt(FlagNotification)).notifyFlagDelivered(_loc4_,_loc5_);
            }
         }
      }
      
      public function onEnterFlagBaseZone() : void
      {
         this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,true);
      }
      
      public function onLeaveFlagBaseZone() : void
      {
         this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,false);
      }
      
      public function onFlagTouch(param1:CommonFlag) : void
      {
         if(param1.registerTouch())
         {
            this.sendFullMoveCommand();
            this.ballTouchedServerFunction.apply(null,[param1.id]);
         }
      }
      
      public function sendFullMoveCommand() : void
      {
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      }
      
      public function onPickupTimeoutPassed(param1:CommonFlag) : void
      {
         this.tryToEnableFlagPickup(param1);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:GameActionEnum = keysBindingService.getBindingAction(param1.keyCode);
         if(_loc2_ == GameActionEnum.DROP_FLAG)
         {
            this.sendDropFlagCommand();
         }
      }
      
      private function sendDropFlagCommand() : void
      {
         var _loc1_:CommonFlag = null;
         if(Boolean(battleService.isBattleActive()) && !battleInputLockService.isInputLocked() && this.localTank != null && !this.dropCommandSent)
         {
            for each(_loc1_ in this.flags)
            {
               if(_loc1_.carrier == this.localTank)
               {
                  this.dropCommandSent = true;
                  this.sendFullMoveCommand();
                  server.dropFlagCommand();
                  break;
               }
            }
         }
      }
      
      private function onTankLoaded(param1:TankLoadedEvent) : void
      {
         this.loadedTanks[param1.tank.getUser().id] = param1.tank;
         if(param1.isLocal)
         {
            this.localTank = param1.tank;
         }
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         var _loc3_:CommonFlag = null;
         var _loc4_:Body = null;
         var _loc5_:BodyState = null;
         var _loc6_:Vector3 = null;
         var _loc2_:Tank = param1.tank;
         for each(_loc3_ in this.flags)
         {
            if(_loc3_.carrier == _loc2_)
            {
               _loc4_ = _loc2_.getBody();
               _loc5_ = _loc4_.state;
               _loc6_ = _loc5_.position;
               if(battleInfoService.running)
               {
                  object = this.battleObject;
                  FlagNotification(object.adapt(FlagNotification)).notifyFlagDropped(_loc3_);
                  popObject();
               }
               _loc3_.dropAt(_loc6_);
               break;
            }
         }
         delete this.loadedTanks[_loc2_.getUser().id];
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         var _loc2_:CommonFlag = null;
         for each(_loc2_ in this.flags)
         {
            if(_loc2_.state == FlagState.CARRIED && _loc2_.carrierId == param1.tank.getUser().id)
            {
               this.setRemoteFlagCarrier(_loc2_,_loc2_.carrierId,param1.tank);
               this.disableFlagPickup(_loc2_);
               break;
            }
         }
      }
      
      private function onLocalTankActivated(param1:Object) : void
      {
         var _loc2_:TeamDMTargetEvaluator = null;
         this.enableFlagsPickup();
         for each(_loc2_ in this.targetEvaluators)
         {
            _loc2_.setLocalTeamType(this.localTank.teamType);
         }
      }
      
      private function onLocalTankDie(param1:Object) : void
      {
         this.disableFlagsPickup();
      }
      
      private function onBattleRestart(param1:Object) : void
      {
         var _loc2_:CommonFlag = null;
         var _loc3_:FlagBaseTrigger = null;
         for each(_loc2_ in this.flags)
         {
            this.returnFlag(_loc2_);
         }
         for each(_loc3_ in this.triggers)
         {
            _loc3_.reset();
         }
      }
      
      private function onBattleFinish(param1:Object) : void
      {
         this.dropCommandSent = false;
         this.disableFlagsPickup();
      }
      
      private function enableFlagsPickup() : void
      {
         var _loc1_:CommonFlag = null;
         for each(_loc1_ in this.flags)
         {
            this.tryToEnableFlagPickup(_loc1_);
         }
      }
      
      private function disableFlagsPickup() : void
      {
         var _loc1_:CommonFlag = null;
         for each(_loc1_ in this.flags)
         {
            this.disableFlagPickup(_loc1_);
         }
      }
      
      private function tryToEnableFlagPickup(param1:CommonFlag) : void
      {
         if(this.localTank != null && this.localTank.state == ClientTankState.ACTIVE && Boolean(battleService.isBattleActive()) && param1.state != FlagState.CARRIED && param1.state != FlagState.EXILED)
         {
            this.enableFlagPickupWithoutCheck(param1);
         }
      }
      
      private function enableFlagPickupWithoutCheck(param1:CommonFlag) : void
      {
         battleService.getBattleRunner().addTrigger(param1);
      }
      
      private function disableFlagPickup(param1:CommonFlag) : void
      {
         battleService.getBattleRunner().removeTrigger(param1);
      }
      
      private function setLocalFlagCarrier(param1:CommonFlag, param2:Long, param3:Tank) : void
      {
         param1.setLocalCarrier(param2,param3);
         this.setupEvaluators(param1,param3);
      }
      
      private function setRemoteFlagCarrier(param1:CommonFlag, param2:Long, param3:Tank) : void
      {
         param1.setRemoteCarrier(param2,param3);
         this.setupEvaluators(param1,param3);
      }
      
      private function setupEvaluators(param1:CommonFlag, param2:Tank) : void
      {
         if(param2 != null && this.localTank != null && param2.teamType != this.localTank.teamType)
         {
            this.setFlagCarrierForEvaluators(param1,param2.getBody());
         }
      }
      
      private function initTargetEvaluators() : void
      {
         this.targetEvaluators = new Vector.<TeamDMTargetEvaluator>();
         var _loc1_:CTFCommonTargetEvaluator = new CTFCommonTargetEvaluator();
         battleService.setCommonTargetEvaluator(_loc1_);
         this.targetEvaluators.push(_loc1_);
         var _loc2_:TDMHealingGunTargetEvaluator = new TDMHealingGunTargetEvaluator();
         battleService.setHealingGunTargetEvaluator(_loc2_);
         this.targetEvaluators.push(_loc2_);
         var _loc3_:CTFRailgunTargetEvaluator = new CTFRailgunTargetEvaluator();
         battleService.setRailgunTargetEvaluator(_loc3_);
         this.targetEvaluators.push(_loc3_);
         var _loc4_:CTFRicochetTargetEvaluator = new CTFRicochetTargetEvaluator();
         battleService.setRicochetTargetEvaluator(_loc4_);
         this.targetEvaluators.push(_loc4_);
      }
      
      private function setFlagCarrierForEvaluators(param1:CommonFlag, param2:Body) : void
      {
         var _loc3_:TeamDMTargetEvaluator = null;
         for each(_loc3_ in this.targetEvaluators)
         {
            if(_loc3_ is CTFTargetEvaluator)
            {
               CTFTargetEvaluator(_loc3_).setFlagCarrier(param1,param2);
            }
         }
      }
      
      private function getFlag(param1:int) : CommonFlag
      {
         return this.flags[param1];
      }
      
      public function initFlag(param1:CommonFlag, param2:ClientFlag) : void
      {
         var _loc4_:Tank = null;
         param1.setTriggerCallback(this);
         param1.returnToBase();
         this.flags[param2.flagId] = param1;
         var _loc3_:BattleScene3D = battleService.getBattleScene3D();
         param1.addToScene();
         _loc3_.addRenderer(param1,1);
         _loc3_.hidableGraphicObjects.add(param1);
         param1.ballTouchedFunction = this.onFlagTouch;
         if(battleInfoService.running)
         {
            if(param2.flagCarrierId != null)
            {
               _loc4_ = this.loadedTanks[param2.flagCarrierId];
               this.setRemoteFlagCarrier(param1,param2.flagCarrierId,_loc4_);
            }
            else if(param2.flagPosition != null && param2.state != FlagState.EXILED && param2.state != FlagState.AT_BASE)
            {
               if(param2.fallingData.falling)
               {
                  if(param2.state == FlagState.DROPPED)
                  {
                     this.dropFlyingFlag(param2.flagId,0,param2.fallingData);
                  }
                  else
                  {
                     this.throwFlyingFlag(param2.flagId,param2.fallingData);
                  }
               }
               else
               {
                  param1.dropAt(Vector3.fromVector3d(param2.flagPosition));
                  FlagNotification(object.adapt(FlagNotification)).guiShowFlagDropped(param1);
               }
            }
         }
      }
      
      public function createBasePoint(param1:ClientTeamPoint, param2:Tanks3DSResource) : Object3D
      {
         var _loc3_:Object3D = createPedestal(param2);
         var _loc4_:Vector3 = BattleUtils.getVector3(param1.flagBasePosition);
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.y;
         _loc3_.z = _loc4_.z;
         battleService.getBattleScene3D().addObject(_loc3_);
         this.addMineProtectedZone(_loc4_);
         this.addTouchTrigger(_loc4_);
         return _loc3_;
      }
      
      public function getFlags() : Vector.<ClientFlag>
      {
         return getInitParam().flags;
      }
      
      public function getPoints() : Vector.<ClientTeamPoint>
      {
         return getInitParam().teamPoints;
      }
      
      public function getLocalTank() : Tank
      {
         return this.localTank;
      }
      
      public function exileFlag(param1:int) : void
      {
         this.dropCommandSent = false;
         var _loc2_:CommonFlag = this.getFlag(param1);
         if(_loc2_.state != FlagState.EXILED)
         {
            BattleUtils.tmpVector.copy(_loc2_.getIndicatorPosition());
            FlagNotification(object.adapt(FlagNotification)).notifyFlagDropped(_loc2_);
            _loc2_.returnToBase();
            this.disableFlagPickup(_loc2_);
            if(battleInfoService.running)
            {
               BallExplosion(object.adapt(BallExplosion)).createExplosionEffects(BattleUtils.tmpVector);
               FlagNotification(object.adapt(FlagNotification)).notifyReadyToFaceOff();
            }
         }
      }
      
      public function addMineProtectedZone(param1:Vector3) : void
      {
         this.addTrigger(param1,this.battleMinesModel.getMinDistanceFromBase(),this);
      }
      
      public function addTouchTrigger(param1:Vector3) : void
      {
         this.addTrigger(param1,TEAM_POINT_EQUIVALENT_RADIUS,new FlagBaseTriggerHandler(getFunctionWrapper(this.sendFullMoveCommand)));
      }
      
      private function addTrigger(param1:Vector3, param2:Number, param3:IFlagBaseTrigerEvents) : void
      {
         var _loc4_:FlagBaseTrigger = new FlagBaseTrigger(param1,param2,param3,battleService.getBattleRunner().getCollisionDetector());
         this.triggers.push(_loc4_);
         battleService.getBattleRunner().addTrigger(_loc4_);
      }
      
      public function dropFlyingFlag(param1:int, param2:int, param3:ClientFlagFlyingData) : void
      {
         var _loc4_:CommonFlag = this.getFlag(param1);
         _loc4_.dropFlying(param3,FlagState.DROPPED);
         this.tryToEnableFlagPickup(_loc4_);
         FlagNotification(object.adapt(FlagNotification)).notifyFlagFacedOff(_loc4_);
      }
      
      public function throwFlyingFlag(param1:int, param2:ClientFlagFlyingData) : void
      {
         var _loc3_:CommonFlag = this.getFlag(param1);
         this.handleDropIfLocal(_loc3_,BALL_PICKUP_LOCK_DURATION);
         FlagNotification(object.adapt(FlagNotification)).notifyFlagThrown(_loc3_);
         _loc3_.dropFlying(param2,FlagState.FLYING);
      }
      
      private function returnFlag(param1:CommonFlag) : void
      {
         this.dropCommandSent = false;
         param1.returnToBase();
         if(Boolean(this.localTank) && Boolean(this.localTank.teamType))
         {
            this.setFlagCarrierForEvaluators(param1,null);
         }
         FlagNotification(object.adapt(FlagNotification)).guiShowFlagAtBase(param1);
      }
      
      public function returnFlagToBase(param1:int, param2:IGameObject) : void
      {
         var _loc3_:CommonFlag = this.getFlag(param1);
         this.returnFlag(_loc3_);
         FlagNotification(object.adapt(FlagNotification)).notifyFlagReturned(_loc3_,param2);
      }
      
      public function dropFlag(param1:int, param2:Vector3d) : void
      {
         var _loc3_:CommonFlag = this.getFlag(param1);
         if(_loc3_.carrierId != null)
         {
            this.handleDropIfLocal(_loc3_,FLAG_PICKUP_LOCK_DURATION);
            FlagNotification(object.adapt(FlagNotification)).notifyFlagDropped(_loc3_);
            _loc3_.dropAt(Vector3.fromVector3d(param2));
         }
      }
   }
}

