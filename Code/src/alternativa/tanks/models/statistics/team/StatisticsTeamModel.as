package alternativa.tanks.models.statistics.team
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.gui.battle.BattleFinishTeamNotification;
   import alternativa.tanks.models.battle.battlefield.event.BattleRenameEvent;
   import alternativa.tanks.models.battle.battlefield.event.ContinueBattleEvent;
   import alternativa.tanks.models.battle.gui.gui.statistics.table.StatisticsTable;
   import alternativa.tanks.models.battle.gui.statistics.ClientUserInfo;
   import alternativa.tanks.models.battle.gui.statistics.ClientUserStat;
   import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
   import alternativa.tanks.models.battle.gui.statistics.StatisticsVectorUtils;
   import alternativa.tanks.models.continuebattle.ContinueBattle;
   import alternativa.tanks.models.statistics.IClientUserInfo;
   import alternativa.tanks.models.statistics.IStatisticRound;
   import alternativa.tanks.models.statistics.IStatisticsModel;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import alternativa.types.Long;
   import alternativa.utils.removeDisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import forms.ChangeTeamAlert;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   import projects.tanks.client.battleservice.model.statistics.UserReward;
   import projects.tanks.client.battleservice.model.statistics.UserStat;
   import projects.tanks.client.battleservice.model.statistics.team.IStatisticsTeamModelBase;
   import projects.tanks.client.battleservice.model.statistics.team.StatisticsTeamModelBase;
   import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
   import projects.tanks.clients.flash.commons.services.notification.INotificationService;
   import projects.tanks.clients.flash.commons.services.serverhalt.IServerHaltService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.BattleUserPremiumService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   
   [ModelInfo]
   public class StatisticsTeamModel extends StatisticsTeamModelBase implements IStatisticsTeamModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener, IClientUserInfo, BattleEventListener, IStatisticRound
   {
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject]
      public static var serverHaltService:IServerHaltService;
      
      [Inject]
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var battleGUIService:BattleGUIService;
      
      [Inject]
      public static var battleInputService:BattleInputService;
      
      [Inject]
      public static var notificationService:INotificationService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      [Inject]
      public static var challengeInfoService:ChallengeInfoService;
      
      [Inject]
      public static var battlePremiumService:BattleUserPremiumService;

      [Inject]
      public static var userInfoService:BattleUserInfoService;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var statisticsTable:StatisticsTable;
      
      private var redClientUsersStat:Vector.<ClientUserStat>;
      
      private var blueClientUsersStat:Vector.<ClientUserStat>;
      
      private var clientUsersInfo:Dictionary;
      
      private var localUserTeam:BattleTeam;
      
      private var localUserTankTeamType:BattleTeam;
      
      private var scoreRed:int;
      
      private var scoreBlue:int;
      
      private var usersCount:int;
      
      public function StatisticsTeamModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
         this.battleEventSupport.addEventHandler(BattleRenameEvent,this.onBattleRename);
      }
      
      private static function showChangeTeamAlert(param1:BattleTeam) : void
      {
         var _loc2_:ChangeTeamAlert = new ChangeTeamAlert(3,param1 == BattleTeam.RED ? int(ChangeTeamAlert.RED) : int(ChangeTeamAlert.BLUE));
         _loc2_.x = display.stage.stageWidth - _loc2_.width >> 1;
         _loc2_.y = display.stage.stageHeight - _loc2_.height >> 1;
         battleGUIService.getGuiContainer().addChild(_loc2_);
      }
      
      private static function createUsersInfo(param1:Vector.<UserInfo>, param2:Vector.<UserInfo>) : Dictionary
      {
         var _loc4_:UserInfo = null;
         var _loc5_:UserInfo = null;
         var _loc6_:ClientUserInfo = null;
         var _loc3_:Dictionary = new Dictionary();
         for each(_loc4_ in param1)
         {
            _loc3_[_loc4_.user] = StatisticsVectorUtils.createClientUserInfo(_loc4_,BattleTeam.RED);
         }
         for each(_loc5_ in param2)
         {
            _loc3_[_loc5_.user] = StatisticsVectorUtils.createClientUserInfo(_loc5_,BattleTeam.BLUE);
         }
         for each(_loc6_ in _loc3_)
         {
            _loc6_.loaded = true;
         }
         return _loc3_;
      }
      
      private static function updateBattleTeam(param1:Vector.<ClientUserStat>, param2:BattleTeam) : void
      {
         var _loc5_:ClientUserStat = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_ == null)
            {
               break;
            }
            _loc5_.teamType = param2;
            _loc4_++;
         }
      }
      
      private function onBattleRename(param1:BattleRenameEvent) : void
      {
         this.statisticsTable.setBattleName(param1.name);
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         if(param1.tank.getUserId() == userPropertiesService.userId)
         {
            if(param1.tank.teamType != this.localUserTankTeamType)
            {
               this.localUserTankTeamType = param1.tank.teamType;
               showChangeTeamAlert(this.localUserTankTeamType);
            }
         }
      }
      
      private function onTankLoaded(param1:TankLoadedEvent) : void
      {
         var userName:String = userInfoService.getUserName(param1.tank.getUserId());
         var _loc2_:ClientUserStat = this.getUserStat(userName);
         _loc2_.loaded = true;
         this.statisticsTable.updatePlayerTeam(_loc2_);
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         this.localUserTankTeamType = BattleTeam.NONE;
         var _loc1_:Vector.<UserInfo> = getInitParam().usersInfoRed.slice();
         _loc1_ = _loc1_.concat(getInitParam().usersInfoBlue);
         battlePremiumService.setUsersPremium(_loc1_);
         this.clientUsersInfo = createUsersInfo(getInitParam().usersInfoRed,getInitParam().usersInfoBlue);
         this.usersCount = getInitParam().usersInfoRed.length + getInitParam().usersInfoBlue.length;
         this.redClientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,getInitParam().usersInfoRed);
         this.blueClientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,getInitParam().usersInfoBlue);
         var _loc2_:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
         this.statisticsTable = new StatisticsTable(_loc2_.getBattleName(),true);
         this.statisticsTable.addEventListener(ContinueBattleEvent.EXIT,getFunctionWrapper(this.onExit));
         this.statisticsTable.addEventListener(ContinueBattleEvent.CONTINUE,getFunctionWrapper(this.onContinue));
         battleGUIService.getTabContainer().addChild(this.statisticsTable);
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         this.changeTeamScore(BattleTeam.RED,getInitParam().redScore);
         this.changeTeamScore(BattleTeam.BLUE,getInitParam().blueScore);
         this.updateLocalUserTeam();
         this.battleEventSupport.activateHandlers();
         display.stage.addEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKeyDown));
         display.stage.addEventListener(KeyboardEvent.KEY_UP,getFunctionWrapper(this.onKeyUp));
         display.stage.addEventListener(Event.DEACTIVATE,this.onFlashDeactivate);
      }
      
      private function updateLocalUserTeam() : void
      {
         var _loc1_:ClientUserStat = this.getUserStat(userPropertiesService.userId);
         if(_loc1_ != null)
         {
            this.localUserTeam = _loc1_.teamType;
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.TAB && !battleInputService.isInputLocked())
         {
            this.showScores();
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.TAB)
         {
            this.hideScores();
         }
      }
      
      private function onFlashDeactivate(param1:Event) : void
      {
         this.hideScores();
      }
      
      private function showScores() : void
      {
         if(battleInfoService.running)
         {
            this.statisticsTable.showTeam(false,userPropertiesService.userId,this.redClientUsersStat,this.blueClientUsersStat,false,0,this.localUserTeam,false);
         }
      }
      
      private function hideScores() : void
      {
         if(battleInfoService.running)
         {
            this.statisticsTable.hide();
         }
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         this.battleEventSupport.deactivateHandlers();
         display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKeyDown));
         display.stage.removeEventListener(KeyboardEvent.KEY_UP,getFunctionWrapper(this.onKeyUp));
         display.stage.removeEventListener(Event.DEACTIVATE,this.onFlashDeactivate);
         this.statisticsTable.hide();
         this.statisticsTable.removeEventListener(ContinueBattleEvent.EXIT,getFunctionWrapper(this.onExit));
         this.statisticsTable.removeEventListener(ContinueBattleEvent.CONTINUE,getFunctionWrapper(this.onContinue));
         removeDisplayObject(this.statisticsTable);
         this.statisticsTable = null;
         this.redClientUsersStat = null;
         this.blueClientUsersStat = null;
         this.clientUsersInfo = null;
         this.localUserTankTeamType = null;
         this.usersCount = 0;
         battlePremiumService.removeUsersPremium();
      }
      
      [Obfuscation(rename="false")]
      public function changeTeamScore(param1:BattleTeam, param2:int) : void
      {
         if(param1 == BattleTeam.RED)
         {
            this.scoreRed = param2;
         }
         if(param1 == BattleTeam.BLUE)
         {
            this.scoreBlue = param2;
         }
         var _loc3_:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
         _loc3_.changeTeamScore(param1,param2);
      }
      
      [Obfuscation(rename="false")]
      public function userConnect(param1:String, param2:Vector.<UserInfo>, param3:BattleTeam) : void
      {
         var _loc4_:UserInfo = StatisticsVectorUtils.getUserInfo(param1,param2);
         this.clientUsersInfo[param1] = StatisticsVectorUtils.createClientUserInfo(_loc4_,param3);
         ++this.usersCount;
         battlePremiumService.setUsersPremium(param2);
         if(param3 == BattleTeam.RED)
         {
            this.redClientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,param2);
            if(battleInfoService.running)
            {
               this.statisticsTable.updatePlayersTeam(this.redClientUsersStat,param3);
            }
         }
         if(param3 == BattleTeam.BLUE)
         {
            this.blueClientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,param2);
            if(battleInfoService.running)
            {
               this.statisticsTable.updatePlayersTeam(this.blueClientUsersStat,param3);
            }
         }
      }
      
      [Obfuscation(rename="false")]
      public function userDisconnect(param1:String) : void
      {
         var _loc2_:ClientUserInfo = this.clientUsersInfo[param1];
         var _loc3_:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
         _loc3_.userDisconnect(_loc2_.getShortUserInfo());
         if(battleInfoService.running)
         {
            this.statisticsTable.removePlayer(param1,_loc2_.teamType);
         }
         if(_loc2_.teamType == BattleTeam.RED)
         {
            this.redClientUsersStat = StatisticsVectorUtils.deleteUserStat(this.redClientUsersStat,param1);
         }
         if(_loc2_.teamType == BattleTeam.BLUE)
         {
            this.blueClientUsersStat = StatisticsVectorUtils.deleteUserStat(this.blueClientUsersStat,param1);
         }
         delete this.clientUsersInfo[param1];
         --this.usersCount;
         battlePremiumService.resetUserPremium(param1);
      }
      
      [Obfuscation(rename="false")]
      public function changeUserStat(param1:UserStat, param2:BattleTeam) : void
      {
         var _loc3_:ClientUserStat = null;
         if(param2 == BattleTeam.RED)
         {
            _loc3_ = StatisticsVectorUtils.changeUserStat(this.redClientUsersStat,param1);
         }
         if(param2 == BattleTeam.BLUE)
         {
            _loc3_ = StatisticsVectorUtils.changeUserStat(this.blueClientUsersStat,param1);
         }
         var _loc4_:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
         _loc4_.updateUserKills(param1.user,param1.kills);
         this.statisticsTable.updatePlayerTeam(_loc3_);
      }
      
      [Obfuscation(rename="false")]
      public function refreshUsersStat(param1:Vector.<UserStat>, param2:BattleTeam) : void
      {
         if(param2 == BattleTeam.RED)
         {
            this.redClientUsersStat = StatisticsVectorUtils.refreshUsersStat(this.clientUsersInfo,param1);
            this.statisticsTable.updatePlayersTeam(this.redClientUsersStat,param2);
         }
         if(param2 == BattleTeam.BLUE)
         {
            this.blueClientUsersStat = StatisticsVectorUtils.refreshUsersStat(this.clientUsersInfo,param1);
            this.statisticsTable.updatePlayersTeam(this.blueClientUsersStat,param2);
         }
      }
      
      [Obfuscation(rename="false")]
      public function swapTeam(param1:Vector.<UserStat>, param2:Vector.<UserStat>) : void
      {
         this.redClientUsersStat = StatisticsVectorUtils.refreshUsersStat(this.clientUsersInfo,param1);
         this.blueClientUsersStat = StatisticsVectorUtils.refreshUsersStat(this.clientUsersInfo,param2);
         updateBattleTeam(this.redClientUsersStat,BattleTeam.RED);
         updateBattleTeam(this.blueClientUsersStat,BattleTeam.BLUE);
         this.updateLocalUserTeam();
         this.statisticsTable.updatePlayersTeam(this.redClientUsersStat,BattleTeam.RED);
         this.statisticsTable.updatePlayersTeam(this.blueClientUsersStat,BattleTeam.BLUE);
      }
      
      public function getShortUserInfo(param1:String) : ShortUserInfo
      {
         var _loc2_:ClientUserInfo = this.clientUsersInfo[param1];
         if(_loc2_ != null)
         {
            return _loc2_.getShortUserInfo();
         }
         return null;
      }
      
      public function isLoaded(param1:Long) : Boolean
      {
         var _loc2_:ClientUserInfo = this.clientUsersInfo[param1];
         return _loc2_ != null && _loc2_.loaded;
      }
      
      private function getUserStat(param1:String) : ClientUserStat
      {
         var _loc2_:ClientUserStat = StatisticsVectorUtils.getClientUserStat(this.redClientUsersStat,param1);
         if(_loc2_ == null)
         {
            _loc2_ = StatisticsVectorUtils.getClientUserStat(this.blueClientUsersStat,param1);
         }
         return _loc2_;
      }
      
      public function suspiciousnessChanged(param1:String, param2:Boolean) : void
      {
         var _loc3_:ClientUserStat = this.getUserStat(param1);
         if(_loc3_ != null)
         {
            _loc3_.suspicious = param2;
            this.statisticsTable.updatePlayerTeam(_loc3_);
         }
      }
      
      public function rankChanged(param1:String, param2:int) : void
      {
         var _loc3_:ClientUserStat = this.getUserStat(param1);
         _loc3_.rank = param2;
         this.statisticsTable.updatePlayerTeam(_loc3_);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function roundStart() : void
      {
         this.statisticsTable.hide();
         this.changeTeamScore(BattleTeam.RED,0);
         this.changeTeamScore(BattleTeam.BLUE,0);
      }
      
      public function roundStop() : void
      {
         this.statisticsTable.hide();
      }
      
      public function roundFinish(param1:Boolean, param2:Boolean, param3:int, param4:Vector.<UserReward>) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:UserReward = null;
         var _loc7_:int = 0;
         this.statisticsTable.hide();
         StatisticsVectorUtils.updateReward(this.redClientUsersStat,param4);
         StatisticsVectorUtils.updateReward(this.blueClientUsersStat,param4);
         if(param2)
         {
            _loc5_ = param1 && Boolean(challengeInfoService.isInTime());
            this.statisticsTable.showTeam(param1,userPropertiesService.userId,this.redClientUsersStat,this.blueClientUsersStat,true,serverHaltService.isServerHalt ? -1 : param3,this.localUserTeam,_loc5_);
         }
         if(param2 && Boolean(lobbyLayoutService.isWindowOpenOverBattle()) && !battleInfoService.isSpectatorMode())
         {
            _loc6_ = StatisticsVectorUtils.getRewardById(userPropertiesService.userId,param4);
            _loc7_ = _loc6_.reward + _loc6_.newbiesAbonementBonusReward + _loc6_.premiumBonusReward;
            notificationService.addNotification(new BattleFinishTeamNotification(this.isYourTeamVictory(),this.isYourTeamDefeat(),this.getLocalUserPlace(),this.getYourTeamPlaces(),_loc7_,0,_loc5_));
         }
      }
      
      private function isYourTeamVictory() : Boolean
      {
         if(this.localUserTeam == BattleTeam.RED)
         {
            return this.scoreRed > this.scoreBlue;
         }
         if(this.localUserTeam == BattleTeam.BLUE)
         {
            return this.scoreBlue > this.scoreRed;
         }
         return false;
      }
      
      private function isYourTeamDefeat() : Boolean
      {
         if(this.localUserTeam == BattleTeam.RED)
         {
            return this.scoreBlue > this.scoreRed;
         }
         if(this.localUserTeam == BattleTeam.BLUE)
         {
            return this.scoreRed > this.scoreBlue;
         }
         return false;
      }
      
      private function getYourTeamPlaces() : int
      {
         if(this.localUserTeam == BattleTeam.RED)
         {
            return this.redClientUsersStat.length;
         }
         if(this.localUserTeam == BattleTeam.BLUE)
         {
            return this.blueClientUsersStat.length;
         }
         return 0;
      }
      
      private function getLocalUserPlace() : int
      {
         var _loc1_:int = 0;
         if(this.localUserTeam == BattleTeam.RED)
         {
            _loc1_ = StatisticsVectorUtils.getUserPosition(this.redClientUsersStat,userPropertiesService.userId);
         }
         else if(this.localUserTeam == BattleTeam.BLUE)
         {
            _loc1_ = StatisticsVectorUtils.getUserPosition(this.blueClientUsersStat,userPropertiesService.userId);
         }
         return _loc1_ + 1;
      }
      
      private function onExit(param1:ContinueBattleEvent) : void
      {
         if(!lobbyLayoutService.isSwitchInProgress())
         {
            if(!battleInfoService.running)
            {
               lobbyLayoutService.exitFromBattleWithoutNotify();
            }
            else
            {
               lobbyLayoutService.exitFromBattle();
            }
         }
      }
      
      private function onContinue(param1:ContinueBattleEvent) : void
      {
         ContinueBattle(object.adapt(ContinueBattle)).continueBattle();
      }
      
      public function getUsersCount() : int
      {
         return this.usersCount;
      }
   }
}

