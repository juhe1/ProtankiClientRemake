package alternativa.tanks.service.battlelinkactivator
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.types.Long;
   import flash.events.EventDispatcher;
   import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.BattleLinkActivatorServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.BattleLinkAliveEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import services.alertservice.AlertAnswer;
   
   public class BattleLinkActivatorService extends EventDispatcher implements IBattleLinkActivatorService
   {
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      [Inject] // added
      public static var battleInfoService:IBattleInfoService;
      
      [Inject] // added
      public static var userPropertyService:IUserPropertiesService;
      
      [Inject] // added
      public static var userInfoService:IUserInfoService;
      
      [Inject] // added
      public static var alertService:IAlertService;
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private var battleData:BattleInfoData;
      
      public function BattleLinkActivatorService()
      {
         super();
      }
      
      private static function rememberShowAlertDeadBattle() : void
      {
         var _loc1_:String = userPropertyService.userName;
         storageService.getStorage().data.showAlertDeadBattle = _loc1_ + "_true";
      }
      
      public function navigateToBattleUrlWithoutAvailableBattle(param1:BattleInfoData) : void
      {
         this.navigateToBattleUrl(param1);
      }
      
      public function navigateToBattleUrl(param1:BattleInfoData) : void
      {
         this.battleData = param1;
         if(Boolean(userInfoService.isOffer()) || Boolean(lobbyLayoutService.inBattle()))
         {
            this.showChangingStateAlert();
         }
         else
         {
            this.navigate(param1);
         }
      }
      
      private function showChangingStateAlert() : void
      {
         var _loc1_:String = this.getTextForExitFromBattleAlert();
         alertService.showAlert(_loc1_,Vector.<String>([AlertAnswer.YES,AlertAnswer.CANCEL]));
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
         alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onQuitBattleDialogButtonPressed);
         if(param1.typeButton == AlertAnswer.YES)
         {
            this.navigate(this.battleData);
         }
         else
         {
            dispatchEvent(new BattleLinkActivatorServiceEvent(BattleLinkActivatorServiceEvent.NOT_CONFIRMED_NAVIGATE));
         }
      }
      
      public function navigate(param1:BattleInfoData) : void
      {
         dispatchEvent(new BattleLinkActivatorServiceEvent(BattleLinkActivatorServiceEvent.CONFIRMED_NAVIGATE));
         this.activateBattle(param1);
      }
      
      public function activateBattle(param1:BattleInfoData) : void
      {
         var _loc2_:int = 1;
         var _loc3_:int = 30;
         if(param1.range != null)
         {
            _loc2_ = param1.range.min;
            _loc3_ = param1.range.max;
         }
         battleInfoService.setCurrentSelectionBattleAndNotify(param1.battleId,_loc2_,_loc3_);
         this.activateBattleById(param1.battleId);
      }
      
      public function activateBattleById(param1:String) : void
      {
         rememberShowAlertDeadBattle();
         var _loc2_:BattleLinkActivatorServiceEvent = new BattleLinkActivatorServiceEvent(BattleLinkActivatorServiceEvent.ACTIVATE_LINK,param1);
         dispatchEvent(_loc2_);
      }
      
      public function isAlive(param1:String) : void
      {
         dispatchEvent(new BattleLinkAliveEvent(BattleLinkAliveEvent.IS_ALIVE,param1));
      }
      
      public function alive(param1:String) : void
      {
         dispatchEvent(new BattleLinkAliveEvent(BattleLinkAliveEvent.ALIVE,param1));
      }
      
      public function dead(param1:String) : void
      {
         dispatchEvent(new BattleLinkAliveEvent(BattleLinkAliveEvent.DEAD,param1));
      }
   }
}

