package alternativa.tanks.models.statistics
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.LogicUnit;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.notificationpausefinish.NotificationEndsPauseSupport;
   import alternativa.tanks.models.battle.battlefield.BattleModel;
   import alternativa.tanks.models.battle.battlefield.BattleType;
   import alternativa.tanks.models.battle.battlefield.event.BattleRenameEvent;
   import alternativa.tanks.models.battle.ctf.MessageColor;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.gui.chat.IBattleChat;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.Widget;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.score.BattleStatistics;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.wink.WinkManager;
   import alternativa.tanks.models.battle.gui.gui.statistics.fps.FPSText;
   import alternativa.tanks.models.battle.gui.gui.statistics.messages.BattleMessages;
   import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
   import alternativa.tanks.models.battle.gui.statistics.DefaultLayout;
   import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
   import alternativa.tanks.models.battlemessages.BattlefieldMessages;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.types.Long;
   import alternativa.utils.removeDisplayObject;
   import flash.display.DisplayObjectContainer;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battlefield.types.DamageType;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.client.battleservice.model.statistics.IStatisticsModelBase;
   import projects.tanks.client.battleservice.model.statistics.StatisticsModelBase;
   import projects.tanks.client.battleservice.model.statistics.UserReward;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;
   import scpacker.utils.EnumUtils;
   
   [ModelInfo]
   public class StatisticsModel extends StatisticsModelBase implements IStatisticsModelBase, IStatisticsModel, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, BattlefieldGUI, LogicUnit
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var settingsService:ISettingsService;
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject] // added
      public static var helpService:IHelpService;
      
      [Inject] // added
      public static var battleGUIService:BattleGUIService;
      
      [Inject] // added
      public static var battleFormatUtil:BattleFormatUtil;
      
      [Inject] // added
      public static var localTankInfoService:LocalTankInfoService;
      
      [Inject] // added
      public static var battleInfoService:IBattleInfoService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private var playerJoinedMessage:String;
      
      private var playerLeftMessage:String;
      
      private var fpsIndicator:FPSText;
      
      private var battleMessages:BattleMessages;
      
      private var battlefieldMessages:BattlefieldMessages;
      
      private var battleStatistics:BattleStatistics;
      
      private var defaultLayout:DefaultLayout;
      
      public function StatisticsModel()
      {
         super();
         this.fpsIndicator = new FPSText();
         WinkManager.init(500);
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         this.battlefieldMessages.update(param2);
      }
      
      public function getBattleName() : String
      {
         if(Boolean(getInitParam().battleName))
         {
            return getInitParam().battleName;
         }
         return this.getDefaultBattleName();
      }
      
      private function getDefaultBattleName() : String
      {
         //var _loc1_:String = getInitParam().matchBattle ? BattleInfoUtils.buildBattleName(getInitParam().battleName,getInitParam().modeName) : getInitParam().battleName;
         //var _loc2_:String = getInitParam().equipmentConstraintsMode;
         //var _loc3_:Boolean = Boolean(getInitParam().parkourMode);
         //if(battleFormatUtil.isFormatBattle(_loc2_,_loc3_))
         //{
         //   _loc1_ = _loc1_ + " " + battleFormatUtil.getShortFormatName(_loc2_,_loc3_);
         //}
         return getInitParam().battleName;
      }
      
      public function userConnect(param1:ShortUserInfo) : void
      {
         this.battleMessages.addUserActionMessage(param1,UserAction.PLAYER_JOIN_THE_BATTLE);
      }
      
      public function userDisconnect(param1:ShortUserInfo) : void
      {
         this.battleMessages.addUserActionMessage(param1,UserAction.PLAYER_LEAVE_THE_BATTLE);
      }
      
      public function updateUserKills(param1:String, param2:int) : void
      {
         this.battleStatistics.updateUserKills(param1,param2);
      }
      
      public function changeTeamScore(param1:BattleTeam, param2:int) : void
      {
         this.battleStatistics.setTeamScore(param1,param2);
      }
      
      public function logUserAction(param1:String, param2:UserAction, param3:String) : void
      {
         var _loc4_:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
         var _loc5_:ShortUserInfo = _loc4_.getShortUserInfo(param1);
         var _loc6_:ShortUserInfo = param3 == null ? null : _loc4_.getShortUserInfo(param3);
         this.battleMessages.addTwoUsersActionMessage(_loc5_,param2,_loc6_);
      }

      public function logUserActionText(param1:String, text:String) : void
      {
         var _loc4_:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
         var _loc5_:ShortUserInfo = _loc4_.getShortUserInfo(param1);
         this.battleMessages.addUserTextActionMessage(_loc5_,text);
      }
      
      public function logKillAction(param1:String, param2:String, param3:DamageType) : void
      {
         var _loc4_:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
         var _loc5_:ShortUserInfo = _loc4_.getShortUserInfo(param1);
         var _loc6_:ShortUserInfo = _loc4_.getShortUserInfo(param2);
         this.battleMessages.addKillMessage(_loc5_,_loc6_,param3);
      }
      
      public function setIndicatorState(param1:BattleTeam, param2:int) : void
      {
         this.battleStatistics.setIndicatorState(param1,param2);
      }
      
      public function setBothIndicatorsState(param1:int, param2:int) : void
      {
         this.battleStatistics.setBothIndicatorsState(param1,param2);
      }
      
      public function showBattleMessage(param1:uint, param2:String) : void
      {
         this.battlefieldMessages.addMessage(param1,param2);
      }
      
      public function showPointBattleLogMessage(param1:String, param2:UserAction) : void
      {
         this.battleMessages.addPointActionMessage(param1,param2);
      }
      
      public function showUserBattleLogMessage(param1:String, param2:UserAction) : void
      {
         var _loc3_:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
         var _loc4_:ShortUserInfo = _loc3_.getShortUserInfo(param1);
         if(Boolean(_loc4_))
         {
            this.battleMessages.addUserActionMessage(_loc4_,param2);
         }
      }
      
      public function showBattleLogMessage(param1:UserAction) : void
      {
         this.battleMessages.addSimpleActionMessage(param1);
      }
      
      public function addWidget(param1:Widget) : void
      {
         this.defaultLayout.addWidget(param1);
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         battleInfoService.running = true; // hard coded
         this.playerJoinedMessage = localeService.getText(TanksLocale.TEXT_BATTLE_PLAYER_JOINED);
         this.playerLeftMessage = localeService.getText(TanksLocale.TEXT_BATTLE_PLAYER_LEFT);
         var _loc1_:BattleUserInfoServiceImpl = new BattleUserInfoServiceImpl(object);
         putData(BattleUserInfoServiceImpl,_loc1_);
         putData(PauseIndicatorSupport,new PauseIndicatorSupport());
         putData(NotificationEndsPauseSupport,new NotificationEndsPauseSupport());
         putData(TankKillLogger,new TankKillLogger(object));
         putData(FpsIndicatorToggleSupport,new FpsIndicatorToggleSupport(this.fpsIndicator));
         var _loc2_:DisplayObjectContainer = battleGUIService.getGuiContainer();
         //var _loc3_:BattleType = BattleModel(object.adapt(BattleModel)).getBattleType(); // original
         var _loc3_:BattleType = EnumUtils.battleModeToBattleType(getInitParam().battleMode);
         var _loc4_:Boolean = Boolean(getInitParam().valuableRound);
         this.battleStatistics = new BattleStatistics(userPropertiesService.userId,getInitParam(),_loc3_,_loc4_);
         _loc2_.addChild(this.battleStatistics);
         this.defaultLayout = new DefaultLayout();
         this.defaultLayout.addWidget2(this.battleStatistics);
         this.defaultLayout.init();
         this.battlefieldMessages = new BattlefieldMessages();
         _loc2_.addChild(this.battlefieldMessages);
         putData(BattlefieldMessagesAligner,new BattlefieldMessagesAligner(this.battlefieldMessages));
         this.battleMessages = new BattleMessages();
         _loc2_.addChild(this.battleMessages);
         if(settingsService.showFPS)
         {
            _loc2_.addChild(this.fpsIndicator);
         }
         if(getInitParam().spectator)
         {
            this.createSpectatorScreenLayouts();
         }
         else
         {
            putData(ControlsMiniHelpSupport,new ControlsMiniHelpSupport());
            putData(ControlsHelpSupport,new ControlsHelpSupport());
         }
      }
      
      private function battleHasTimeLimit() : Boolean
      {
         return getInitParam().limits.timeLimitInSec > 0;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:Boolean = false;
         this.markSuspectedUsers(getInitParam().suspiciousUserIds);
         battleService.getBattleRunner().addLogicUnit(this);
         if(this.battleHasTimeLimit())
         {
            _loc1_ = Boolean(getInitParam().spectator);
            if(!_loc1_ || _loc1_ && this.battleUserInfoService().getUsersCount() > 0)
            {
               this.battleStatistics.startCountdownTimeLimit(getInitParam().timeLeft);
            }
         }
      }
      
      private function createSpectatorScreenLayouts() : void
      {
         var _loc1_:IBattleChat = IBattleChat(object.adapt(IBattleChat));
         putData(SpectatorScreenLayouts,new SpectatorScreenLayouts(_loc1_.getChat(),this.battleMessages,this.battlefieldMessages,this.battleStatistics,this.fpsIndicator));
      }
      
      private function markSuspectedUsers(param1:Vector.<String>) : void
      {
         var _loc2_:String = null;
         for each(_loc2_ in param1)
         {
            this.setUserSuspiciousness(_loc2_,true);
         }
      }
      
      private function setUserSuspiciousness(param1:String, param2:Boolean) : void
      {
         var _loc3_:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
         _loc3_.suspiciousnessChanged(param1,param2);
         var _loc4_:BattleUserInfoServiceImpl = this.battleUserInfoService();
         _loc4_.dispatchSuspiciousnessChange(param1,param2);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         removeDisplayObject(this.battleStatistics);
         removeDisplayObject(this.battleMessages);
         removeDisplayObject(this.fpsIndicator);
         this.battleStatistics = null;
         battleService.getBattleRunner().removeLogicUnit(this);
         this.battleMessages = null;
         this.battlefieldMessages.removeFromParent();
         this.battlefieldMessages = null;
         this.defaultLayout.destroy();
         this.defaultLayout = null;
      }
      
      [Obfuscation(rename="false")]
      public function fundChange(param1:int) : void
      {
         this.battleStatistics.updateFund(param1);
      }
      
      [Obfuscation(rename="false")]
      public function roundStart(param1:int, param2:Boolean) : void
      {
         battleInfoService.running = true;
         this.battleStatistics.initOnRoundStart(param2);
         if(this.battleHasTimeLimit())
         {
            this.battleStatistics.startCountdownTimeLimit(param1);
         }
         var _loc3_:IStatisticRound = IStatisticRound(object.adapt(IStatisticRound));
         _loc3_.roundStart();
      }
      
      [Obfuscation(rename="false")]
      public function roundStop() : void
      {
         battleInfoService.running = false;
         if(this.battleHasTimeLimit())
         {
            this.battleStatistics.stopCountdownTimeLimit();
         }
         this.battleStatistics.resetFields();
         var _loc1_:IStatisticRound = IStatisticRound(object.adapt(IStatisticRound));
         _loc1_.roundStop();
      }
      
      [Obfuscation(rename="false")]
      public function roundFinish(param1:Boolean, param2:Vector.<UserReward>, param3:int) : void
      {
         battleInfoService.running = false;
         var _loc4_:IStatisticRound = IStatisticRound(object.adapt(IStatisticRound));
         _loc4_.roundFinish(getInitParam().matchBattle,param1,param3,param2);
         this.battleStatistics.finish();
      }
      
      [Obfuscation(rename="false")]
      public function statusProbablyCheaterChanged(param1:String, param2:Boolean) : void
      {
         this.setUserSuspiciousness(param1,param2);
      }
      
      [Obfuscation(rename="false")]
      public function onRankChanged(param1:String, param2:int, param3:Boolean) : void
      {
         var _loc5_:BattleUserInfoServiceImpl = null;
         var _loc4_:IClientUserInfo = IClientUserInfo(object.adapt(IClientUserInfo));
         _loc4_.rankChanged(param1,param2);
         if(Boolean(localTankInfoService.isLocalTankLoaded()) && param1 == localTankInfoService.getLocalTank().getUserId())
         {
            ControlsMiniHelpSupport(getData(ControlsMiniHelpSupport)).close();
         }
         if(!param3)
         {
            _loc5_ = this.battleUserInfoService();
            _loc5_.dispatchRankChange(param1,param2);
         }
      }

      public function onComplaintConfirmed() : void
      {
         this.battlefieldMessages.addMessage(16776960,localeService.getText("TEXT_TEAM_KICK_COMPLAINT_SENT"));
      }
      
      public function turnOnTimerToRestoreBalance(param1:int) : void
      {
         this.battleStatistics.turnOnTimerToRestoreBalance(param1);
      }
      
      public function turnOffTimerToRestoreBalance() : void
      {
         this.battleStatistics.turnOffTimerToRestoreBalance();
      }
      
      private function battleUserInfoService() : BattleUserInfoServiceImpl
      {
         return BattleUserInfoServiceImpl(getData(BattleUserInfoServiceImpl));
      }
      
      public function notifyAboutTraining(param1:int) : void
      {
         this.battlefieldMessages.addMessageWithDuration(MessageColor.ORANGE,localeService.getText(TanksLocale.TEXT_TOURNAMENT_BATTLE_TRAINING_LABEL),param1 * 1000);
      }
      
      public function notifyAboutBattle(param1:int) : void
      {
         this.battlefieldMessages.addMessageWithDuration(MessageColor.RED,localeService.getText(TanksLocale.TEXT_TOURNAMENT_BATTLE_STARTING_LABEL),param1 * 1000);
      }
      
      public function getTimeLeftInSec() : int
      {
         return getInitParam().timeLeft;
      }
      
      public function setBattleName(param1:String) : void
      {
         battleEventDispatcher.dispatchEvent(new BattleRenameEvent(param1));
      }
      
      public function resetBattleName() : void
      {
         battleEventDispatcher.dispatchEvent(new BattleRenameEvent(this.getDefaultBattleName()));
      }
   }
}

