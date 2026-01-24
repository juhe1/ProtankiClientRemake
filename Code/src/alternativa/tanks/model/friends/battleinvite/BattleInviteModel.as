package alternativa.tanks.model.friends.battleinvite
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.friends.battleinvite.BattleInviteNotification;
   import alternativa.tanks.gui.friends.battleinvite.ResponseBattleInviteNotification;
   import alternativa.tanks.loader.IModalLoaderService;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.SoundResource;
   import projects.tanks.client.battleservice.Range;
   import projects.tanks.client.commons.models.layout.LayoutState;
   import projects.tanks.client.panel.model.battleinvite.BattleInviteMessage;
   import projects.tanks.client.panel.model.battleinvite.BattleInviteModelBase;
   import projects.tanks.client.panel.model.battleinvite.IBattleInviteModelBase;
   import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
   import projects.tanks.clients.flash.commons.services.notification.INotificationService;
   import projects.tanks.clients.flash.commons.services.notification.sound.INotificationSoundService;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.BattleLinkActivatorServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.BattleLinkAliveEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendStateChangeEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.BattleInviteServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoLabelUpdater;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;
   import services.alertservice.AlertAnswer;
   
   [ModelInfo]
   public class BattleInviteModel extends BattleInviteModelBase implements IBattleInviteModelBase, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject] // added
      public static var battleInviteService:IBattleInviteService;
      
      [Inject] // added
      public static var notificationService:INotificationService;
      
      [Inject] // added
      public static var battleInfoService:IBattleInfoService;
      
      [Inject] // added
      public static var battleLinkActivatorService:IBattleLinkActivatorService;
      
      [Inject] // added
      public static var alertService:IAlertService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject] // added
      public static var userInfoService:IUserInfoService;
      
      [Inject] // added
      public static var blurService:IBlurService;
      
      [Inject] // added
      public static var friendInfoService:IFriendInfoService;
      
      [Inject] // added
      public static var notificationSoundService:INotificationSoundService;
      
      [Inject] // added
      public static var serverNameService:ServerNumberToLocaleServerService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject] // added
      public static var reconnectService:ReconnectService;
      
      [Inject] // added
      public static var modalLoaderService:IModalLoaderService;
      
      private var inviteList:Dictionary;
      
      private var inviteUserId:String;
      
      private var userId:String;
      
      private var battleData:BattleInfoData;
      
      public function BattleInviteModel()
      {
         super();
      }
      
      private static function addNotificationAlreadyInvite(param1:String) : void
      {
         var _loc2_:String = localeService.getText(TanksLocale.TEXT_IS_CONSIDERING_YOUR_INVITE_LABEL);
         if(!notificationService.hasNotification(param1,_loc2_))
         {
            notificationService.addNotification(new ResponseBattleInviteNotification(param1,_loc2_));
         }
      }
      
      private static function createInviteBattleMessage(param1:BattleInviteMessage) : String
      {
         var _loc2_:String = localeService.getText(TanksLocale.TEXT_INVITES_YOU_TO_A_BATTLE_LABEL) + "\n";
         if(param1.availableRank)
         {
            if(param1.availableSlot)
            {
               _loc2_ += "\n" + localeService.getText(TanksLocale.TEXT_THERE_ARE_PLACES_AVAILABLE_LABEL);
            }
            else
            {
               _loc2_ += "\n" + setGreyColor(localeService.getText(TanksLocale.TEXT_NO_PLACES_AVAILABLE_LABEL));
            }
         }
         else
         {
            _loc2_ += "\n" + setGreyColor(localeService.getText(TanksLocale.TEXT_BATTLE_IS_UNAVAILABLE_AT_YOUR_RANK_LABEL));
         }
         return _loc2_;
      }
      
      private static function isAvailableRank(param1:Range) : Boolean
      {
         return param1.min <= userPropertiesService.rank && userPropertiesService.rank <= param1.max;
      }
      
      private static function createMapAndModeString(param1:BattleInfoData) : String
      {
         return BattleInfoUtils.buildBattleName(param1.mapName,param1.mode.name);
      }
      
      private static function setGreyColor(param1:String) : String
      {
         return "<font color=\'#" + "b1b1b1" + "\'>" + param1 + "</font>";
      }
      
      private static function addNotificationBattleNotFound(param1:String) : void
      {
         notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_BATTLE_CANNOT_BE_FOUND_LABEL)));
      }
      
      public function objectLoaded() : void
      {
         this.inviteList = new Dictionary();
         var _loc1_:SoundResource = getInitParam().soundNotification;
         if(_loc1_ != null && _loc1_.isLoaded)
         {
            notificationSoundService.notificationSound = getInitParam().soundNotification.sound;
         }
         battleInviteService.addEventListener(BattleInviteServiceEvent.INVITE,getFunctionWrapper(this.onBattleInvite));
         battleInviteService.addEventListener(BattleInviteServiceEvent.ACCEPT,getFunctionWrapper(this.onAccept));
         battleInviteService.addEventListener(BattleInviteServiceEvent.REJECT,getFunctionWrapper(this.onReject));
         battleLinkActivatorService.addEventListener(BattleLinkAliveEvent.ALIVE,getFunctionWrapper(this.onAlive));
         battleLinkActivatorService.addEventListener(BattleLinkAliveEvent.DEAD,getFunctionWrapper(this.onDead));
         friendInfoService.addEventListener(FriendStateChangeEvent.CHANGE,getFunctionWrapper(this.onChangeFriendState));
      }
      
      private function onBattleInvite(param1:BattleInviteServiceEvent) : void
      {
         var _loc2_:IUserInfoLabelUpdater = null;
         this.inviteUserId = param1.userId;
         if(this.inviteUserId in this.inviteList)
         {
            addNotificationAlreadyInvite(this.inviteUserId);
         }
         else if(battleInfoService.hasCurrentSelectionBattleId())
         {
            _loc2_ = userInfoService.getOrCreateUpdater(this.inviteUserId);
            if(battleInfoService.availableRank(_loc2_.rank))
            {
               this.sendInviteToServer();
            }
            else
            {
               alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_INVITE_TO_BATTLE_IS_UNAVAILABLE_RANK),Vector.<String>([localeService.getText(AlertAnswer.YES),localeService.getText(AlertAnswer.NO)]));
               alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,getFunctionWrapper(this.onBattleInviteAlertClick));
            }
         }
         else
         {
            addNotificationBattleNotFound(this.inviteUserId);
         }
      }
      
      private function sendInviteToServer() : void
      {
         this.inviteList[this.inviteUserId] = true;
         var _loc1_:String = this.getBattleId();
         server.invite(this.inviteUserId,_loc1_);
         this.inviteUserId = null;
      }
      
      private function getBattleId() : String
      {
         if(lobbyLayoutService.getCurrentState() == LayoutState.BATTLE)
         {
            return battleInfoService.currentBattleId;
         }
         return battleInfoService.currentSelectionBattleId;
      }
      
      private function onBattleInviteAlertClick(param1:AlertServiceEvent) : void
      {
         alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,getFunctionWrapper(this.onBattleInviteAlertClick));
         if(param1.typeButton == localeService.getText(AlertAnswer.YES))
         {
            this.sendInviteToServer();
         }
      }
      
      private function onAccept(param1:BattleInviteServiceEvent) : void
      {
         this.userId = param1.userId;
         this.battleData = param1.battleData;
         battleLinkActivatorService.isAlive(this.battleData.battleId);
      }
      
      private function onAlive(param1:BattleLinkAliveEvent) : void
      {
         if(this.battleData.battleId != param1.battleId)
         {
            return;
         }
         if(Boolean(lobbyLayoutService.inBattle()) && !battleInfoService.isSpectatorMode())
         {
            battleLinkActivatorService.addEventListener(BattleLinkActivatorServiceEvent.CONFIRMED_NAVIGATE,getFunctionWrapper(this.onConfirmedNavigate));
            battleLinkActivatorService.addEventListener(BattleLinkActivatorServiceEvent.NOT_CONFIRMED_NAVIGATE,getFunctionWrapper(this.onNotConfirmedNavigate));
         }
         else
         {
            server.accept(this.userId);
         }
         battleLinkActivatorService.navigateToBattleUrlWithoutAvailableBattle(this.battleData);
      }
      
      private function onConfirmedNavigate(param1:BattleLinkActivatorServiceEvent) : void
      {
         modalLoaderService.show();
         this.removeConfirmedNavigateEvent();
         server.accept(this.userId);
      }
      
      private function removeConfirmedNavigateEvent() : void
      {
         battleLinkActivatorService.removeEventListener(BattleLinkActivatorServiceEvent.CONFIRMED_NAVIGATE,getFunctionWrapper(this.onConfirmedNavigate));
         battleLinkActivatorService.removeEventListener(BattleLinkActivatorServiceEvent.NOT_CONFIRMED_NAVIGATE,getFunctionWrapper(this.onNotConfirmedNavigate));
      }
      
      private function onNotConfirmedNavigate(param1:BattleLinkActivatorServiceEvent) : void
      {
         this.removeConfirmedNavigateEvent();
         server.reject(this.userId);
      }
      
      private function onDead(param1:BattleLinkAliveEvent) : void
      {
         if(this.battleData.battleId != param1.battleId)
         {
            return;
         }
         alertService.showAlert(localeService.getText(TanksLocale.TEXT_BATTLE_CANNOT_BE_FOUND_ALERT),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
         server.reject(this.userId);
      }
      
      private function onReject(param1:BattleInviteServiceEvent) : void
      {
         server.reject(param1.userId);
      }
      
      public function objectUnloaded() : void
      {
         battleInviteService.removeEventListener(BattleInviteServiceEvent.INVITE,getFunctionWrapper(this.onBattleInvite));
         battleInviteService.removeEventListener(BattleInviteServiceEvent.ACCEPT,getFunctionWrapper(this.onAccept));
         battleInviteService.removeEventListener(BattleInviteServiceEvent.REJECT,getFunctionWrapper(this.onReject));
         battleLinkActivatorService.removeEventListener(BattleLinkAliveEvent.ALIVE,getFunctionWrapper(this.onAlive));
         battleLinkActivatorService.removeEventListener(BattleLinkAliveEvent.DEAD,getFunctionWrapper(this.onDead));
         friendInfoService.removeEventListener(FriendStateChangeEvent.CHANGE,getFunctionWrapper(this.onChangeFriendState));
      }
      
      public function notify(param1:String, param2:BattleInviteMessage) : void
      {
         var _loc3_:BattleInfoData = new BattleInfoData();
         _loc3_.battleId = param2.battleId;
         _loc3_.mapName = param2.mapName;
         _loc3_.mode = param2.mode;
         _loc3_.privateBattle = param2.privateBattle;
         //_loc3_.proBattle = param2.proBattle;
         //_loc3_.range = param2.range;
         _loc3_.remote = param2.remote;
         _loc3_.serverNumber = param2.serverNumber;
         notificationService.addNotification(new BattleInviteNotification(param1,createInviteBattleMessage(param2),param2.mapName, _loc3_));
      }
      
      private function onChangeFriendState(param1:FriendStateChangeEvent) : void
      {
         var _loc2_:Boolean = param1.prevState == FriendState.ACCEPTED && param1.state != FriendState.ACCEPTED;
         if(_loc2_)
         {
            if(param1.userId in this.inviteList)
            {
               this.rejected(param1.userId);
            }
         }
      }
      
      public function accepted(param1:String) : void
      {
         this.removeInvite(param1);
         notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_IS_JOINING_THE_BATTLE_AT_YOUR_INVITATION_LABEL)));
      }
      
      private function removeInvite(param1:String) : void
      {
         delete this.inviteList[param1];
         battleInviteService.removeInvite(param1);
      }
      
      public function rejected(param1:String) : void
      {
         this.removeInvite(param1);
         notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_REFUSED_TO_JOIN_THE_BATTLE_AT_YOUR_INVITATION_LABEL)));
      }
      
      public function rejectedBattleNotFound(param1:String) : void
      {
         this.removeInvite(param1);
         addNotificationBattleNotFound(param1);
      }
      
      public function rejectedInvitationToBattleDisabled(param1:String) : void
      {
         this.removeInvite(param1);
         notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_YOUR_FRIEND_DISABLED_INVITES_LABEL)));
      }
      
      public function rejectedPanelNotLoaded(param1:String) : void
      {
         this.removeInvite(param1);
         notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_YOUR_FRIEND_IS_ENTERING_THE_GAME_LABEL)));
      }
      
      public function rejectedUserAlreadyInBattle(param1:String) : void
      {
         this.removeInvite(param1);
         notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_YOUR_FRIEND_IS_ALREADY_IN_THIS_BATTLE_LABEL)));
      }
      
      public function rejectedUserInMatchBattle(param1:String) : void
      {
         this.removeInvite(param1);
         notificationService.addNotification(new ResponseBattleInviteNotification(param1,"Пользователь в матчмейкинге"));
      }
      
      public function rejectedUserOffline(param1:String) : void
      {
         this.removeInvite(param1);
         notificationService.addNotification(new ResponseBattleInviteNotification(param1,localeService.getText(TanksLocale.TEXT_YOUR_FRIEND_IS_OFFLINE_LABEL)));
      }
   }
}

