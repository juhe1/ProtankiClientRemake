package alternativa.tanks.models.statistics.dm
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.gui.battle.BattleFinishDmNotification;
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
   import platform.client.fp10.core.model.IObjectLoadListener;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   import projects.tanks.client.battleservice.model.statistics.UserReward;
   import projects.tanks.client.battleservice.model.statistics.UserStat;
   import projects.tanks.client.battleservice.model.statistics.dm.IStatisticsDMModelBase;
   import projects.tanks.client.battleservice.model.statistics.dm.StatisticsDMModelBase;
   import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
   import projects.tanks.clients.flash.commons.services.notification.INotificationService;
   import projects.tanks.clients.flash.commons.services.serverhalt.IServerHaltService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.BattleUserPremiumService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   
   [ModelInfo]
   public class StatisticsDmModel extends StatisticsDMModelBase implements IStatisticsDMModelBase, IObjectLoadListener, IClientUserInfo, BattleEventListener, IStatisticRound
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
      public static var reconnectService:ReconnectService;
      
      [Inject]
      public static var starsEventService:ChallengeInfoService;
      
      [Inject]
      public static var battlePremiumService:BattleUserPremiumService;

      [Inject]
      public static var userInfoService:BattleUserInfoService;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var statisticsTable:StatisticsTable;
      
      private var clientUsersInfo:Dictionary;
      
      private var clientUsersStat:Vector.<ClientUserStat>;
      
      private var usersCount:int;
      
      public function StatisticsDmModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
         this.battleEventSupport.addEventHandler(BattleRenameEvent,this.onBattleRename);
      }
      
      private static function createUsersInfo(param1:Vector.<UserInfo>) : Dictionary
      {
         var _loc5_:ClientUserInfo = null;
         var _loc6_:UserInfo = null;
         var _loc7_:ClientUserInfo = null;
         var _loc2_:Dictionary = new Dictionary();
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = param1[_loc4_];
            _loc7_ = StatisticsVectorUtils.createClientUserInfo(_loc6_,BattleTeam.NONE);
            _loc2_[_loc6_.user] = _loc7_;
            _loc4_++;
         }
         for each(_loc5_ in _loc2_)
         {
            _loc5_.loaded = true;
         }
         return _loc2_;
      }
      
      private function onBattleRename(param1:BattleRenameEvent) : void
      {
         this.statisticsTable.setBattleName(param1.name);
      }
      
      private function onTankLoaded(param1:TankLoadedEvent) : void
      {
         var userName:String = userInfoService.getUserName(param1.tank.getUserId());
         var _loc2_:ClientUserStat = this.getUserStat(userName);
         _loc2_.loaded = true;
         this.statisticsTable.updatePlayerDm(_loc2_);
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:Vector.<UserInfo> = getInitParam().usersInfo;
         battlePremiumService.setUsersPremium(_loc1_);
         this.clientUsersInfo = createUsersInfo(_loc1_);
         this.clientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,getInitParam().usersInfo);
         this.usersCount = getInitParam().usersInfo.length;
         var _loc2_:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
         this.statisticsTable = new StatisticsTable(_loc2_.getBattleName(),false);
         this.statisticsTable.addEventListener(ContinueBattleEvent.EXIT,getFunctionWrapper(this.onExit));
         this.statisticsTable.addEventListener(ContinueBattleEvent.CONTINUE,getFunctionWrapper(this.onContinue));
         battleGUIService.getTabContainer().addChild(this.statisticsTable);
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         this.battleEventSupport.activateHandlers();
         display.stage.addEventListener(KeyboardEvent.KEY_DOWN,getFunctionWrapper(this.onKeyDown));
         display.stage.addEventListener(KeyboardEvent.KEY_UP,getFunctionWrapper(this.onKeyUp));
         display.stage.addEventListener(Event.DEACTIVATE,this.onFlashDeactivate);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.TAB && !battleInputService.isInputLocked())
         {
            this.showScores();
         }
      }
      
      private function showScores() : void
      {
         if(battleInfoService.running)
         {
            this.statisticsTable.showDm(false,false,userPropertiesService.userId,this.clientUsersStat,false,0);
         }
      }
      
      private function hideScores() : void
      {
         if(battleInfoService.running)
         {
            this.statisticsTable.hide();
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
         this.clientUsersInfo.length = 0;
         this.clientUsersStat.length = 0;
         this.clientUsersStat = null;
         this.clientUsersInfo = null;
         this.usersCount = 0;
         battlePremiumService.removeUsersPremium();
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloadedPost() : void
      {
      }
      
      [Obfuscation(rename="false")]
      public function changeUserStat(param1:UserStat) : void
      {
         var _loc2_:ClientUserStat = StatisticsVectorUtils.changeUserStat(this.clientUsersStat,param1);
         this.statisticsTable.updatePlayerDm(_loc2_);
         var _loc3_:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
         _loc3_.updateUserKills(_loc2_.userId,_loc2_.kills);
      }
      
      [Obfuscation(rename="false")]
      public function refreshUsersStat(param1:Vector.<UserStat>) : void
      {
         this.clientUsersStat = StatisticsVectorUtils.refreshUsersStat(this.clientUsersInfo,param1);
         var _loc2_:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.updateUserKills(param1[_loc4_].user,param1[_loc4_].kills);
            _loc4_++;
         }
         this.statisticsTable.updatePlayersDm(this.clientUsersStat);
      }
      
      [Obfuscation(rename="false")]
      public function userConnect(param1:String, param2:Vector.<UserInfo>) : void
      {
         var _loc3_:UserInfo = StatisticsVectorUtils.getUserInfo(param1,param2);
         this.clientUsersInfo[param1] = StatisticsVectorUtils.createClientUserInfo(_loc3_,BattleTeam.NONE);
         ++this.usersCount;
         battlePremiumService.setUsersPremium(param2);
         this.clientUsersStat = StatisticsVectorUtils.createUsersStat(this.clientUsersInfo,param2);
         if(battleInfoService.running)
         {
            this.statisticsTable.updatePlayersDm(this.clientUsersStat);
         }
      }
      
      [Obfuscation(rename="false")]
      public function userDisconnect(param1:String) : void
      {
         if(battleInfoService.running)
         {
            this.statisticsTable.removePlayer(param1,BattleTeam.NONE);
         }
         var _loc2_:IStatisticsModel = IStatisticsModel(object.adapt(IStatisticsModel));
         var _loc3_:ClientUserInfo = this.clientUsersInfo[param1];
         _loc2_.userDisconnect(_loc3_.getShortUserInfo());
         delete this.clientUsersInfo[param1];
         --this.usersCount;
         this.clientUsersStat = StatisticsVectorUtils.deleteUserStat(this.clientUsersStat,param1);
         battlePremiumService.resetUserPremium(param1);
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
      
      public function suspiciousnessChanged(param1:String, param2:Boolean) : void
      {
         var _loc3_:ClientUserStat = this.getUserStat(param1);
         if(_loc3_ != null)
         {
            _loc3_.suspicious = param2;
            this.statisticsTable.updatePlayerDm(_loc3_);
         }
      }
      
      public function rankChanged(param1:String, param2:int) : void
      {
         var _loc3_:ClientUserStat = this.getUserStat(param1);
         _loc3_.rank = param2;
         this.statisticsTable.updatePlayerDm(_loc3_);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function roundStart() : void
      {
         this.statisticsTable.hide();
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
         StatisticsVectorUtils.updateReward(this.clientUsersStat,param4);
         if(param2)
         {
            param3 = serverHaltService.isServerHalt ? -1 : param3;
            _loc5_ = param1 && Boolean(starsEventService.isInTime());
            this.statisticsTable.showDm(param1,_loc5_,userPropertiesService.userId,this.clientUsersStat,true,param3);
            if(Boolean(lobbyLayoutService.isWindowOpenOverBattle()) && !battleInfoService.isSpectatorMode())
            {
               _loc6_ = StatisticsVectorUtils.getRewardById(userPropertiesService.userId,param4);
               _loc7_ = _loc6_.reward + _loc6_.premiumBonusReward + _loc6_.newbiesAbonementBonusReward;
               notificationService.addNotification(new BattleFinishDmNotification(this.getLocalUserPlace(),this.clientUsersStat.length,_loc7_,0,_loc5_));
            }
         }
      }
      
      private function getLocalUserPlace() : int
      {
         return StatisticsVectorUtils.getUserPosition(this.clientUsersStat,userPropertiesService.userId) + 1;
      }
      
      private function getUserStat(param1:String) : ClientUserStat
      {
         return StatisticsVectorUtils.getClientUserStat(this.clientUsersStat,param1);
      }
      
      public function getUsersCount() : int
      {
         return this.usersCount;
      }
   }
}

