package projects.tanks.clients.flash.commons.models.layout
{
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.commons.models.layout.ILobbyLayoutModelBase;
   import projects.tanks.client.commons.models.layout.LayoutState;
   import projects.tanks.client.commons.models.layout.LobbyLayoutModelBase;
   import projects.tanks.clients.flash.commons.services.layout.LobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   
   [ModelInfo]
   public class LobbyLayoutModel extends LobbyLayoutModelBase implements ILobbyLayoutModelBase, ILobbyLayout, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      [Inject] // added
      public static var tanksAddressService:TanksAddressService;
      
      [Inject] // added
      public static var battleInfoSerivce:IBattleInfoService;
      
      public static const USE_BATTLE_LIST_KEY:String = "USE_BATTLE_LIST";
      
      public function LobbyLayoutModel()
      {
         super();
      }
      
      public function showGarage() : void
      {
         server.showGarage();
      }
      
      public function showBattleSelect() : void
      {
         storageService.getStorage().data[USE_BATTLE_LIST_KEY] = true;
         server.showBattleSelect();
      }
      
      public function showMatchmaking() : void
      {
         storageService.getStorage().data[USE_BATTLE_LIST_KEY] = false;
         server.showMatchmaking();
         battleInfoSerivce.forceResetCurrentSelectionBattleId();
         tanksAddressService.resetBattle();
      }
      
      public function showBattleLobby() : void
      {
         server.exitFromBattleToBattleLobby();
      }
      
      public function showClan() : void
      {
         server.showClan();
      }
      
      public function exitFromBattle() : void
      {
         server.exitFromBattleToBattleLobby();
         if(!storageService.getStorage().data[USE_BATTLE_LIST_KEY])
         {
            battleInfoSerivce.resetCurrentSelectionBattleId();
         }
      }
      
      public function exitFromBattleToState(param1:LayoutState) : void
      {
         server.exitFromBattle(param1);
         if(param1 != LayoutState.BATTLE_SELECT)
         {
            battleInfoSerivce.resetCurrentSelectionBattleId();
         }
      }
      
      public function returnToBattle() : void
      {
         server.returnToBattle();
      }
      
      public function objectLoaded() : void
      {
         this.setDefaultRightLayout();
         var _loc1_:LobbyLayoutService = LobbyLayoutService(lobbyLayoutService);
         if(_loc1_.getServiceGameObject() == null)
         {
            _loc1_.setServiceGameObject(object);
            return;
         }
         throw new Error("Service gameObject already has been loaded");
      }
      
      private function setDefaultRightLayout() : void
      {
         var _loc1_:Object = storageService.getStorage().data[USE_BATTLE_LIST_KEY];
         var _loc2_:Boolean = _loc1_ != null && Boolean(_loc1_) || Boolean(tanksAddressService.hasBattle());
         storageService.getStorage().data[USE_BATTLE_LIST_KEY] = _loc2_;
         server.setBattleLobbyLayout(_loc2_);
      }
      
      public function objectUnloaded() : void
      {
         var _loc1_:LobbyLayoutService = LobbyLayoutService(lobbyLayoutService);
         _loc1_.setServiceGameObject(null);
      }
   }
}

