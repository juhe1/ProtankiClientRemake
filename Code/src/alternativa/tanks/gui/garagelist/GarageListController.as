package alternativa.tanks.gui.garagelist
{
   import alternativa.tanks.gui.TimerKitCouldBeBoughtContext;
   import alternativa.tanks.gui.category.CategoryButtonsList;
   import alternativa.tanks.gui.category.CategoryButtonsListEvent;
   import alternativa.tanks.model.item.itemforpartners.ItemEnabledForPartner;
   import alternativa.tanks.model.item.kit.GarageKit;
   import alternativa.tanks.model.item.present.UserPresent;
   import alternativa.tanks.service.garage.GarageService;
   import alternativa.tanks.service.item.ItemService;
   import alternativa.tanks.service.notificationcategories.INotificationGarageCategoriesService;
   import alternativa.tanks.service.notificationcategories.NotificationGarageCategoriesEvent;
   import alternativa.tanks.types.MultiGameObjectDictionary;
   import controls.timer.CountDownTimer;
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.commons.types.ItemViewCategoryEnum;
   import projects.tanks.client.garage.models.item.kit.KitItem;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
   
   public class GarageListController
   {
      
      [Inject] // added
      public static var itemService:ItemService;
      
      [Inject] // added
      public static var premiumService:PremiumService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      [Inject] // added
      public static var notificationGarageCategoriesService:INotificationGarageCategoriesService;
      
      [Inject] // added
      public static var garageService:GarageService;
      
      private static const DEFAULT_CATEGORY_TO_SHOW:ItemViewCategoryEnum = ItemViewCategoryEnum.WEAPON;
      
      private static const LAST_SHOWED_GARAGE_CATEGORY_SHARED_KEY:String = "LAST_SHOWED_GARAGE_CATEGORY";
      
      private static const UPDATE_VISIBILITY_DISCOUNT_INDICATORS_DELAY:int = 1000;
      
      private var _garageList:GarageList;
      
      private var _categoryButtons:CategoryButtonsList;
      
      private var _itemsInDepot:Vector.<IGameObject>;
      
      private var _itemsInStore:Vector.<IGameObject>;
      
      private var _itemsInStoreFromServer:Vector.<IGameObject>;
      
      private var _currentShowingCategory:ItemViewCategoryEnum;
      
      private var _kitsByItem:MultiGameObjectDictionary;
      
      private var _updateVisibilityDiscountIndicatorsTimeoutId:uint;
      
      public function GarageListController(param1:GarageList, param2:CategoryButtonsList)
      {
         super();
         this._garageList = param1;
         this._categoryButtons = param2;
         this.init();
      }
      
      private function init() : void
      {
         this._itemsInDepot = new Vector.<IGameObject>();
         this._itemsInStore = new Vector.<IGameObject>();
         userPropertiesService.addEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.onRankChange);
         notificationGarageCategoriesService.addEventListener(NotificationGarageCategoriesEvent.NOTIFICATION_CHANGE,this.onChangeNotificationGarageCategory);
         this._categoryButtons.addEventListener(CategoryButtonsListEvent.CATEGORY_SELECTED,this.onCategoryButtonsSelected);
         premiumService.addEventListener(Event.CHANGE,this.onSelfPremiumChanged);
         this.updateVisibilityNotificationIconOnCategories();
      }
      
      private function onRankChange(param1:UserPropertiesServiceEvent) : void
      {
         this.updateStore();
         this.showCategory(this._currentShowingCategory);
      }
      
      private function onCategoryButtonsSelected(param1:CategoryButtonsListEvent) : void
      {
         if(this._currentShowingCategory != param1.getCategory())
         {
            this.showCategory(param1.getCategory());
         }
      }
      
      private function onSelfPremiumChanged(param1:Event) : void
      {
         var _loc3_:IGameObject = null;
         var _loc2_:int = this._garageList.itemsCount() - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = this._garageList.getItemAt(_loc2_);
            if(Boolean(itemService.isPremiumItem(_loc3_)) && this.isItemInStore(_loc3_))
            {
               this._garageList.updateShowLockPremium(_loc3_,!premiumService.hasPremium());
            }
            _loc2_--;
         }
         this._garageList.sort();
         this.selectAndScrollToItemInCategory(this._garageList.selectedItem);
      }
      
      private function onChangeNotificationGarageCategory(param1:NotificationGarageCategoriesEvent) : void
      {
         this.updateVisibilityNotificationIconOnCategories();
      }
      
      private function updateVisibilityNotificationIconOnCategories() : void
      {
         var _loc4_:ItemViewCategoryEnum = null;
         var _loc1_:Vector.<ItemViewCategoryEnum> = ItemViewCategoryEnum.values;
         var _loc2_:int = int(_loc1_.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            if(notificationGarageCategoriesService.isNeedShowNewItemNotification(_loc4_))
            {
               if(this._currentShowingCategory == _loc4_)
               {
                  notificationGarageCategoriesService.categoryShowed(_loc4_);
               }
               else
               {
                  this._categoryButtons.hideDiscountIndicator(_loc4_);
                  this._categoryButtons.showNewItemIndicator(_loc4_);
               }
            }
            _loc3_++;
         }
      }
      
      public function initDepot(param1:Vector.<IGameObject>) : void
      {
         var _loc2_:IGameObject = null;
         for each(_loc2_ in param1)
         {
            itemService.addItem(_loc2_);
         }
         for each(_loc2_ in param1)
         {
            if(!this.needExcludeFromDepot(_loc2_))
            {
               this._itemsInDepot.push(_loc2_);
            }
         }
      }
      
      private function needExcludeFromDepot(param1:IGameObject) : Boolean
      {
         var _loc2_:ItemCategoryEnum = itemService.getCategory(param1);
         //if(_loc2_ == ItemCategoryEnum.INVENTORY || _loc2_ == ItemCategoryEnum.CONTAINER)
         //{
         //   return true;
         //}
         var _loc3_:ItemViewCategoryEnum = itemService.getViewCategory(param1);
         //if(_loc3_ == ItemViewCategoryEnum.INVISIBLE)
         //{
         //   return true;
         //}
         if(Boolean(itemService.isModificationItem(param1)) && param1 != itemService.getMaxUserModificationItem(param1))
         {
            return true;
         }
         return false;
      }
      
      public function initStore(param1:Vector.<IGameObject>) : void
      {
         this._itemsInStoreFromServer = param1;
         this.updateStore();
      }
      
      private function updateStore() : void
      {
         this._itemsInStore = new Vector.<IGameObject>();
         this.addBuyableItemToStore();
         this.excludeNotBuyableModificationItemFromStore();
         this.updateKitsFromStore();
      }
      
      private function updateKitsFromStore() : void
      {
         var _loc3_:IGameObject = null;
         var _loc4_:Vector.<KitItem> = null;
         var _loc5_:KitItem = null;
         this._kitsByItem = new MultiGameObjectDictionary();
         var _loc1_:int = int(this._itemsInStore.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._itemsInStore[_loc2_];
            if(itemService.isKit(_loc3_))
            {
               _loc4_ = GarageKit(_loc3_.adapt(GarageKit)).getItems();
               for each(_loc5_ in _loc4_)
               {
                  this._kitsByItem.put(_loc5_.item,_loc3_);
               }
            }
            _loc2_++;
         }
      }
      
      public function updateKitsContainsItem(param1:IGameObject) : void
      {
         var _loc4_:IGameObject = null;
         if(this._kitsByItem == null)
         {
            return;
         }
         var _loc2_:Vector.<IGameObject> = this._kitsByItem.getValues(param1);
         var _loc3_:int = _loc2_.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = _loc2_[_loc3_];
            if(!itemService.canBuy(_loc4_))
            {
               this.removeSingleItemFromStore(_loc4_);
            }
            else
            {
               this._garageList.updateCost(_loc4_,itemService.getPrice(_loc4_));
            }
            _loc3_--;
         }
      }
      
      private function addBuyableItemToStore() : void
      {
         var _loc3_:IGameObject = null;
         var _loc1_:int = int(this._itemsInStoreFromServer.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._itemsInStoreFromServer[_loc2_];
            if(Boolean(itemService.canBuy(_loc3_)) && this.availableInPartner(_loc3_))
            {
               this._itemsInStore.push(_loc3_);
            }
            _loc2_++;
         }
      }
      
      private function availableInPartner(param1:IGameObject) : Boolean
      {
         if(!param1.hasModel(ItemEnabledForPartner))
         {
            return true;
         }
         return ItemEnabledForPartner(param1.adapt(ItemEnabledForPartner)).isAvailable();
      }
      
      private function excludeNotBuyableModificationItemFromStore() : void
      {
         var _loc4_:IGameObject = null;
         var _loc5_:IGameObject = null;
         var _loc6_:IGameObject = null;
         var _loc1_:Vector.<IGameObject> = new Vector.<IGameObject>();
         var _loc2_:int = int(this._itemsInStore.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._itemsInStore[_loc3_];
            if(itemService.isModificationItem(_loc4_))
            {
               if(itemService.isPremiumItem(_loc4_))
               {
                  _loc1_.push(_loc4_);
               }
               else
               {
                  _loc5_ = itemService.getMaxUserModificationItem(_loc4_);
                  if(_loc5_ == null && itemService.getModificationIndex(_loc4_) == 0)
                  {
                     _loc6_ = itemService.getMaxAvailableModification(_loc4_);
                     if(_loc6_ == null)
                     {
                        _loc1_.push(_loc4_);
                     }
                     else
                     {
                        _loc1_.push(_loc6_);
                     }
                  }
               }
            }
            else
            {
               _loc1_.push(_loc4_);
            }
            _loc3_++;
         }
         this._itemsInStore = _loc1_;
      }
      
      public function showCategory(param1:ItemViewCategoryEnum, param2:IGameObject = null) : void
      {
         var _loc7_:ItemViewCategoryEnum = null;
         var _loc8_:IGameObject = null;
         var _loc9_:IGameObject = null;
         var _loc10_:int = 0;
         if(!this._categoryButtons.getCategoryButtonVisibility(param1))
         {
            _loc7_ = this._categoryButtons.findVisibleCategory();
            this.showCategory(_loc7_);
            return;
         }
         this._currentShowingCategory = param1;
         this._categoryButtons.select(param1);
         var _loc3_:Vector.<IGameObject> = this.getItemsByCategory(this._itemsInDepot,param1);
         var _loc4_:Vector.<IGameObject> = this.getItemsByCategory(this._itemsInStore,param1);
         this._garageList.clearList();
         var _loc5_:int = int(_loc3_.length);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            this._garageList.addItem(this.createData(_loc3_[_loc6_],true));
            _loc6_++;
         }
         _loc5_ = int(_loc4_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            this._garageList.addItem(this.createData(_loc4_[_loc6_],false));
            _loc6_++;
         }
         this._garageList.sort();
         storageService.getStorage().data[LAST_SHOWED_GARAGE_CATEGORY_SHARED_KEY] = param1.value;
         if(this._garageList.itemsCount() > 0)
         {
            _loc8_ = this._garageList.getItemAt(0);
            if(param2 == null)
            {
               _loc9_ = this.getMountedItemInCategory(_loc3_);
               if(_loc9_ == null)
               {
                  this.selectAndScrollToItemInCategory(_loc8_);
               }
               else
               {
                  this._garageList.scrollTo(_loc8_);
                  this._garageList.select(_loc9_);
               }
            }
            else
            {
               _loc10_ = this._garageList.indexById(param2);
               if(_loc10_ == -1)
               {
                  this.selectAndScrollToItemInCategory(_loc8_);
               }
               else
               {
                  this.selectAndScrollToItemInCategory(param2);
               }
            }
         }
         this.resetNotificationCategory(param1);
         this.updateVisibilityDiscountIndicators();
      }
      
      private function getMountedItemInCategory(param1:Vector.<IGameObject>) : IGameObject
      {
         var _loc2_:IGameObject = null;
         var _loc5_:IGameObject = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            if(itemService.isMounted(_loc5_))
            {
               _loc2_ = _loc5_;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function resetNotificationCategory(param1:ItemViewCategoryEnum) : void
      {
         this._categoryButtons.hideNewItemIndicator(param1);
         notificationGarageCategoriesService.categoryShowed(param1);
      }
      
      private function selectAndScrollToItemInCategory(param1:IGameObject) : void
      {
         this._garageList.unselect();
         this._garageList.select(param1);
         this._garageList.scrollTo(param1);
      }
      
      private function createData(param1:IGameObject, param2:Boolean) : GarageListRendererData
      {
         var _loc3_:GarageListRendererData = new GarageListRendererData();
         _loc3_.id = param1;
         _loc3_.name = itemService.getName(param1);
         _loc3_.type = itemService.getCategory(param1);
         _loc3_.mod = itemService.getModificationIndex(param1);
         _loc3_.crystalPrice = itemService.getPrice(param1);
         if(param2)
         {
            _loc3_.rank = -1;
            _loc3_.showLockPremium = false;
            _loc3_.discount = this.getDiscountForDepotItem(param1);
         }
         else
         {
            _loc3_.rank = this.determineShowingRankIndex(param1);
            _loc3_.showLockPremium = Boolean(itemService.isPremiumItem(param1)) && !premiumService.hasPremium();
            _loc3_.discount = itemService.getDiscount(param1);
         }
         _loc3_.installed = itemService.isMounted(param1);
         _loc3_.garageElement = param2;
         _loc3_.count = itemService.getCount(param1);
         _loc3_.preview = itemService.getPreviewResource(param1);
         _loc3_.sort = itemService.getPosition(param1);
         _loc3_.timerDiscount = this.getEndDiscountTimer(param1,param2);
         if(itemService.isGivenPresent(param1))
         {
            _loc3_.appearanceTime = UserPresent(param1.adapt(UserPresent)).getDate().time;
         }
         //else if(param1.hasModel(ILootBoxModelBase))
         //{
         //   _loc3_.appearanceTime = 1;
         //}
         else
         {
            _loc3_.appearanceTime = 0;
         }
         return _loc3_;
      }
      
      private function getDiscountForDepotItem(param1:IGameObject) : int
      {
         var _loc3_:IGameObject = null;
         var _loc2_:int = 0;
         if(itemService.isCountable(param1))
         {
            _loc2_ = int(itemService.getDiscount(param1));
         }
         else if(Boolean(itemService.isModificationItem(param1)) && Boolean(itemService.hasNextModification(param1)))
         {
            _loc3_ = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
            _loc2_ = int(itemService.getDiscount(_loc3_));
         }
         return _loc2_;
      }
      
      private function determineShowingRankIndex(param1:IGameObject) : int
      {
         var _loc2_:int = int(itemService.getMinRankIndex(param1));
         var _loc3_:int = int(itemService.getMaxRankIndex(param1));
         var _loc4_:int = int(userPropertiesService.rank);
         if(_loc4_ < _loc2_)
         {
            return _loc2_;
         }
         if(_loc4_ > _loc3_)
         {
            return _loc3_;
         }
         return 0;
      }
      
      private function getEndDiscountTimer(param1:IGameObject, param2:Boolean) : CountDownTimer
      {
         if(itemService.isKit(param1))
         {
            return this.getEndDiscountTimerForKit(param1);
         }
         var _loc3_:IGameObject = param1;
         if(Boolean(itemService.isModificationItem(param1)) && param2)
         {
            if(!itemService.hasNextModification(param1))
            {
               return null;
            }
            _loc3_ = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
         }
         return itemService.getEndDiscountTimer(_loc3_);
      }
      
      private function getEndDiscountTimerForKit(param1:IGameObject) : CountDownTimer
      {
         var _loc2_:CountDownTimer = null;
         var _loc6_:TimerKitCouldBeBoughtContext = null;
         var _loc3_:Vector.<TimerKitCouldBeBoughtContext> = garageService.getView().getTimersKitCouldBeBoughtContext();
         var _loc4_:int = int(_loc3_.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            if(_loc6_.item == param1)
            {
               _loc2_ = _loc6_.timer;
               break;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function getItemsByCategory(param1:Vector.<IGameObject>, param2:ItemViewCategoryEnum) : Vector.<IGameObject>
      {
         var _loc6_:IGameObject = null;
         var _loc3_:Vector.<IGameObject> = new Vector.<IGameObject>();
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1[_loc5_];
            if(itemService.getViewCategory(_loc6_) == param2)
            {
               _loc3_.push(_loc6_);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function destroy() : void
      {
         userPropertiesService.removeEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.onRankChange);
         notificationGarageCategoriesService.removeEventListener(NotificationGarageCategoriesEvent.NOTIFICATION_CHANGE,this.onChangeNotificationGarageCategory);
         this._categoryButtons.removeEventListener(CategoryButtonsListEvent.CATEGORY_SELECTED,this.onCategoryButtonsSelected);
         premiumService.removeEventListener(Event.CHANGE,this.onSelfPremiumChanged);
         clearTimeout(this._updateVisibilityDiscountIndicatorsTimeoutId);
         removeDisplayObject(this._garageList);
         removeDisplayObject(this._categoryButtons);
         this._garageList.destroy();
         this._categoryButtons.destroy();
         this._garageList = null;
         this._categoryButtons = null;
         this._itemsInDepot = null;
         this._itemsInStore = null;
      }
      
      public function isItemInDepot(param1:IGameObject) : Boolean
      {
         if(this._itemsInDepot == null)
         {
            return false;
         }
         return this._itemsInDepot.indexOf(param1) != -1;
      }
      
      public function isItemInStore(param1:IGameObject) : Boolean
      {
         if(this._itemsInStore == null)
         {
            return false;
         }
         return this._itemsInStore.indexOf(param1) != -1;
      }
      
      public function addItemToDepot(param1:IGameObject) : void
      {
         if(this.isItemInDepot(param1))
         {
            return;
         }
         itemService.addItem(param1);
         if(!this.needExcludeFromDepot(param1))
         {
            this._itemsInDepot.push(param1);
         }
         this.updateVisibilityDiscountIndicatorsWithDelay();
         if(this._currentShowingCategory == itemService.getViewCategory(param1))
         {
            this._garageList.addItem(this.createData(param1,true));
            this._garageList.sort();
            this.selectAndScrollToItemInCategory(param1);
         }
      }
      
      public function removeItemFromDepot(param1:IGameObject) : void
      {
         var _loc2_:int = int(this._itemsInDepot.indexOf(param1));
         if(_loc2_ != -1)
         {
            itemService.removeItem(param1);
            this._itemsInDepot.splice(_loc2_,1);
         }
         if(this._garageList.indexById(param1) != -1)
         {
            this._garageList.deleteItem(param1);
         }
         this.updateSelection();
      }
      
      public function addItemToStore(param1:IGameObject) : void
      {
         if(this.isItemInStore(param1) || !itemService.canBuy(param1))
         {
            return;
         }
         this._itemsInStore.push(param1);
         if(this._currentShowingCategory == itemService.getViewCategory(param1))
         {
            this._garageList.addItem(this.createData(param1,false));
            this._garageList.sort();
            this.selectAndScrollToItemInCategory(param1);
         }
      }
      
      public function removeSingleItemFromStore(param1:IGameObject) : void
      {
         var _loc3_:Vector.<KitItem> = null;
         var _loc4_:KitItem = null;
         var _loc2_:int = int(this._itemsInStore.indexOf(param1));
         if(_loc2_ != -1)
         {
            this._itemsInStore.splice(_loc2_,1);
         }
         if(this._garageList.indexById(param1) != -1)
         {
            this._garageList.deleteItem(param1);
         }
         if(itemService.isKit(param1))
         {
            _loc3_ = GarageKit(param1.adapt(GarageKit)).getItems();
            for each(_loc4_ in _loc3_)
            {
               this._kitsByItem.remove(_loc4_.item,param1);
            }
         }
      }
      
      public function removeItemFromStore(param1:IGameObject) : void
      {
         if(itemService.isGrouped(param1))
         {
            this.removeGroupedItemsFromStore(param1);
         }
         else
         {
            this.removeSingleItemFromStore(param1);
         }
         this.updateSelection();
      }
      
      private function removeGroupedItemsFromStore(param1:IGameObject) : void
      {
         var _loc4_:IGameObject = null;
         var _loc2_:int = int(itemService.getGroup(param1));
         var _loc3_:int = this._itemsInStore.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = this._itemsInStore[_loc3_];
            if(Boolean(itemService.isGrouped(_loc4_)) && itemService.getGroup(_loc4_) == _loc2_)
            {
               this.removeSingleItemFromStore(_loc4_);
            }
            _loc3_--;
         }
      }
      
      public function get itemsInDepot() : Vector.<IGameObject>
      {
         return this._itemsInDepot;
      }
      
      public function showDefaultCategory() : void
      {
         this.showCategory(this.getCategoryFromShared());
      }
      
      private function getCategoryFromShared() : ItemViewCategoryEnum
      {
         var _loc1_:int = 0;
         if(storageService.getStorage().data.hasOwnProperty(LAST_SHOWED_GARAGE_CATEGORY_SHARED_KEY))
         {
            _loc1_ = int(storageService.getStorage().data[LAST_SHOWED_GARAGE_CATEGORY_SHARED_KEY]);
            if(_loc1_ < 0 || _loc1_ >= ItemViewCategoryEnum.values.length)
            {
               return DEFAULT_CATEGORY_TO_SHOW;
            }
            return ItemViewCategoryEnum.values[_loc1_];
         }
         return DEFAULT_CATEGORY_TO_SHOW;
      }
      
      public function showItemInCategory(param1:IGameObject) : void
      {
         var _loc3_:IGameObject = null;
         var _loc2_:IGameObject = param1;
         if(itemService.isModificationItem(param1))
         {
            _loc3_ = itemService.getMaxUserModificationItem(param1);
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_;
            }
            else
            {
               _loc2_ = itemService.getMaxAvailableModification(param1);
            }
         }
         this.showCategory(itemService.getViewCategory(_loc2_),_loc2_);
      }
      
      public function updateSelection() : void
      {
         if(this._garageList.selectedItem == null && this._garageList.itemsCount() > 0)
         {
            this.selectAndScrollToItemInCategory(this._garageList.getItemAt(0));
         }
      }
      
      public function updateDiscount(param1:IGameObject) : void
      {
         var _loc2_:IGameObject = null;
         this.updateKitsContainsItem(param1);
         this.updateVisibilityDiscountIndicatorsWithDelay();
         if(this.isItemInStore(param1))
         {
            this._garageList.updateDiscountAndCost(param1,itemService.getDiscount(param1),itemService.getEndDiscountTimer(param1),itemService.getPrice(param1));
            return;
         }
         if(itemService.isModificationItem(param1))
         {
            _loc2_ = itemService.getMaxUserModificationItem(param1);
            if(_loc2_ != null && itemService.getMaxAvailableOrNextNotAvailableModification(_loc2_) == param1)
            {
               this._garageList.updateDiscountWithTimer(_loc2_,itemService.getDiscount(param1),itemService.getEndDiscountTimer(param1));
            }
            return;
         }
         if(itemService.isCountable(param1))
         {
            this._garageList.updateDiscountAndCost(param1,itemService.getDiscount(param1),itemService.getEndDiscountTimer(param1),itemService.getPrice(param1));
         }
      }
      
      private function updateVisibilityDiscountIndicatorsWithDelay() : void
      {
         clearTimeout(this._updateVisibilityDiscountIndicatorsTimeoutId);
         this._updateVisibilityDiscountIndicatorsTimeoutId = setTimeout(this.updateVisibilityDiscountIndicators,UPDATE_VISIBILITY_DISCOUNT_INDICATORS_DELAY);
      }
      
      private function updateVisibilityDiscountIndicators() : void
      {
         var _loc4_:ItemViewCategoryEnum = null;
         var _loc5_:Boolean = false;
         var _loc1_:Vector.<ItemViewCategoryEnum> = ItemViewCategoryEnum.values;
         var _loc2_:int = int(_loc1_.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            //if(_loc4_ != ItemViewCategoryEnum.INVISIBLE)
            //{
            //   _loc5_ = false;
            //   if(_loc4_ != ItemViewCategoryEnum.KIT && !notificationGarageCategoriesService.isNeedShowNewItemNotification(_loc4_))
            //   {
            //      if(this.hasAvailableTemporaryDiscounts(_loc4_))
            //      {
            //         _loc5_ = true;
            //      }
            //   }
            //   if(_loc5_)
            //   {
            //      this._categoryButtons.showDiscountIndicator(_loc4_);
            //   }
            //   else
            //   {
            //      this._categoryButtons.hideDiscountIndicator(_loc4_);
            //   }
            //}
            _loc3_++;
         }
      }
      
      private function hasAvailableTemporaryDiscounts(param1:ItemViewCategoryEnum) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:IGameObject = null;
         var _loc7_:IGameObject = null;
         var _loc2_:Vector.<IGameObject> = this.getItemsByCategory(this._itemsInDepot,param1);
         _loc4_ = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = _loc2_[_loc3_];
            if(this.isAvailableTemporaryDiscount(_loc6_,true))
            {
               return true;
            }
            _loc3_++;
         }
         var _loc5_:Vector.<IGameObject> = this.getItemsByCategory(this._itemsInStore,param1);
         _loc4_ = int(_loc5_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc7_ = _loc5_[_loc3_];
            if(this.isAvailableTemporaryDiscount(_loc7_,false))
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function isAvailableTemporaryDiscount(param1:IGameObject, param2:Boolean) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:CountDownTimer = null;
         if(param2)
         {
            if(this.getDiscountForDepotItem(param1) > 0)
            {
               _loc4_ = this.getEndDiscountTimer(param1,param2);
            }
         }
         else if(userPropertiesService.rank >= itemService.getMinRankIndex(param1))
         {
            _loc4_ = itemService.getEndDiscountTimer(param1);
         }
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.getEndTime() > getTimer();
         }
         return _loc3_;
      }
      
      public function getCurrentCategoryItemsCount() : int
      {
         return this._garageList.itemsCount();
      }
   }
}

