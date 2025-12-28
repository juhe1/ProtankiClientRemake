package alternativa.tanks.model.panel
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.startup.StartupSettings;
   import alternativa.tanks.gui.panel.MainPanel;
   import alternativa.tanks.help.ButtonBarHelper;
   import alternativa.tanks.help.FriendsHelper;
   import alternativa.tanks.help.MainMenuHelper;
   import alternativa.tanks.help.MoneyHelper;
   import alternativa.tanks.help.RankBarHelper;
   import alternativa.tanks.help.RankHelper;
   import alternativa.tanks.help.ScoreHelper;
   import alternativa.tanks.service.achievement.IAchievementService;
   import alternativa.tanks.service.fps.FPSService;
   import alternativa.tanks.service.fps.FPSServiceImpl;
   import alternativa.tanks.service.panel.IPanelView;
   import alternativa.tanks.service.payment.IPaymentService;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import alternativa.tanks.tracker.ITrackerService;
   import flash.display.InteractiveObject;
   import flash.events.FullScreenEvent;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   import forms.events.MainButtonBarEvents;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
   import projects.tanks.client.commons.models.layout.LayoutState;
   import projects.tanks.client.panel.model.panel.IPanelModelBase;
   import projects.tanks.client.panel.model.panel.PanelModelBase;
   import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
   import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.BattleInfoServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenStateService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.KeyUpListenerPriority;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
   
   [ModelInfo]
   public class PanelModel extends PanelModelBase implements IPanelModelBase, ObjectLoadListener, ObjectLoadPostListener, ObjectUnloadListener
   {
      
      [Inject] // added
      public static var panelView:IPanelView;
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var helpService:IHelpService;
      
      [Inject] // added
      public static var trackerService:ITrackerService;
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject] // added
      public static var achievementService:IAchievementService;
      
      [Inject] // added
      public static var partnerService:IPartnerService;
      
      [Inject] // added
      public static var battleInfoService:IBattleInfoService;
      
      [Inject] // added
      public static var paymentService:IPaymentService;
      
      [Inject] // added
      public static var alertService:IAlertService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var fullscreenService:FullscreenService;
      
      [Inject] // added
      public static var fullscreenStateService:FullscreenStateService;
      
      [Inject] // added
      public static var userInfoService:IUserInfoService;
      
      [Inject] // added
      public static var paymentDisplayService:PaymentDisplayService;
      
      [Inject] // added
      public static var userChangeGameScreenService:UserChangeGameScreenService;
      
      [Inject] // added
      public static var keysBindingService:KeysBindingService;
      
      [Inject] // added
      public static var dialogWindowsDispatcherService:IDialogWindowsDispatcherService;
      
      //[Inject]
      //public static var clanPanelNotificationService:ClanPanelNotificationService;
      //
      //[Inject]
      //public static var clanUserInfoService:ClanUserInfoService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      private static const HELPER_GROUP_KEY:String = "PanelModel";
      
      private static const HELPER_CHANGE_SERVER:int = 11;
      
      private static const GA_CATEGORY:String = "lobby";
      
      private static const HELPER_RANK:int = 1;
      
      private static const HELPER_RANK_BAR:int = 2;
      
      private static const HELPER_MAIN_MENU:int = 5;
      
      private static const HELPER_BUTTON_BAR:int = 6;
      
      private static const HELPER_MONEY:int = 7;
      
      private static const HELPER_FRIENDS:int = 11;
      
      private static const HELPER_SCORE:int = 10;
      
      private static const HELPER_RATING:int = 100;
      
      private static const SMALL_BUTTON_WIDTH:int = 26;
      
      private static const SMALL_BUTTONS_COUNT:int = 4;
      
      private static const BUTTON_BAR_HELPER_B_COEFF:int = 43;
      
      private static const BUTTON_BAR_OFFSET:int = 4;
      
      private static const FRIENDS_BUTTON_OFFSET:int = 6;
      
      private static const DAILY_QUEST_BUTTON_WIDTH:int = 36;
      
      private static const MONEY_HELPER_OFFSET:int = 225;
      
      private static const MAIN_MENU_HELPER_OFFSET:int = 320;
      
      private static const RATING_HELPER_OFFSET:int = 30;
      
      private static const RANK_BAR_WIDTH:int = 631;
      
      private var panel:MainPanel;
      
      private var destinationsState:String;
      
      public function PanelModel()
      {
         super();
      }
      
      private static function removeGarageAchievement() : void
      {
         if(!lobbyLayoutService.inBattle())
         {
            achievementService.removeGarageButtonAchievement();
         }
      }
      
      private static function closeButtonPressed() : void
      {
         if(lobbyLayoutService.inBattle())
         {
            if(lobbyLayoutService.getCurrentState() == LayoutState.BATTLE)
            {
               lobbyLayoutService.exitFromBattle();
            }
            else
            {
               lobbyLayoutService.returnToBattle();
            }
         }
         else
         {
            lobbyLayoutService.exitFromGame();
         }
      }
      
      private static function showHelpers() : void
      {
         helpService.showHelp();
         panelView.unlock();
      }
      
      private static function onKeyUp(param1:KeyboardEvent) : void
      {
         if(AlertUtils.isCancelKey(param1.keyCode) && !lobbyLayoutService.isSwitchInProgress())
         {
            param1.stopImmediatePropagation();
            closeButtonPressed();
         }
         if(isFullscreenHotKey(param1.keyCode))
         {
            fullscreenService.switchFullscreen();
         }
      }
      
      private static function isFullscreenHotKey(param1:uint) : Boolean
      {
         var _loc3_:InteractiveObject = null;
         var _loc2_:GameActionEnum = keysBindingService.getBindingAction(param1);
         if(param1 == Keyboard.F11)
         {
            return true;
         }
         if(_loc2_ == GameActionEnum.FULL_SCREEN)
         {
            _loc3_ = display.stage.focus;
            if(_loc3_ is TextField)
            {
               return TextField(_loc3_).type != TextFieldType.INPUT;
            }
            return true;
         }
         return false;
      }
      
      public function objectLoaded() : void
      {
         panelView.setPanel();
         this.panel = panelView.getPanel();
         display.systemUILayer.addChild(this.panel);
         this.addListeners();
         if(this.shouldHideButton())
         {
            this.panel.buttonBar.closeButton.hide();
         }
         if(fullscreenService.isAvailable())
         {
            this.panel.buttonBar.fullScreenButton.isActivateFullscreen = !fullscreenStateService.isFullscreen();
         }
         else
         {
            this.panel.buttonBar.fullScreenButton.hide();
            this.panel.buttonBar.draw();
         }
         this.updateNavigationLock(null);
         trackerService.trackPageView(GA_CATEGORY);
         trackerService.trackEventAfter(GA_CATEGORY,"lobbyLoaded","initTracker");
         FPSServiceImpl(OSGi.getInstance().getService(FPSService)).start();
      }
      
      public function objectLoadedPost() : void
      {
         achievementService.setGarageBuyButtonTargetPoint(new Point(0,0));
         this.initHelpers();
      }
      
      private function initHelpers() : void
      {
         var _loc1_:int = this.getClanButtonWidth();
         var _loc2_:RankBarHelper = new RankBarHelper(0.5,RANK_BAR_WIDTH,60);

         //var _loc3_:int = userPropertiesService.isQuestsAvailableByRank() ? DAILY_QUEST_BUTTON_WIDTH : 0;
         var _loc3_:int = DAILY_QUEST_BUTTON_WIDTH; // Original line commented out

         var _loc4_:MainMenuHelper = new MainMenuHelper(1,RANK_BAR_WIDTH,MAIN_MENU_HELPER_OFFSET);
         var _loc5_:MoneyHelper = new MoneyHelper(1,RANK_BAR_WIDTH + _loc3_ + _loc1_,MONEY_HELPER_OFFSET);
         var _loc6_:ScoreHelper = new ScoreHelper();
         var _loc7_:RankHelper = new RankHelper();
         var _loc8_:int = SMALL_BUTTON_WIDTH * SMALL_BUTTONS_COUNT + (SMALL_BUTTON_WIDTH >> 2) + BUTTON_BAR_OFFSET + FRIENDS_BUTTON_OFFSET;
         var _loc9_:FriendsHelper = new FriendsHelper(1,BUTTON_BAR_HELPER_B_COEFF,-_loc8_);
         var _loc10_:ButtonBarHelper = new ButtonBarHelper(1,BUTTON_BAR_HELPER_B_COEFF,-BUTTON_BAR_OFFSET,partnerService.isRunningInsidePartnerEnvironment(),fullscreenService.isAvailable());
         helpService.registerHelper(HELPER_GROUP_KEY,HELPER_RANK,_loc7_,true);
         helpService.registerHelper(HELPER_GROUP_KEY,HELPER_RANK_BAR,_loc2_,true);
         helpService.registerHelper(HELPER_GROUP_KEY,HELPER_SCORE,_loc6_,true);
         helpService.registerHelper(HELPER_GROUP_KEY,HELPER_MAIN_MENU,_loc4_,true);
         helpService.registerHelper(HELPER_GROUP_KEY,HELPER_BUTTON_BAR,_loc10_,true);
         if(paymentService.isEnabled())
         {
            helpService.registerHelper(HELPER_GROUP_KEY,HELPER_MONEY,_loc5_,true);
         }
         helpService.registerHelper(HELPER_GROUP_KEY,HELPER_FRIENDS,_loc9_,true);
      }
      
      private function getClanButtonWidth() : int
      {
         return this.panel.buttonBar.clanButton.visible ? int(this.panel.buttonBar.clanButton.width) : 0;
      }
      
      public function objectUnloaded() : void
      {
         this.panel.destroy();
         this.panel.buttonBar.removeEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,getFunctionWrapper(this.onButtonBarButtonClick));
         lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.updateNavigationLock);
         lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.updateNavigationLock);
         battleInfoService.removeEventListener(BattleInfoServiceEvent.BATTLE_UNLOAD,this.onBattleUnload);
         battleInfoService.removeEventListener(BattleInfoServiceEvent.BATTLE_LOAD,this.onBattleLoad);
         display.stage.removeEventListener(KeyboardEvent.KEY_UP,getFunctionWrapper(onKeyUp));
         if(fullscreenService.isAvailable())
         {
            display.stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.onFullscreen);
            display.stage.removeEventListener(FullScreenEvent.FULL_SCREEN_INTERACTIVE_ACCEPTED,this.onFullscreen);
         }
         achievementService.hideAllBubbles(false);
         this.hidePanel();
      }
      
      private function hidePanel() : void
      {
         this.panel.hide();
         removeDisplayObject(this.panel);
      }
      
      private function addListeners() : void
      {
         //this.panel.buttonBar.addEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,getFunctionWrapper(this.onButtonBarButtonClick));
         // Original line commented out
         this.panel.buttonBar.addEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,this.onButtonBarButtonClick);
         
         lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.updateNavigationLock);
         lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.updateNavigationLock);
         battleInfoService.addEventListener(BattleInfoServiceEvent.BATTLE_UNLOAD,this.onBattleUnload);
         battleInfoService.addEventListener(BattleInfoServiceEvent.BATTLE_LOAD,this.onBattleLoad);
         //display.stage.addEventListener(KeyboardEvent.KEY_UP,getFunctionWrapper(onKeyUp),false,KeyUpListenerPriority.PANEL);
         // Original line commented out
         display.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp,false,KeyUpListenerPriority.PANEL);

         if(fullscreenService.isAvailable())
         {
            display.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullscreen);
            display.stage.addEventListener(FullScreenEvent.FULL_SCREEN_INTERACTIVE_ACCEPTED,this.onFullscreen);
         }
      }
      
      private function onButtonBarButtonClick(param1:MainButtonBarEvents) : void
      {
         achievementService.hideAllBubbles(false);
         trackerService.trackEvent(GA_CATEGORY,"panel",param1.typeButton);
         this.destinationsState = param1.typeButton;
         if(Boolean(lobbyLayoutService.inBattle()) && this.buttonChangeLayout(param1.typeButton) && !battleInfoService.isSpectatorMode() && !(Boolean(lobbyLayoutService.inBattle()) && Boolean(dialogWindowsDispatcherService.isOpen())))
         {
            this.showExitFromBattleAlert();
         }
         else
         {
            this.changeState();
         }
      }
      
      private function buttonChangeLayout(param1:String) : Boolean
      {
         //if(Boolean(clanUserInfoService.clanMember) && param1 == MainButtonBarEvents.CLAN)
         //{
         //   return true;
         //}
         return [MainButtonBarEvents.BATTLE].indexOf(param1) >= 0;
      }
      
      private function showExitFromBattleAlert() : void
      {
         var _loc1_:String = this.getTextForExitFromBattleAlert();
         alertService.showAlert(_loc1_,Vector.<String>([localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES),localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_NO)]));
         alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onQuitBattleDialogButtonPressed);
      }
      
      private function getTextForExitFromBattleAlert() : String
      {
         if(!userInfoService.isOffer())
         {
            return localeService.getText(TanksLocale.TEXT_FRIENDS_EXIT_FROM_BATTLE_ALERT);
         }
         return localeService.getText(TanksLocale.TEXT_FRIENDS_EXIT_FROM_BATTLE_ALERT) + "\n" + localeService.getText(TanksLocale.TEXT_POSTFIX_OFFER_EXIT_BATTLE);
      }
      
      private function onQuitBattleDialogButtonPressed(param1:AlertServiceEvent) : void
      {
         var _loc2_:LayoutState = null;
         alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onQuitBattleDialogButtonPressed);
         if(param1.typeButton == localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES))
         {
            _loc2_ = this.getStateByDestination();
            //if(_loc2_ == LayoutState.MATCHMAKING)
            //{
            //   lobbyLayoutService.exitFromBattleWithoutNotify();
            //}
            //else
            //{
            //   lobbyLayoutService.exitFromBattleToState(_loc2_);
            //}

            // Commented out original code above
            // Added new code below
            lobbyLayoutService.exitFromBattleToState(_loc2_);
         }
      }
      
      private function getStateByDestination() : LayoutState
      {
         switch(this.destinationsState)
         {
            case MainButtonBarEvents.GARAGE:
               return LayoutState.GARAGE;
            //case MainButtonBarEvents.CLAN:
            //   return LayoutState.CLAN;
            default:
               return LayoutState.BATTLE_SELECT;
         }
      }
      
      private function changeState() : void
      {
         switch(this.destinationsState)
         {
            case MainButtonBarEvents.BATTLE:
               this.lockMainPanel();
               lobbyLayoutService.showBattleLobby();
               this.panel.buttonBar.battlesButton.enable = true;
               break;
            case MainButtonBarEvents.GARAGE:
               this.lockMainPanel();
               if(Boolean(lobbyLayoutService.inBattle()) && lobbyLayoutService.getCurrentState() == LayoutState.GARAGE)
               {
                  lobbyLayoutService.returnToBattle();
               }
               else if(Boolean(lobbyLayoutService.inBattle()) && Boolean(battleInfoService.enterGarageCausesExitBattle))
               {
                  lobbyLayoutService.exitFromBattleToGarageThroughAlert();
               }
               else
               {
                  lobbyLayoutService.showGarage();
               }
               removeGarageAchievement();
               break;
            //case MainButtonBarEvents.CLAN:
            //   if(clanUserInfoService.clanMember)
            //   {
            //      this.lockMainPanel();
            //      lobbyLayoutService.showClan();
            //   }
            //   break;
            case MainButtonBarEvents.SHOP:
               paymentDisplayService.openPayment();
               break;
            case MainButtonBarEvents.HELP:
               showHelpers();
               break;
            case MainButtonBarEvents.CLOSE:
               closeButtonPressed();
               break;
            case MainButtonBarEvents.FULL_SCREEN:
               fullscreenService.switchFullscreen();
         }
      }
      
      private function onFullscreen(param1:FullScreenEvent) : void
      {
         this.panel.buttonBar.fullScreenButton.isActivateFullscreen = !param1.fullScreen;
      }
      
      private function updateNavigationLock(param1:LobbyLayoutServiceEvent) : void
      {
         if(lobbyLayoutService.isSwitchInProgress())
         {
            this.lockMainPanel();
         }
         else
         {
            this.unlockMainPanel();
         }
         this.setButtonState(lobbyLayoutService.getCurrentState());
      }
      
      private function onBattleLoad(param1:BattleInfoServiceEvent) : void
      {
         lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitchInBattle);
         if(partnerService.isRunningInsidePartnerEnvironment())
         {
            this.panel.buttonBar.closeButton.show();
         }
      }
      
      private function onBattleUnload(param1:BattleInfoServiceEvent) : void
      {
         lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitchInBattle);
         if(this.shouldHideButton())
         {
            this.panel.buttonBar.closeButton.hide();
         }
         this.panel.buttonBar.closeButton.changeOnCloseButton();
      }
      
      private function onEndLayoutSwitchInBattle(param1:LobbyLayoutServiceEvent) : void
      {
         if(param1.state == LayoutState.BATTLE)
         {
            this.panel.buttonBar.closeButton.changeOnCloseButton();
         }
         else
         {
            this.panel.buttonBar.closeButton.changeOnBackButton();
         }
      }
      
      private function lockMainPanel() : void
      {
         this.panel.mouseEnabled = false;
         this.panel.mouseChildren = false;
      }
      
      private function unlockMainPanel() : void
      {
         this.panel.mouseEnabled = true;
         this.panel.mouseChildren = true;
      }
      
      private function setButtonState(param1:LayoutState, param2:Boolean = true) : void
      {
         if(param2)
         {
            this.panel.buttonBar.battlesButton.selected = false;
            this.panel.buttonBar.garageButton.selected = false;
         }
         switch(param1)
         {
            case LayoutState.BATTLE:
               this.panel.buttonBar.battlesButton.enable = true;
               this.panel.buttonBar.garageButton.enable = true;
               break;
            case LayoutState.BATTLE_SELECT:
            //case LayoutState.MATCHMAKING:
               this.panel.buttonBar.battlesButton.enable = false;
               this.panel.buttonBar.garageButton.enable = true;
               this.panel.buttonBar.clanButton.enable = true;
               break;
            case LayoutState.GARAGE:
               this.panel.buttonBar.garageButton.enable = false;
               this.panel.buttonBar.battlesButton.enable = true;
               this.panel.buttonBar.clanButton.enable = true;
               break;
            //case LayoutState.CLAN:
            //   this.panel.buttonBar.clanButton.enable = false;
            //   this.panel.buttonBar.battlesButton.enable = true;
            //   this.panel.buttonBar.garageButton.enable = true;
         }
      }
      
      private function shouldHideButton() : Boolean
      {
         return Boolean(partnerService.isRunningInsidePartnerEnvironment()) && !StartupSettings.isDesktop;
      }
   }
}

