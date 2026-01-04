package alternativa.tanks.controllers.battlelist
{
   import alternativa.tanks.controllers.BattleSelectVectorUtil;
   import alternativa.tanks.service.battlecreate.IBattleCreateFormService;
   import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
   import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
   import alternativa.tanks.view.battlelist.BattleListView;
   import alternativa.tanks.view.battlelist.IBattleListView;
   import alternativa.types.Long;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.address.events.BattleChangedAddressEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.address.events.TanksAddressEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.IUserProBattleService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.ProBattleEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesServiceEvent;
   
   public class BattleListController extends EventDispatcher implements IBattleListViewControllerCallback
   {
      
      [Inject] // added
      public static var battleInfoFormService:IBattleInfoFormService;
      
      [Inject] // added
      public static var addressService:TanksAddressService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject] // added
      public static var battleInfoService:IBattleInfoService;
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject] // added
      public static var serverNameService:ServerNumberToLocaleServerService;
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      [Inject] // added
      public static var battleSelectActionsService:UserBattleSelectActionsService;
      
      [Inject] // added
      public static var userProBattleService:IUserProBattleService;
      
      [Inject] // added
      public static var premiumService:PremiumService;
      
      [Inject] // added
      public static var battleCreateFormService:IBattleCreateFormService;
      
      private static var lastShownItemId:Long;
      
      private static const MODE_FILTER:String = "BATTLE_LIST_MODE_FILTER";
      
      private static const DEFAULT_MODE:BattleMode = BattleMode.TDM;
      
      private var filteredMode:BattleMode;
      
      private var _view:IBattleListView;
      
      private var _selectedItem:IGameObject;
      
      private var _allItems:Vector.<BattleListItemParams>;
      
      private var _itemsAwaitPacketJoinSuccess:Array;
      
      private var _isItemsPacketJoinSuccess:Boolean;
      
      public function BattleListController()
      {
         super();
         this._view = new BattleListView();
         this._allItems = new Vector.<BattleListItemParams>();
         this._itemsAwaitPacketJoinSuccess = new Array();
         this._view.setCallBack(this);
         this.setFilterBattleModeFormStorage();
      }
      
      private static function getModeFromStorage() : BattleMode
      {
         var _loc1_:* = storageService.getStorage().data[MODE_FILTER];
         return _loc1_ == null ? DEFAULT_MODE : BattleMode.values[_loc1_];
      }
      
      private static function storeMode(param1:BattleMode) : void
      {
         storageService.getStorage().data[MODE_FILTER] = param1.value;
      }
      
      private function setFilterBattleModeFormStorage() : void
      {
         this.filteredMode = getModeFromStorage();
         this._view.lockFilter(this.filteredMode);
      }
      
      public function destroy() : void
      {
         this.removeEvents();
         this._view.destroy();
         this._view = null;
         this._selectedItem = null;
         this._allItems = null;
         this._itemsAwaitPacketJoinSuccess = null;
         this._isItemsPacketJoinSuccess = false;
         lastShownItemId = null;
      }
      
      public function showForm() : void
      {
         this._view.show(this.filteredMode);
         this.setEvents();
      }
      
      private function setEvents() : void
      {
         addressService.addEventListener(TanksAddressEvent.BATTLE_CHANGED,this.onBattleChanged);
         userPropertiesService.addEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.onUpdateRank);
         userProBattleService.addEventListener(ProBattleEvent.OVER,this.onAbonementOver);
         premiumService.addEventListener(Event.CHANGE,this.onPremiumChange);
      }
      
      private function onPremiumChange(param1:Event) : void
      {
         this.updateCreateBattleButton();
      }
      
      private function onAbonementOver(param1:ProBattleEvent) : void
      {
         this.updateCreateBattleButton();
      }
      
      private function updateCreateBattleButton() : void
      {
         // Disabled to allow battle creation even if no premium or probattle

         //var _loc1_:Boolean = Boolean(premiumService.hasPremium()) || Boolean(userProBattleService.hasAbonement());
         //if(!_loc1_)
         //{
         //   battleCreateFormService.hideForm();
         //}
         //this._view.setBattleCreationEnabled(_loc1_);
      }
      
      private function onUpdateRank(param1:UserPropertiesServiceEvent) : void
      {
         this._view.updateAccessibleItems();
      }
      
      private function onBattleChanged(param1:BattleChangedAddressEvent) : void
      {
         if(!serverNameService.isLocalServer())
         {
            return;
         }
         var _loc2_:Long = param1.getBattleId();
         if(_loc2_ == null)
         {
            this.resetSelectedItem();
         }
         else
         {
            this.selectBattleItemById(_loc2_);
         }
      }
      
      private function selectBattleItemById(param1:Long) : void
      {
         var _loc2_:BattleListItemParams = this.findBattleListItem(param1);
         if(_loc2_ == null)
         {
            this.resetSelectedItem();
            dispatchEvent(new BattleByURLNotFoundEvent(BattleByURLNotFoundEvent.BATTLE_BY_URL_NOT_FOUND,param1));
         }
         else if(_loc2_.params.battle != this._selectedItem)
         {
            this.selectBattleItem(_loc2_.params.battle,true,true);
         }
      }
      
      private function findBattleListItem(param1:Long) : BattleListItemParams
      {
         var _loc2_:BattleListItemParams = null;
         var _loc3_:int = int(this._allItems.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._allItems[_loc4_].params.battle.id == param1)
            {
               _loc2_ = this._allItems[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function selectBattleItemFromServer(param1:IGameObject) : void
      {
         if(param1 == null)
         {
            this.resetSelectedItem();
         }
         else
         {
            this.selectBattleItem(param1,true,false);
         }
      }
      
      private function selectBattleItem(param1:IGameObject, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:BattleListItemParams = null;
         this._selectedItem = param1;
         if(param2)
         {
            if(this._view.getItemIndex(param1.id) < 0)
            {
               _loc4_ = BattleSelectVectorUtil.findElementInVector(this._allItems,param1.id);
               if(_loc4_ != null)
               {
                  this._view.createItem(_loc4_,true);
                  if(_loc4_ == battleInfoFormService.getSelectedBattle())
                  {
                     battleInfoFormService.showLastShowedForm();
                  }
               }
            }
            this._view.setSelect(this._selectedItem.id);
         }
         if(param3)
         {
            dispatchEvent(new BattleSelectedEvent(BattleSelectedEvent.BATTLE_SELECTED,this._selectedItem));
         }
         if(lastShownItemId == this._selectedItem.id)
         {
            battleInfoFormService.showLastShowedForm();
         }
         lastShownItemId = this._selectedItem.id;
      }
      
      public function onBattleListItemClick(param1:IGameObject) : void
      {
         this.selectBattleItem(param1,false,true);
      }
      
      public function resetBattleButtonState() : void
      {
         this._view.setBattleButtonEnabled(true);
      }
      
      public function onBattleListItemChange(param1:IGameObject) : void
      {
         if(this._selectedItem != null)
         {
            if(this._selectedItem != param1)
            {
               this.selectBattleItem(param1,false,true);
            }
         }
         else
         {
            this.selectBattleItem(param1,false,true);
         }
      }
      
      private function resetSelectedItem() : void
      {
         if(this._selectedItem != null)
         {
            this._selectedItem = null;
            this._view.resetSelectedItem();
         }
      }
      
      public function hideForm() : void
      {
         this.removeEvents();
         this._view.hide();
      }
      
      private function removeEvents() : void
      {
         addressService.removeEventListener(TanksAddressEvent.BATTLE_CHANGED,this.onBattleChanged);
         userPropertiesService.removeEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.onUpdateRank);
         userProBattleService.removeEventListener(ProBattleEvent.OVER,this.onAbonementOver);
         premiumService.removeEventListener(Event.CHANGE,this.onPremiumChange);
      }
      
      public function battleItemRecord(param1:BattleInfoBaseParams) : void
      {
         var _loc2_:BattleListItemParams = new BattleListItemParams(param1);
         if(this._isItemsPacketJoinSuccess)
         {
            this._allItems.push(_loc2_);
            if(this.isVisibleItem(_loc2_.createParams.battleMode))
            {
               this._view.createItem(_loc2_,true);
            }
         }
         else
         {
            this._itemsAwaitPacketJoinSuccess.push(_loc2_);
         }
      }
      
      private function isVisibleItem(param1:BattleMode) : Boolean
      {
         return param1 == this.filteredMode;
      }
      
      public function removeBattle(param1:Long) : void
      {
         this._view.removeItem(param1);
         BattleSelectVectorUtil.deleteElementInVector(this._allItems,param1);
         BattleSelectVectorUtil.deleteElementInArray(this._itemsAwaitPacketJoinSuccess,param1);
      }
      
      public function onShowCreateBattleFormButtonClick() : void
      {
         this.resetSelectedItem();
         dispatchEvent(new CreateBattleClickEvent());
      }
      
      public function updateSuspicious(param1:Long, param2:BattleSuspicionLevel) : void
      {
         this._view.updateSuspicious(param1,param2);
      }
      
      public function updateUsersCount(param1:Long) : void
      {
         this._view.updateUsersCount(param1);
      }
      
      public function updateBattleName(param1:Long) : void
      {
         this._view.updateBattleName(param1);
      }
      
      public function swapTeams(param1:Long) : void
      {
         this._view.swapTeams(param1);
      }
      
      public function battleItemsPacketJoinSuccess() : void
      {
         var _loc2_:BattleListItemParams = null;
         var _loc3_:int = 0;
         var _loc4_:BattleListItemParams = null;
         var _loc5_:BattleListItemParams = null;
         var _loc6_:Long = null;
         this._isItemsPacketJoinSuccess = true;
         var _loc1_:int = int(this._itemsAwaitPacketJoinSuccess.length);
         if(_loc1_ != 0)
         {
            this._itemsAwaitPacketJoinSuccess.sortOn(["currentBattle","suspicionLevel","accessible","friends","id"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING]);
            _loc2_ = this.getRecommendedFriendsBattle();
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc4_ = this._itemsAwaitPacketJoinSuccess[_loc3_];
               this._allItems.push(_loc4_);
               if(this.isVisibleItem(_loc4_.params.createParams.battleMode))
               {
                  this._view.createItem(_loc4_,false);
               }
               _loc3_++;
            }
            this._view.sortBattleList();
         }
         this._itemsAwaitPacketJoinSuccess.length = 0;
         this._view.resize();
         if(lastShownItemId != null)
         {
            _loc5_ = this.findBattleListItem(lastShownItemId);
            if(_loc5_ != null)
            {
               _loc2_ = BattleSelectVectorUtil.findElementInVector(this._allItems,_loc5_.id);
            }
         }
         if(Boolean(addressService.hasBattle()) && this._selectedItem == null)
         {
            _loc6_ = addressService.getBattleId();
            this.selectBattleItemById(_loc6_);
         }
         else if(_loc2_ != null)
         {
            this.selectBattleItem(_loc2_.params.battle,true,true);
         }
      }
      
      private function getRecommendedFriendsBattle() : BattleListItemParams
      {
         var _loc5_:BattleListItemParams = null;
         var _loc1_:BattleListItemParams = this._itemsAwaitPacketJoinSuccess[0];
         var _loc2_:int = this.getFreePlaces(_loc1_);
         var _loc3_:uint = this._itemsAwaitPacketJoinSuccess.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this._itemsAwaitPacketJoinSuccess[_loc4_];
            if(_loc5_.params.friends > _loc1_.params.friends && this.getFreePlaces(_loc5_) > _loc2_)
            {
               _loc1_ = _loc5_;
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function getFreePlaces(param1:BattleListItemParams) : int
      {
         var _loc2_:int = param1.params.createParams.maxPeopleCount;
         if(param1.isDM)
         {
            return _loc2_ - param1.dmParams.users.length;
         }
         return _loc2_ * 2 - param1.teamParams.usersBlue.length - param1.teamParams.usersRed.length;
      }
      
      public function onBattleModeChange(param1:BattleMode, param2:Boolean) : void
      {
         if(this.filteredMode != param1)
         {
            this.hideBattleByType(this.filteredMode);
            battleSelectActionsService.turnOffBattleMode(this.filteredMode);
            this.showBattleByType(param1);
            battleSelectActionsService.turnOnBattleMode(param1);
            this._view.unPressFilter(this.filteredMode);
            this._view.unLockFilter(this.filteredMode);
            this.filteredMode = param1;
            storeMode(this.filteredMode);
            this._view.lockFilter(this.filteredMode);
         }
      }
      
      private function showBattleByType(param1:BattleMode) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = int(this._allItems.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._allItems[_loc4_].params.createParams.battleMode == param1)
            {
               this._view.createItem(this._allItems[_loc4_],false);
               _loc2_++;
            }
            _loc4_++;
         }
         if(_loc2_ != 0)
         {
            this._view.sortBattleList();
            if(this._selectedItem != null)
            {
               this.selectBattleItem(this._selectedItem,true,false);
            }
            this._view.resize();
         }
      }
      
      private function hideBattleByType(param1:BattleMode) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = int(this._allItems.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._allItems[_loc4_].params.createParams.battleMode == param1)
            {
               this._view.removeItem(this._allItems[_loc4_].id);
               _loc2_++;
            }
            _loc4_++;
         }
         if(_loc2_ != 0)
         {
            this._view.resize();
         }
         if(this._selectedItem != null)
         {
            if(this._view.getItemIndex(this._selectedItem.id) == -1)
            {
               this.resetSelectedItem();
            }
         }
      }
      
      public function onBackToMatchmakingClick() : void
      {
         lobbyLayoutService.showMatchmaking();
      }
   }
}

