package alternativa.tanks.models.battle.rugby
{
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Decal;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.LogicUnit;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.events.BattleRestartEvent;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.assault.IndicatorStateAdapter;
   import alternativa.tanks.models.battle.battlefield.BattleModel;
   import alternativa.tanks.models.battle.battlefield.BattleType;
   import alternativa.tanks.models.battle.commonflag.CommonFlag;
   import alternativa.tanks.models.battle.commonflag.FlagNotification;
   import alternativa.tanks.models.battle.commonflag.ICommonFlagModeModel;
   import alternativa.tanks.models.battle.commonflag.IFlagModeInitilizer;
   import alternativa.tanks.models.battle.commonflag.MarkersUtils;
   import alternativa.tanks.models.battle.ctf.FlagMessage;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator.FlagIndicator;
   import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.utils.getTimer;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
   import projects.tanks.client.battlefield.models.battle.pointbased.rugby.IRugbyModelBase;
   import projects.tanks.client.battlefield.models.battle.pointbased.rugby.RugbyCC;
   import projects.tanks.client.battlefield.models.battle.pointbased.rugby.RugbyModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class RugbyModel extends RugbyModelBase implements IRugbyModelBase, IFlagModeInitilizer, FlagNotification, ObjectLoadListener, ObjectUnloadListener, BattleModel, BattleEventListener, LogicUnit
   {
      
      [Inject]
      public static var materialRegistry:TextureMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      private var ballSpawnZones:Vector.<Mesh>;
      
      private var ballSpawnZoneMaterial:TextureMaterial;
      
      private var guiModel:BattlefieldGUI;
      
      private var messages:RugbyMessages = new RugbyMessages();
      
      private var battleEventSupport:BattleEventSupport;
      
      private var ball:Ball;
      
      private var nextNotificationTime:int;
      
      public function RugbyModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
         this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      }
      
      private static function createBallSpawnZone(param1:Vector3d, param2:TextureMaterial) : Mesh
      {
         var _loc3_:Decal = null;
         _loc3_ = new Decal();
         var _loc4_:Number = 500;
         var _loc5_:Vertex = _loc3_.addVertex(-_loc4_,_loc4_,0,0,0);
         var _loc6_:Vertex = _loc3_.addVertex(-_loc4_,-_loc4_,0,0,1);
         var _loc7_:Vertex = _loc3_.addVertex(_loc4_,-_loc4_,0,1,1);
         var _loc8_:Vertex = _loc3_.addVertex(_loc4_,_loc4_,0,1,0);
         _loc3_.addQuadFace(_loc5_,_loc6_,_loc7_,_loc8_,param2);
         _loc3_.calculateFacesNormals();
         _loc3_.calculateVerticesNormals();
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         _loc3_.z = param1.z + 0.001;
         battleService.getBattleScene3D().addObject(_loc3_);
         return _loc3_;
      }
      
      public function objectLoaded() : void
      {
         this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
         this.battleEventSupport.activateHandlers();
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         if(param1.tank.getUser().id == this.ball.carrierId)
         {
            this.ball.setRemoteCarrier(this.ball.carrierId,param1.tank);
            this.initHudIndicator();
         }
      }
      
      private function initHudIndicator() : void
      {
         var _loc1_:BattleTeam = null;
         if(this.ball.state == FlagState.CARRIED)
         {
            _loc1_ = this.ball.carrier.teamType;
            this.guiModel.setIndicatorState(_loc1_,FlagIndicator.STATE_BLINK);
            this.guiModel.setIndicatorState(this.oppositeTeam(_loc1_),FlagIndicator.STATE_DEFAULT);
         }
         else
         {
            this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
         }
      }
      
      public function objectUnloaded() : void
      {
         var _loc1_:Mesh = null;
         this.battleEventSupport.deactivateHandlers();
         for each(_loc1_ in this.ballSpawnZones)
         {
            battleService.getBattleScene3D().removeObject(_loc1_);
         }
         materialRegistry.releaseMaterial(this.ballSpawnZoneMaterial);
         this.ballSpawnZones = null;
         this.ballSpawnZoneMaterial = null;
         this.ball = null;
         battleService.getBattleRunner().removeLogicUnit(this);
      }
      
      public function init(param1:Vector.<ClientFlag>, param2:Vector.<ClientTeamPoint>) : void
      {
         var _loc5_:ClientTeamPoint = null;
         var _loc6_:ClientFlag = null;
         var _loc7_:IndicatorStateAdapter = null;
         var _loc3_:ICommonFlagModeModel = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel));
         var _loc4_:RugbyCC = getInitParam();
         this.ballSpawnZones = new Vector.<Mesh>();
         this.ballSpawnZoneMaterial = materialRegistry.getMaterial(_loc4_.ballSpawnZone.data);
         for each(_loc5_ in param2)
         {
            _loc7_ = new IndicatorStateAdapter(Vector3.fromVector3d(_loc5_.flagBasePosition));
            if(_loc5_.id == -1)
            {
               _loc3_.createBasePoint(_loc5_,_loc4_.blueGoalModel);
               MarkersUtils.createMarkers(BattleTeam.BLUE,_loc4_.blueBallMarker.data,_loc4_.bigBlueBallMarker.data,_loc7_);
            }
            else if(_loc5_.id == -2)
            {
               _loc3_.createBasePoint(_loc5_,_loc4_.redGoalModel);
               MarkersUtils.createMarkers(BattleTeam.RED,_loc4_.redBallMarker.data,_loc4_.bigRedBallMarker.data,_loc7_);
            }
            else
            {
               this.ballSpawnZones.push(createBallSpawnZone(_loc5_.flagBasePosition,this.ballSpawnZoneMaterial));
               _loc3_.addMineProtectedZone(Vector3.fromVector3d(_loc5_.flagBasePosition));
            }
         }
         _loc6_ = param1[0];
         this.ball = new Ball(_loc6_.flagId,_loc4_.ballRadius,_loc4_.ballModel,_loc4_.parachuteResource,_loc4_.parachuteInnerResource,_loc4_.cordResource);
         MarkersUtils.createMarkers(null,_loc4_.greenBallMarker.data,_loc4_.bigGreenBallMarker.data,this.ball);
         _loc3_.initFlag(this.ball,_loc6_);
      }
      
      public function guiShowFlagDropped(param1:CommonFlag) : void
      {
         this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_EMPTY,FlagIndicator.STATE_DEFAULT);
      }
      
      public function guiShowFlagCarried(param1:CommonFlag) : void
      {
         this.guiModel.setIndicatorState(param1.carrier.teamType,FlagIndicator.STATE_BLINK);
         this.guiModel.setIndicatorState(this.oppositeTeam(param1.carrier.teamType),FlagIndicator.STATE_DEFAULT);
      }
      
      public function guiShowFlagAtBase(param1:CommonFlag) : void
      {
         this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
      }
      
      public function notifyFlagTaken(param1:CommonFlag, param2:Tank) : void
      {
         var _loc3_:String = this.messages.getBattleLogMessage(RugbyMessages.TAKE);
         this.guiModel.showUserBattleLogMessage(param2.getUser().id,UserAction.RGB_PLAYER_PICK_BALL);
         var _loc4_:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
         var _loc5_:Boolean = Boolean(_loc4_) && _loc4_.teamType == param2.teamType;
         var _loc6_:SoundResource = _loc5_ ? getInitParam().sounds.ballTakePositiveSound : getInitParam().sounds.ballTakeNegativeSound;
         battleService.soundManager.playSound(_loc6_.sound);
      }
      
      public function notifyFlagReturned(param1:CommonFlag, param2:IGameObject) : void
      {
      }
      
      public function notifyFlagDropped(param1:CommonFlag) : void
      {
         this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
         if(param1.carrier != null)
         {
            this.guiModel.showUserBattleLogMessage(param1.carrierId,UserAction.RGB_PLAYER_LOOSE_BALL);
            this.ballDroppedCommon(param1);
         }
      }
      
      public function notifyFlagThrown(param1:CommonFlag) : void
      {
         this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
         if(param1.carrier != null)
         {
            this.guiModel.showUserBattleLogMessage(param1.carrierId,UserAction.RGB_PLAYER_THREW_BALL);
            this.ballDroppedCommon(param1);
         }
      }
      
      private function ballDroppedCommon(param1:CommonFlag) : void
      {
         var _loc2_:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
         var _loc3_:Boolean = Boolean(_loc2_) && _loc2_.teamType != param1.carrier.teamType;
         var _loc4_:SoundResource = _loc3_ ? getInitParam().sounds.ballDropPositiveSound : getInitParam().sounds.ballDropNegativeSound;
         battleService.soundManager.playSound(_loc4_.sound);
      }
      
      public function notifyFlagDelivered(param1:CommonFlag, param2:Tank) : void
      {
         this.guiModel.showUserBattleLogMessage(param2.getUser().id,UserAction.RGB_PLAYER_DELIVER_BALL);
         var _loc3_:FlagMessage = this.messages.getMessage(RugbyMessages.GOAL,param2.teamType);
         this.guiModel.showBattleMessage(_loc3_.color,_loc3_.text);
         this.guiModel.setIndicatorState(param2.teamType,FlagIndicator.STATE_FLASHING);
         this.guiModel.setIndicatorState(this.oppositeTeam(param2.teamType),FlagIndicator.STATE_DEFAULT);
         var _loc4_:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
         var _loc5_:Boolean = Boolean(_loc4_) && _loc4_.teamType == param2.teamType;
         var _loc6_:SoundResource = _loc5_ ? getInitParam().sounds.goalPositiveSound : getInitParam().sounds.goalNegativeSound;
         battleService.soundManager.playSound(_loc6_.sound);
         this.nextNotificationTime = getTimer() + 1500;
         battleService.getBattleRunner().addLogicUnit(this);
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         if(param1 >= this.nextNotificationTime)
         {
            this.notifyReadyToFaceOff();
            battleService.getBattleRunner().removeLogicUnit(this);
         }
      }
      
      public function getBattleType() : BattleType
      {
         return BattleType.RUGBY;
      }
      
      public function notifyFlagFacedOff(param1:CommonFlag) : void
      {
         var _loc2_:FlagMessage = this.messages.getFacedOffMessage();
         this.guiModel.showBattleMessage(_loc2_.color,_loc2_.text);
         this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
         battleService.soundManager.playSound(getInitParam().sounds.ballFaceOffSound.sound);
      }
      
      public function notifyReadyToFaceOff() : void
      {
         this.guiModel.setBothIndicatorsState(FlagIndicator.STATE_DEFAULT,FlagIndicator.STATE_DEFAULT);
         var _loc1_:FlagMessage = this.messages.getReadyToFaceOffMessage();
         this.guiModel.showBattleMessage(_loc1_.color,_loc1_.text);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      private function onBattleFinish(param1:Object) : void
      {
         if(this.ball.isFlying())
         {
            this.ball.stopFalling();
            this.ball.returnToBase();
         }
      }
      
      private function onBattleRestart(param1:Object) : void
      {
         FlagNotification(object.adapt(FlagNotification)).notifyReadyToFaceOff();
      }
      
      private function oppositeTeam(param1:BattleTeam) : BattleTeam
      {
         if(param1 == BattleTeam.BLUE)
         {
            return BattleTeam.RED;
         }
         if(param1 == BattleTeam.RED)
         {
            return BattleTeam.BLUE;
         }
         return BattleTeam.NONE;
      }
   }
}

