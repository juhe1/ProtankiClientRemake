package alternativa.tanks.models.battle.assault
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleRestartEvent;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.battlefield.BattleModel;
   import alternativa.tanks.models.battle.battlefield.BattleType;
   import alternativa.tanks.models.battle.commonflag.CommonFlag;
   import alternativa.tanks.models.battle.commonflag.Flag;
   import alternativa.tanks.models.battle.commonflag.FlagNotification;
   import alternativa.tanks.models.battle.commonflag.ICommonFlagModeModel;
   import alternativa.tanks.models.battle.commonflag.IFlagModeInitilizer;
   import alternativa.tanks.models.battle.commonflag.MarkersUtils;
   import alternativa.tanks.models.battle.ctf.FlagMessage;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
   import alternativa.tanks.models.battle.gui.markers.PointHudIndicator;
   import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
   import projects.tanks.client.battlefield.models.battle.pointbased.assault.AssaultCC;
   import projects.tanks.client.battlefield.models.battle.pointbased.assault.AssaultModelBase;
   import projects.tanks.client.battlefield.models.battle.pointbased.assault.AssaultSoundFX;
   import projects.tanks.client.battlefield.models.battle.pointbased.assault.IAssaultModelBase;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   
   [ModelInfo]
   public class AssaultModel extends AssaultModelBase implements IAssaultModelBase, IFlagModeInitilizer, FlagNotification, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, BattleEventListener, BattleModel
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var lightingEffectsService:ILightingEffectsService;
      
      [Inject]
      public static var materialRegistry:TextureMaterialRegistry;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var userPropertiesService:IUserPropertiesService;
      
      private var guiModel:BattlefieldGUI;
      
      private var flagReturnSound:Sound;
      
      private var flagTakeSound:Sound;
      
      private var winSound:Sound;
      
      private var flagLostSound:Sound;
      
      private var flagHudIndicators:AssaultHudIndicators;
      
      private var messages:AssaultMessages = new AssaultMessages();
      
      private var battleEventSupport:BattleEventSupport;
      
      private var flags:Vector.<Flag> = new Vector.<Flag>();
      
      public function AssaultModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
      }
      
      public function getBattleType() : BattleType
      {
         return BattleType.AS;
      }
      
      public function objectLoaded() : void
      {
         this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
         var _loc1_:AssaultSoundFX = getInitParam().sounds;
         this.flagReturnSound = _loc1_.flagReturnSound.sound;
         this.flagTakeSound = _loc1_.flagTakeSound.sound;
         this.winSound = _loc1_.winSound.sound;
         this.flagLostSound = _loc1_.flagDropSound.sound;
      }
      
      public function objectLoadedPost() : void
      {
         this.battleEventSupport.activateHandlers();
      }
      
      public function objectUnloaded() : void
      {
         this.battleEventSupport.deactivateHandlers();
      }
      
      public function init(param1:Vector.<ClientFlag>, param2:Vector.<ClientTeamPoint>) : void
      {
         var _loc6_:ClientTeamPoint = null;
         var _loc7_:ClientFlag = null;
         var _loc8_:Flag = null;
         var _loc9_:Flag = null;
         var _loc10_:Object3D = null;
         var _loc3_:ICommonFlagModeModel = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel));
         var _loc4_:Dictionary = new Dictionary();
         var _loc5_:AssaultCC = getInitParam();
         this.flagHudIndicators = new AssaultHudIndicators();
         for each(_loc6_ in param2)
         {
            if(_loc6_.id >= 0)
            {
               _loc4_[_loc6_.id] = _loc6_.flagBasePosition;
            }
         }
         for each(_loc7_ in param1)
         {
            _loc9_ = new Flag(_loc7_.flagId,_loc4_[_loc7_.flagId],BattleTeam.RED,_loc5_.flagSprite);
            this.flags.push(_loc9_);
            _loc3_.initFlag(_loc9_,_loc7_);
            this.flagHudIndicators.addRedFlag(_loc7_.flagId,_loc9_);
         }
         for each(_loc6_ in param2)
         {
            if(_loc6_.id < 0)
            {
               _loc3_.createBasePoint(_loc6_,_loc5_.pointPedestalModel);
               MarkersUtils.createMarkers(BattleTeam.BLUE,_loc5_.pointSmallMarker.data,_loc5_.pointBigMarker.data,new IndicatorStateAdapter(Vector3.fromVector3d(_loc6_.flagBasePosition)),true);
            }
            else
            {
               _loc10_ = _loc3_.createBasePoint(_loc6_,_loc5_.flagPedestalModel);
               this.flagHudIndicators.addRedBase(_loc6_.id,_loc10_);
            }
         }
         battleService.getBattleScene3D().addRenderer(this.flagHudIndicators);
         for each(_loc8_ in this.flags)
         {
            this.flagHudIndicators.setFlagState(_loc8_.id,_loc8_.state == FlagState.CARRIED ? PointHudIndicator.STATE_CARRIED : PointHudIndicator.STATE_DEFAULT);
         }
         if(battleInfoService.isSpectatorMode())
         {
            this.flagHudIndicators.setLocalTeam(BattleTeam.NONE);
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         var _loc2_:BattleTeam = null;
         var _loc3_:Flag = null;
         if(param1.isLocal)
         {
            _loc2_ = param1.tank.teamType;
            this.flagHudIndicators.setLocalTeam(_loc2_);
            for each(_loc3_ in this.flags)
            {
               _loc3_.hideIndicatorOnBase = _loc2_ == BattleTeam.BLUE;
            }
         }
      }
      
      private function onBattleRestart(param1:BattleRestartEvent) : void
      {
         var _loc2_:Flag = null;
         for each(_loc2_ in this.flags)
         {
            this.flagHudIndicators.setFlagState(_loc2_.id,PointHudIndicator.STATE_DEFAULT);
         }
      }
      
      public function guiShowFlagDropped(param1:CommonFlag) : void
      {
         this.guiModel.showUserBattleLogMessage(param1.carrierId,UserAction.ASL_RED_PLAYER_DROP_FLAG);
      }
      
      public function guiShowFlagCarried(param1:CommonFlag) : void
      {
      }
      
      public function guiShowFlagAtBase(param1:CommonFlag) : void
      {
      }
      
      public function notifyFlagTaken(param1:CommonFlag, param2:Tank) : void
      {
         battleService.soundManager.playSound(this.flagTakeSound);
         this.flagHudIndicators.setFlagState(param1.id,PointHudIndicator.STATE_CARRIED);
         this.guiModel.showUserBattleLogMessage(param2.getUser().id,UserAction.ASL_RED_PLAYER_PICK_FLAG);
      }
      
      public function notifyFlagReturned(param1:CommonFlag, param2:IGameObject) : void
      {
         battleService.soundManager.playSound(this.flagReturnSound);
         this.flagHudIndicators.setFlagState(param1.id,PointHudIndicator.STATE_DEFAULT);
      }
      
      public function notifyFlagDropped(param1:CommonFlag) : void
      {
         battleService.soundManager.playSound(this.flagLostSound);
         if(param1.carrier == null)
         {
            this.guiModel.showBattleLogMessage(UserAction.ASL_RED_PLAYER_DROP_FLAG);
         }
         else
         {
            this.guiModel.showUserBattleLogMessage(param1.carrierId,UserAction.ASL_RED_PLAYER_DROP_FLAG);
         }
      }
      
      public function notifyFlagDelivered(param1:CommonFlag, param2:Tank) : void
      {
         var _loc3_:Tank = ICommonFlagModeModel(object.adapt(ICommonFlagModeModel)).getLocalTank();
         var _loc4_:FlagMessage = this.messages.getMessage(Boolean(_loc3_) ? _loc3_.teamType : null);
         this.guiModel.showBattleMessage(_loc4_.color,_loc4_.text);
         this.guiModel.showUserBattleLogMessage(param2.getUser().id,UserAction.ASL_RED_PLAYER_DELIVER_FLAG);
         battleService.soundManager.playSound(this.winSound);
         this.flagHudIndicators.setFlagState(param1.id,PointHudIndicator.STATE_DEFAULT);
      }
      
      public function notifyFlagFacedOff(param1:CommonFlag) : void
      {
      }
      
      public function notifyReadyToFaceOff() : void
      {
      }
      
      public function notifyFlagThrown(param1:CommonFlag) : void
      {
      }
   }
}

