package alternativa.tanks.models.controlpoints
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.TeamDMTargetEvaluator;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleRestartEvent;
   import alternativa.tanks.battle.events.LocalTankActivationEvent;
   import alternativa.tanks.battle.events.StateCorrectionEvent;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
   import alternativa.tanks.battle.events.TankUnloadedEvent;
   import alternativa.tanks.battle.events.death.TankDeadEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import alternativa.tanks.models.battle.battlefield.BattleModel;
   import alternativa.tanks.models.battle.battlefield.BattleType;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
   import alternativa.tanks.models.battle.tdm.TDMCommonTargetEvaluator;
   import alternativa.tanks.models.battle.tdm.TDMHealingGunTargetEvaluator;
   import alternativa.tanks.models.battle.tdm.TDMRailgunTargetEvaluator;
   import alternativa.tanks.models.controlpoints.hud.KeyPoint;
   import alternativa.tanks.models.controlpoints.hud.KeyPointView;
   import alternativa.tanks.models.controlpoints.hud.marker.KeyPointHUDMarker;
   import alternativa.tanks.models.controlpoints.hud.marker.KeyPointHUDMarkers;
   import alternativa.tanks.models.controlpoints.hud.panel.KeyPointsHUDPanel;
   import alternativa.tanks.models.controlpoints.message.ControlPointMessage;
   import alternativa.tanks.models.controlpoints.message.ControlPointMessages;
   import alternativa.tanks.models.controlpoints.sfx.AllBeamProperties;
   import alternativa.tanks.models.controlpoints.sfx.BeamEffects;
   import alternativa.tanks.models.controlpoints.sfx.DominationBeamEffect;
   import alternativa.tanks.models.controlpoints.sound.KeyPointSoundEffects;
   import alternativa.tanks.models.controlpoints.sound.Sounds;
   import alternativa.tanks.models.inventory.IInventoryModel;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.inventory.InventoryLock;
   import alternativa.tanks.models.weapon.ricochet.TeamDMRicochetTargetEvaluator;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.battle.cp.ClientPointData;
   import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;
   import projects.tanks.client.battlefield.models.battle.cp.ControlPointsModelBase;
   import projects.tanks.client.battlefield.models.battle.cp.IControlPointsModelBase;
   import projects.tanks.client.battlefield.models.battle.cp.resources.DominationSounds;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import utils.TankNameGameObjectMapper;
   import flash.geom.Point;
   
   [ModelInfo]
   public class ControlPointsModel extends ControlPointsModelBase implements IControlPointsModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, BattleModel, IDominationModel, BattleEventListener
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var effectsMaterialRegistry:EffectsMaterialRegistry;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var battleGuiService:BattleGUIService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      private var targetEvaluators:Vector.<TeamDMTargetEvaluator>;
      
      private var guiModel:BattlefieldGUI;
      
      private var inventoryModel:IInventoryModel;
      
      private var keyPoints:Dictionary = new Dictionary();
      
      private var triggers:Vector.<KeyPointTrigger>;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var keyPointHUDMarkers:KeyPointHUDMarkers;
      
      private var dominationPointsHUDPanel:KeyPointsHUDPanel;
      
      private var localTank:Tank;
      
      private var tanksInBattle:Dictionary;
      
      private var gameObject:IGameObject;
      
      public function ControlPointsModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
         this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.onLocalTankActivation);
         this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.addEventHandler(TankDeadEvent,this.onTankDeadEvent);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      }
      
      private static function getGameObject(tankId:String) : IGameObject
      {
         return TankNameGameObjectMapper.getGameObjectByTankName(tankId);
      }
      
      private static function getBattleTeam(param1:ControlPointState) : BattleTeam
      {
         if(param1 == ControlPointState.RED)
         {
            return BattleTeam.RED;
         }
         if(param1 == ControlPointState.BLUE)
         {
            return BattleTeam.BLUE;
         }
         throw new Error();
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         this.tanksInBattle[param1.tank.getUser()] = param1.tank;
         var pointOccupationBuffer:PointOccupationBuffer = this.getPointOccupationBuffer();
         if(pointOccupationBuffer != null)
         {
            var _loc2_:int = pointOccupationBuffer.takeTankPointId(param1.tank.getUserId());
            if(_loc2_ >= 0)
            {
               this.createBeamEffect(_loc2_,param1.tank,AllBeamProperties(this.getMyData(AllBeamProperties)));
            }
         }
      }
      
      private function getMyData(param1:Class) : Object
      {
         Model.object = this.gameObject;
         var _loc2_:Object = getData(param1);
         Model.popObject();
         return _loc2_;
      }
      
      private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void
      {
         var _loc2_:IGameObject = param1.tank.getUser();
         this.getBeamEffects().removeEffect(_loc2_);
         delete this.tanksInBattle[_loc2_];
      }
      
      private function onTankLoaded(param1:TankLoadedEvent) : void
      {
         if(param1.isLocal)
         {
            this.localTank = param1.tank;
            this.keyPointHUDMarkers.show();
            this.dominationPointsHUDPanel.visible = true;
         }
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         if(param1.tank == this.localTank)
         {
            this.localTank = null;
         }
      }
      
      private function onTankDeadEvent(param1:TankDeadEvent) : void
      {
         this.getBeamEffects().removeEffect(param1.victim);
      }
      
      private function getBeamEffects() : BeamEffects
      {
         return BeamEffects(this.getMyData(BeamEffects));
      }
      
      private function onLocalTankActivation(param1:Object) : void
      {
         var _loc3_:TeamDMTargetEvaluator = null;
         var _loc2_:BattleTeam = LocalTankActivationEvent(param1).tank.teamType;
         for each(_loc3_ in this.targetEvaluators)
         {
            _loc3_.setLocalTeamType(_loc2_);
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         this.gameObject = Model.object;
         this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
         this.inventoryModel = IInventoryModel(object.adapt(IInventoryModel));
         this.triggers = new Vector.<KeyPointTrigger>();
         this.tanksInBattle = new Dictionary();
         this.battleEventSupport.activateHandlers();
         putData(PointOccupationBuffer,new PointOccupationBuffer());
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         this.initTargetEvaluators();
         this.initKeyPoints();
         putData(AllBeamProperties,new AllBeamProperties(effectsMaterialRegistry,getInitParam().resources));
         putData(BeamEffects,new BeamEffects());
         putData(Sounds,new Sounds(battleService.soundManager,getInitParam().sounds));
      }
      
      private function initTargetEvaluators() : void
      {
         this.targetEvaluators = new Vector.<TeamDMTargetEvaluator>();
         var _loc1_:TDMCommonTargetEvaluator = new TDMCommonTargetEvaluator();
         battleService.setCommonTargetEvaluator(_loc1_);
         this.targetEvaluators.push(_loc1_);
         var _loc2_:TDMHealingGunTargetEvaluator = new TDMHealingGunTargetEvaluator();
         battleService.setHealingGunTargetEvaluator(_loc2_);
         this.targetEvaluators.push(_loc2_);
         var _loc3_:TDMRailgunTargetEvaluator = new TDMRailgunTargetEvaluator();
         battleService.setRailgunTargetEvaluator(_loc3_);
         this.targetEvaluators.push(_loc3_);
         var _loc4_:TeamDMRicochetTargetEvaluator = new TeamDMRicochetTargetEvaluator();
         battleService.setRicochetTargetEvaluator(_loc4_);
         this.targetEvaluators.push(_loc4_);
      }
      
      private function initKeyPoints() : void
      {
         var _loc2_:ClientPointData = null;
         var _loc3_:KeyPoint = null;
         var _loc4_:KeyPointTrigger = null;
         var _loc5_:PointOccupationBuffer = null;
         var _loc6_:String = null;
         this.keyPointHUDMarkers = new KeyPointHUDMarkers(battleService.getBattleScene3D().getCamera());
         battleService.getBattleScene3D().addRenderer(this.keyPointHUDMarkers,0);
         var _loc1_:Vector.<KeyPoint> = new Vector.<KeyPoint>();
         for each(_loc2_ in getInitParam().points)
         {
            _loc3_ = this.createKeyPoint(_loc2_);
            this.keyPoints[_loc2_.id] = _loc3_;
            battleService.getBattleRunner().addLogicUnit(_loc3_);
            _loc1_.push(_loc3_);
            _loc4_ = new KeyPointTrigger(_loc3_.getPosition(),BattleUtils.toClientScale(getInitParam().keypointTriggerRadius),BattleUtils.toClientScale(getInitParam().minesRestrictionRadius),_loc2_.id,this,battleService.getBattleRunner().getCollisionDetector(),getInitParam().keypointVisorHeight);
            this.triggers.push(_loc4_);
            battleService.getBattleRunner().addTrigger(_loc4_);
            this.keyPointHUDMarkers.addMarker(new KeyPointHUDMarker(_loc3_));
            _loc5_ = this.getPointOccupationBuffer();
            for each(_loc6_ in _loc2_.tankIds)
            {
               _loc5_.add(_loc6_,_loc2_.id);
            }
         }
         this.dominationPointsHUDPanel = new KeyPointsHUDPanel(_loc1_);
         this.dominationPointsHUDPanel.visible = false;
         battleGuiService.getGuiContainer().addChild(this.dominationPointsHUDPanel);
         battleService.getBattleScene3D().addRenderer(this.dominationPointsHUDPanel,0);
         this.guiModel.addWidget(this.dominationPointsHUDPanel);
         if(battleInfoService.isSpectatorMode())
         {
            this.keyPointHUDMarkers.show();
            this.dominationPointsHUDPanel.visible = true;
         }
      }
      
      private function createKeyPoint(param1:ClientPointData) : KeyPoint
      {
         var _loc2_:KeyPointView = new KeyPointView(param1.name,battleService.getBattleScene3D(),getInitParam().resources);
         var _loc3_:Vector3 = BattleUtils.getVector3(param1.position);
         var _loc4_:DominationSounds = getInitParam().sounds;
         var _loc5_:KeyPointSoundEffects = new KeyPointSoundEffects(battleService,_loc4_.pointScoreIncreasingSound.sound,_loc4_.pointScoreDecreasingSound.sound);
         var _loc6_:KeyPoint = new KeyPoint(param1.id,param1.name,_loc3_,battleService,this,_loc5_,_loc2_);
         _loc6_.tanksCount = param1.tankIds.length;
         _loc6_.setCaptureState(param1.state);
         _loc6_.setServerProgressData(param1.score,param1.scoreChangeRate);
         return _loc6_;
      }
      
      private function getPointOccupationBuffer() : PointOccupationBuffer
      {
         return PointOccupationBuffer(this.getMyData(PointOccupationBuffer));
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         this.targetEvaluators = null;
         battleService.setCommonTargetEvaluator(null);
         battleService.setHealingGunTargetEvaluator(null);
         battleService.setRailgunTargetEvaluator(null);
         battleService.setRicochetTargetEvaluator(null);
         this.battleEventSupport.deactivateHandlers();
         this.dominationPointsHUDPanel.removeFromParent();
         this.dominationPointsHUDPanel = null;
         this.tanksInBattle = null;
      }
      
      [Obfuscation(rename="false")]
      public function tankEnteredPointZone(param1:int, param2:String) : void
      {
         var _loc3_:KeyPoint = this.keyPoints[param1];
         ++_loc3_.tanksCount;
         var _loc4_:Tank = this.tanksInBattle[getGameObject(param2)];
         if(_loc4_ != null)
         {
            this.createBeamEffect(param1,_loc4_,AllBeamProperties(getData(AllBeamProperties)));
         }
         else
         {
            this.getPointOccupationBuffer().add(param2,param1);
         }
      }
      
      private function createBeamEffect(param1:int, param2:Tank, param3:AllBeamProperties) : void
      {
         var _loc4_:DominationBeamEffect = DominationBeamEffect(battleService.getObjectPool().getObject(DominationBeamEffect));
         var _loc5_:KeyPoint = this.keyPoints[param1];
         var _loc6_:Vector3 = new Vector3();
         _loc5_.readPosition(_loc6_);
         _loc4_.init(param2.getSkin().getTurret3D(),_loc6_,param3.getBeamProperties(param2.teamType),battleService.getExcludedObjects3D());
         this.getBeamEffects().addEffect(param2.getUser(),_loc4_);
      }
      
      [Obfuscation(rename="false")]
      public function tankLeftPointZone(param1:int, param2:String) : void
      {
         var _loc3_:KeyPoint = this.keyPoints[param1];
         --_loc3_.tanksCount;
         var _loc4_:Tank = this.tanksInBattle[getGameObject(param2)];
         if(_loc4_ != null)
         {
            this.getBeamEffects().removeEffect(_loc4_.getUser());
         }
         else
         {
            this.getPointOccupationBuffer().remove(param2);
         }
      }
      
      public function getBattleType() : BattleType
      {
         return BattleType.DOMINATION;
      }
      
      [Obfuscation(rename="false")]
      public function setPointProgress(param1:int, param2:Number, param3:Number) : void
      {
         var _loc4_:KeyPoint = this.keyPoints[param1];
         _loc4_.setServerProgressData(param2,param3);
      }
      
      [Obfuscation(rename="false")]
      public function setPointState(param1:int, param2:ControlPointState) : void
      {
         var _loc3_:KeyPoint = this.keyPoints[param1];
         var _loc4_:ControlPointState = _loc3_.getCaptureState();
         _loc3_.setCaptureState(param2);
         if(param2 == ControlPointState.NEUTRAL)
         {
            this.onPointNeutralized(_loc3_,_loc4_);
         }
         else
         {
            this.onPointCaptured(_loc3_);
         }
      }
      
      private function onPointNeutralized(param1:KeyPoint, param2:ControlPointState) : void
      {
         var _loc3_:BattleTeam = getBattleTeam(param2);
         var _loc4_:ControlPointMessage = this.getNeutralizationMessage(_loc3_);
         var _loc5_:String = _loc4_.getMessage(param1.getName());
         this.guiModel.showBattleMessage(_loc4_.color,_loc5_);
         var _loc6_:UserAction = _loc3_ == BattleTeam.BLUE ? UserAction.CP_POINT_BLUE_NEUTRAL : UserAction.CP_POINT_RED_NEUTRAL;
         var _loc7_:ControlPointMessage = new ControlPointMessage(0,TanksLocale.TEXT_DOM_POINT);
         this.guiModel.showPointBattleLogMessage(_loc7_.getMessage(param1.getName()),_loc6_);
         this.getSounds().playNeutralizedSound(_loc3_);
      }
      
      private function getNeutralizationMessage(param1:BattleTeam) : ControlPointMessage
      {
         if(this.localTank == null)
         {
            return ControlPointMessages.getLostMessage(param1);
         }
         if(param1 == this.localTank.teamType)
         {
            return ControlPointMessages.weLostPoint;
         }
         return ControlPointMessages.enemyLostPoint;
      }
      
      private function onPointCaptured(param1:KeyPoint) : void
      {
         var _loc2_:BattleTeam = getBattleTeam(param1.getCaptureState());
         var _loc3_:ControlPointMessage = this.getCaptureMessage(_loc2_);
         var _loc4_:String = _loc3_.getMessage(param1.getName());
         this.guiModel.showBattleMessage(_loc3_.color,_loc4_);
         var _loc5_:UserAction = _loc2_ == BattleTeam.BLUE ? UserAction.CP_POINT_NEUTRAL_BLUE : UserAction.CP_POINT_NEUTRAL_RED;
         var _loc6_:ControlPointMessage = new ControlPointMessage(0,TanksLocale.TEXT_DOM_POINT);
         this.guiModel.showPointBattleLogMessage(_loc6_.getMessage(param1.getName()),_loc5_);
         this.getSounds().playCapturingSound(_loc2_);
      }
      
      private function getCaptureMessage(param1:BattleTeam) : ControlPointMessage
      {
         if(this.localTank == null)
         {
            return ControlPointMessages.getCaptureMessage(param1);
         }
         if(param1 == this.localTank.teamType)
         {
            return ControlPointMessages.weCapturedPoint;
         }
         return ControlPointMessages.enemyCapturedPoint;
      }
      
      private function resetPoints() : void
      {
         var _loc1_:KeyPoint = null;
         for each(_loc1_ in this.keyPoints)
         {
            _loc1_.reset();
         }
      }
      
      [Obfuscation(rename="false")]
      public function pointCaptureStarted(param1:BattleTeam) : void
      {
         this.getSounds().playCaptureStartSound(param1);
      }
      
      [Obfuscation(rename="false")]
      public function pointCaptureStopped(param1:BattleTeam) : void
      {
         this.getSounds().playCaptureStopSound(param1);
      }
      
      private function getSounds() : Sounds
      {
         return Sounds(getData(Sounds));
      }
      
      public function onEnterPointCapturingZone(param1:int) : void
      {
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      }
      
      public function onLeavePointCapturingZone(param1:int) : void
      {
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      }
      
      public function onEnterMineRestrictionZone(param1:int) : void
      {
         this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,true);
      }
      
      public function onLeaveMineRestrictionZone(param1:int) : void
      {
         this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,false);
      }
      
      private function onBattleRestart(param1:Object) : void
      {
         this.reset();
      }
      
      private function reset() : void
      {
         this.resetPoints();
         this.resetTriggers();
      }
      
      private function resetTriggers() : void
      {
         var _loc1_:KeyPointTrigger = null;
         for each(_loc1_ in this.triggers)
         {
            _loc1_.reset();
         }
      }
      
      public function forceUpdatePoint(param1:int) : void
      {
         var pointId:int = param1;
         Model.object = this.gameObject;
         try
         {
            server.forceUpdatePoint(pointId);
         }
         finally
         {
            Model.popObject();
         }
      }
      
      [Obfuscation(rename="false")]
      public function stopBattle() : void
      {
         this.reset();
      }
   }
}

