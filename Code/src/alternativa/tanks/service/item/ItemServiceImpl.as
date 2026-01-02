package alternativa.tanks.service.item
{
   import alternativa.model.description.IDescription;
   import alternativa.model.timeperiod.TimePeriod;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.IGarageWindow;
   import alternativa.tanks.model.item.buyable.IBuyable;
   import alternativa.tanks.model.item.category.IItemCategory;
   import alternativa.tanks.model.item.category.IItemViewCategory;
   import alternativa.tanks.model.item.countable.ICountableItem;
   import alternativa.tanks.model.item.discount.DiscountEndTimer;
   import alternativa.tanks.model.item.discount.IDiscount;
   import alternativa.tanks.model.item.grouped.IGroupedItem;
   import alternativa.tanks.model.item.item.IItem;
   import alternativa.tanks.model.item.kit.GarageKit;
   import alternativa.tanks.model.item.modification.IModification;
   import alternativa.tanks.model.item.premium.PremiumItem;
   import alternativa.tanks.model.item.properties.ItemProperties;
   import alternativa.tanks.model.item.properties.ItemPropertyValue;
   import alternativa.tanks.model.item.upgradable.UpgradableItem;
   import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
   import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
   import alternativa.tanks.service.garage.GarageService;
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
   import alternativa.tanks.service.resistance.ResistanceService;
   import alternativa.tanks.service.upgradingitems.UpgradingItemsService;
   import alternativa.types.Long;
   import controls.timer.CountDownTimer;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.IGameClass;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.commons.types.ItemGarageProperty;
   import projects.tanks.client.commons.types.ItemViewCategoryEnum;
   import projects.tanks.client.panel.model.garage.GarageItemInfo;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.LocaleServiceLangValues;
   
   public class ItemServiceImpl extends EventDispatcher implements ItemService
   {
      
      [Inject]
      public static var userPropertyService:IUserPropertiesService;
      
      [Inject]
      public static var propertyService:ItemPropertyParamsService;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var upgradingItemsService:UpgradingItemsService;
      
      [Inject]
      public static var garageService:GarageService;
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var itemService:ItemService;
      
      [Inject]
      public static var resistancesService:ResistanceService;
      
      private var mountedItems:Vector.<IGameObject> = new Vector.<IGameObject>();
      
      private var itemToModifications:Dictionary;
      
      private var hasItemMap:Dictionary;
      
      private var groupedItems:Dictionary = new Dictionary();
      
      private var isMountableCategoryMap:Dictionary;
      
      private var resistanceModuleDescription:Dictionary = new Dictionary();
      
      private const delayItemAppearingInSeconds:int = 5;
      
      public function ItemServiceImpl()
      {
         super();
         this.reset();
         this.resistanceModuleDescription[ItemGarageProperty.FIREBIRD_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_FIREBIRD;
         this.resistanceModuleDescription[ItemGarageProperty.FREEZE_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_FREEZE;
         this.resistanceModuleDescription[ItemGarageProperty.ISIS_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_ISIDA;
         this.resistanceModuleDescription[ItemGarageProperty.RAILGUN_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_RAILGUN;
         this.resistanceModuleDescription[ItemGarageProperty.RICOCHET_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_RICOCHET;
         this.resistanceModuleDescription[ItemGarageProperty.SHAFT_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_SHAFT;
         this.resistanceModuleDescription[ItemGarageProperty.SMOKY_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_SMOKY;
         this.resistanceModuleDescription[ItemGarageProperty.THUNDER_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_THUNDER;
         this.resistanceModuleDescription[ItemGarageProperty.TWINS_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_TWINS;
         this.resistanceModuleDescription[ItemGarageProperty.MINE_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_MINE;
         this.resistanceModuleDescription[ItemGarageProperty.SHOTGUN_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_SHOTGUN;
         this.resistanceModuleDescription[ItemGarageProperty.MACHINE_GUN_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_MACHINE_GUN;
         this.resistanceModuleDescription[ItemGarageProperty.ROCKET_LAUNCHER_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_ROCKET_LAUNCHER;
         this.resistanceModuleDescription[ItemGarageProperty.ARTILLERY_RESISTANCE] = TanksLocale.TEXT_REDUCE_DAMAGE_ARTILLERY;
      }
      
      public function getPreviewResource(param1:IGameObject) : ImageResource
      {
         return IItem(param1.adapt(IItem)).getPreviewResource();
      }
      
      public function getCategory(param1:IGameObject) : ItemCategoryEnum
      {
         return IItemCategory(param1.adapt(IItemCategory)).getCategory();
      }
      
      public function getViewCategory(param1:IGameObject) : ItemViewCategoryEnum
      {
         return IItemViewCategory(param1.adapt(IItemViewCategory)).getViewCategory();
      }
      
      public function getName(param1:IGameObject) : String
      {
         var _loc2_:String = IDescription(param1.adapt(IDescription)).getName();
         if(itemService.isModificationItem(param1))
         {
            _loc2_ += (localeService.language == LocaleServiceLangValues.CN ? "" : " ") + "M" + itemService.getModificationIndex(param1);
         }
         return _loc2_;
      }
      
      public function getDescription(param1:IGameObject) : String
      {
         var _loc3_:Vector.<ItemPropertyValue> = null;
         var _loc4_:String = null;
         var _loc5_:UpgradableItemPropertyValue = null;
         var _loc2_:String = "";
         if(this.getCategory(param1) == ItemCategoryEnum.RESISTANCE_MODULE)
         {
            _loc3_ = this.getProperties(param1);
            if(_loc3_.length > 0)
            {
               _loc2_ = localeService.getText(TanksLocale.TEXT_GARAGE_RESISTANCE_DESCRIPTION_PREFIX) + "\n";
               if(_loc3_.length == 1 && _loc3_[0].getProperty() == ItemGarageProperty.ALL_RESISTANCE)
               {
                  for each(_loc4_ in this.resistanceModuleDescription)
                  {
                     _loc2_ += localeService.getText(_loc4_) + "\n";
                  }
               }
               else
               {
                  for each(_loc5_ in _loc3_)
                  {
                     _loc2_ += localeService.getText(this.resistanceModuleDescription[_loc5_.getProperty()]) + "\n";
                  }
               }
               _loc2_ += "\n";
            }
         }
         return _loc2_ + IDescription(param1.adapt(IDescription)).getDescription();
      }
      
      public function getModificationIndex(param1:IGameObject) : int
      {
         if(this.isModificationItem(param1))
         {
            return IModification(param1.adapt(IModification)).getModificationIndex();
         }
         return -1;
      }
      
      public function getModifications(param1:IGameObject) : Vector.<IGameObject>
      {
         this.createItem2ModificationsIfNeed(param1.space.objects);
         return this.itemToModifications[param1];
      }
      
      private function createItem2ModificationsIfNeed(param1:Vector.<IGameObject>) : void
      {
         var items:Vector.<IGameObject> = null;
         var gameObject:IGameObject = null;
         var comparator:Function = null;
         var i:int = 0;
         var j:int = 0;
         var modifications:Vector.<IGameObject> = null;
         var item:IGameObject = null;
         var objects:Vector.<IGameObject> = param1;
         if(this.itemToModifications == null)
         {
            this.itemToModifications = new Dictionary();
            items = new Vector.<IGameObject>();
            for each(gameObject in objects)
            {
               if(gameObject.hasModel(IModification))
               {
                  items.push(gameObject);
               }
            }
            comparator = function(param1:IGameObject, param2:IGameObject):int
            {
               var _loc3_:Long = IModification(param1.adapt(IModification)).getBaseItemId();
               var _loc4_:Long = IModification(param2.adapt(IModification)).getBaseItemId();
               return Long.comparator(_loc3_,_loc4_);
            };
            items.sort(comparator);
            i = 0;
            while(i < items.length)
            {
               j = i + 1;
               while(j < items.length && comparator(items[i],items[j]) == 0)
               {
                  j++;
               }
               modifications = new Vector.<IGameObject>(j - i);
               while(i < j)
               {
                  item = items[i];
                  modifications[IModification(item.adapt(IModification)).getModificationIndex()] = item;
                  this.itemToModifications[item] = modifications;
                  i++;
               }
            }
         }
      }
      
      public function getModificationsCount(param1:IGameObject) : int
      {
         return this.getModifications(param1).length;
      }
      
      public function getPrice(param1:IGameObject) : int
      {
         if(this.isKit(param1))
         {
            return GarageKit(param1.adapt(GarageKit)).getPrice();
         }
         return IBuyable(param1.adapt(IBuyable)).getPrice();
      }
      
      public function getDiscount(param1:IGameObject) : int
      {
         return IDiscount(param1.adapt(IDiscount)).getDiscountInPercent();
      }
      
      public function getEndDiscountTimer(param1:IGameObject) : CountDownTimer
      {
         if(!param1.hasModel(DiscountEndTimer))
         {
            return null;
         }
         return DiscountEndTimer(param1.adapt(DiscountEndTimer)).getEndDiscountTimer();
      }
      
      public function getPriceWithoutDiscount(param1:IGameObject) : int
      {
         return IBuyable(param1.adapt(IBuyable)).getPriceWithoutDiscount();
      }
      
      public function isBuyable(param1:IGameObject) : Boolean
      {
         return Boolean(IBuyable(param1.adapt(IBuyable)).isBuyable()) && this.isEnabledItem(param1);
      }
      
      public function getProperties(param1:IGameObject) : Vector.<ItemPropertyValue>
      {
         if(param1.hasModel(ItemProperties))
         {
            return ItemProperties(param1.adapt(ItemProperties)).getProperties();
         }
         return null;
      }
      
      public function getPropertiesForInfoWindow(param1:IGameObject) : Vector.<ItemPropertyValue>
      {
         if(param1.hasModel(ItemProperties))
         {
            return ItemProperties(param1.adapt(ItemProperties)).getPropertiesForInfoWindow();
         }
         return null;
      }
      
      public function getUpgradableItemParams(param1:IGameObject) : UpgradableItemParams
      {
         return UpgradableItem(param1.adapt(UpgradableItem)).getUpgradableItem();
      }
      
      public function getCurrentValue(param1:IGameObject, param2:ItemPropertyValue) : String
      {
         var _loc3_:int = 0;
         if(this.isUpgradableItem(param1))
         {
            _loc3_ = this.getUpgradableItemParams(param1).getLevel();
            return param2.getValue(_loc3_);
         }
         return param2.getValue();
      }
      
      public function isUpgradableItem(param1:IGameObject) : Boolean
      {
         return param1.hasModel(UpgradableItem);
      }
      
      public function getMinRankIndex(param1:IGameObject) : int
      {
         return IItem(param1.adapt(IItem)).getMinRank();
      }
      
      public function getMaxRankIndex(param1:IGameObject) : int
      {
         return IItem(param1.adapt(IItem)).getMaxRank();
      }
      
      public function getPosition(param1:IGameObject) : int
      {
         return IItem(param1.adapt(IItem)).getPosition();
      }
      
      public function getNextModification(param1:IGameObject) : IGameObject
      {
         var _loc2_:int = this.getModificationIndex(param1);
         var _loc3_:Vector.<IGameObject> = this.getModifications(param1);
         if(_loc2_ < _loc3_.length - 1)
         {
            return _loc3_[_loc2_ + 1];
         }
         return null;
      }
      
      public function hasNextModification(param1:IGameObject) : Boolean
      {
         if(!itemService.isModificationItem(param1))
         {
            return false;
         }
         var _loc2_:Vector.<IGameObject> = this.getModifications(param1);
         return param1 != _loc2_[_loc2_.length - 1];
      }
      
      public function getMaxUserModificationItem(param1:IGameObject) : IGameObject
      {
         var _loc4_:IGameObject = null;
         var _loc2_:Vector.<IGameObject> = this.getModifications(param1);
         var _loc3_:int = _loc2_.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = _loc2_[_loc3_];
            if(this.hasItem(_loc4_))
            {
               return _loc4_;
            }
            _loc3_--;
         }
         return null;
      }
      
      public function getPreviousModification(param1:IGameObject) : IGameObject
      {
         var _loc2_:int = this.getModificationIndex(param1);
         var _loc3_:Vector.<IGameObject> = this.getModifications(param1);
         if(_loc2_ > 0)
         {
            return _loc3_[_loc2_ - 1];
         }
         return null;
      }
      
      public function getCount(param1:IGameObject) : int
      {
         if(param1.hasModel(ICountableItem))
         {
            return ICountableItem(param1.adapt(ICountableItem)).getCount();
         }
         return 0;
      }
      
      public function setCount(param1:IGameObject, param2:int) : void
      {
         if(param1.hasModel(ICountableItem))
         {
            ICountableItem(param1.adapt(ICountableItem)).setCount(param2);
         }
      }
      
      public function isCountable(param1:IGameObject) : Boolean
      {
         return param1.hasModel(ICountableItem);
      }
      
      public function isModificationItem(param1:IGameObject) : Boolean
      {
         return Boolean(param1.hasModel(IModification)) && this.getModificationsCount(param1) > 1;
      }
      
      public function isKit(param1:IGameObject) : Boolean
      {
         return param1.hasModel(GarageKit);
      }
      
      public function isGrouped(param1:IGameObject) : Boolean
      {
         return Boolean(param1.hasModel(IGroupedItem)) && Boolean(IGroupedItem(param1.adapt(IGroupedItem)).isGrouped());
      }
      
      public function getGroup(param1:IGameObject) : int
      {
         return IGroupedItem(param1.adapt(IGroupedItem)).getGroup();
      }
      
      public function hasItem(param1:IGameObject) : Boolean
      {
         return param1 in this.hasItemMap;
      }
      
      public function reset() : void
      {
         this.itemToModifications = null;
         this.hasItemMap = new Dictionary();
         this.groupedItems = new Dictionary();
         this.isMountableCategoryMap = new Dictionary();
         this.mountedItems.length = 0;
      }
      
      public function addItem(param1:IGameObject) : void
      {
         if(param1 in this.hasItemMap)
         {
            return;
         }
         this.hasItemMap[param1] = true;
         if(this.isGrouped(param1))
         {
            this.groupedItems[this.getGroup(param1)] = true;
         }
         dispatchEvent(new ItemEvents(ItemEvents.OnItemAdded,param1));
      }
      
      public function removeItem(param1:IGameObject) : void
      {
         if(this.hasItem(param1))
         {
            delete this.hasItemMap[param1];
         }
      }
      
      public function canBuy(param1:IGameObject) : Boolean
      {
         if(!this.isBuyable(param1) || userPropertyService.rank > this.getMaxRankIndex(param1))
         {
            return false;
         }
         if(this.isGrouped(param1))
         {
            return !(this.getGroup(param1) in this.groupedItems);
         }
         if(this.isKit(param1))
         {
            return GarageKit(param1.adapt(GarageKit)).canBuy();
         }
         return this.isCountable(param1) || !this.hasItem(param1);
      }
      
      public function addMountableCategories(param1:Vector.<ItemCategoryEnum>) : void
      {
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            this.isMountableCategoryMap[param1[_loc2_]] = true;
            _loc2_++;
         }
      }
      
      public function isMountable(param1:IGameObject) : Boolean
      {
         return this.isMountableCategoryMap[this.getCategory(param1)] == true;
      }
      
      public function isUpgrading(param1:IGameObject) : Boolean
      {
         return Boolean(param1.hasModel(UpgradableItem)) && Boolean(this.upgradableItem(param1).isUpgrading());
      }
      
      public function getGarageItemInfo(param1:IGameObject) : GarageItemInfo
      {
         var _loc2_:GarageItemInfo = new GarageItemInfo();
         _loc2_.category = this.getCategory(param1);
         _loc2_.item = param1;
         _loc2_.modificationIndex = this.getModificationIndex(param1);
         _loc2_.mounted = this.isMounted(param1);
         _loc2_.name = this.getName(param1);
         _loc2_.position = this.getPosition(param1);
         _loc2_.premiumItem = this.isPremiumItem(param1);
         _loc2_.preview = this.getPreviewResource(param1);
         return _loc2_;
      }
      
      public function mountItem(param1:IGameObject) : void
      {
         var _loc2_:IGameObject = this.getMountedItemByCategory(this.getCategory(param1));
         if(_loc2_ == param1)
         {
            return;
         }
         var _loc3_:IGarageWindow = garageService.getView();
         if(_loc2_ != null)
         {
            upgradingItemsService.onMount(_loc2_,param1);
            this.unmountItem(_loc2_);
         }
         _loc3_.mountItem(param1);
         this.mountedItems.push(param1);
         if(_loc3_.getSelectedItem() == param1)
         {
            _loc3_.getItemInfoPanel().onMountItem();
         }
      }
      
      public function unmountItem(param1:IGameObject) : *
      {
         garageService.getView().unmountItem(param1);
         this.mountedItems.splice(this.mountedItems.indexOf(param1),1);
      }
      
      public function isMounted(param1:IGameObject) : Boolean
      {
         if(this.getCategory(param1) == ItemCategoryEnum.RESISTANCE_MODULE)
         {
            return resistancesService.isMounted(param1);
         }
         return this.getMountedItemByCategory(this.getCategory(param1)) == param1;
      }
      
      public function getMountedItemByCategory(param1:ItemCategoryEnum) : IGameObject
      {
         var _loc3_:IGameObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.mountedItems.length)
         {
            _loc3_ = this.mountedItems[_loc2_];
            if(this.getCategory(_loc3_) == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      private function upgradableItem(param1:IGameObject) : UpgradableItem
      {
         return UpgradableItem(param1.adapt(UpgradableItem));
      }
      
      public function isFullUpgraded(param1:IGameObject) : Boolean
      {
         return this.getUpgradableItemParams(param1).isFullUpgraded();
      }
      
      public function getTimeLeftInSeconds(param1:IGameObject) : int
      {
         var _loc2_:int = int(TimePeriod(param1.adapt(TimePeriod)).getTimeLeftInSeconds());
         return _loc2_ > this.delayItemAppearingInSeconds ? _loc2_ - this.delayItemAppearingInSeconds : 0;
      }
      
      public function isTimelessItem(param1:IGameObject) : Boolean
      {
         return TimePeriod(param1.adapt(TimePeriod)).isTimeless();
      }
      
      public function getTimeToStartInSeconds(param1:IGameObject) : int
      {
         var _loc2_:int = int(TimePeriod(param1.adapt(TimePeriod)).getTimeToStartInSeconds());
         return _loc2_ > 0 ? _loc2_ + this.delayItemAppearingInSeconds : 0;
      }
      
      private function isItemAlreadyAppear(param1:IGameObject) : Boolean
      {
         var _loc2_:int = int(TimePeriod(param1.adapt(TimePeriod)).getModelLoadingTimeInMillis());
         return getTimer() > _loc2_ + this.getTimeToStartInSeconds(param1) * 1000;
      }
      
      private function isItemAppearInDelayPeriod(param1:IGameObject) : Boolean
      {
         var _loc2_:int = int(TimePeriod(param1.adapt(TimePeriod)).getTimeLeftInSeconds());
         return _loc2_ > 0 && _loc2_ <= this.delayItemAppearingInSeconds;
      }
      
      public function isEnabledItem(param1:IGameObject) : Boolean
      {
         var _loc2_:Boolean = Boolean(TimePeriod(param1.adapt(TimePeriod)).isEnabled());
         return _loc2_ && !this.isItemAppearInDelayPeriod(param1) || this.getTimeToStartInSeconds(param1) > 0 && this.isItemAlreadyAppear(param1);
      }
      
      public function getMaxAvailableOrNextNotAvailableModification(param1:IGameObject) : IGameObject
      {
         var _loc2_:IGameObject = this.getMaxAvailableModification(param1);
         if(_loc2_ == param1)
         {
            _loc2_ = this.getNextModification(param1);
         }
         return _loc2_;
      }
      
      public function getMaxAvailableModification(param1:IGameObject) : IGameObject
      {
         var _loc2_:IGameObject = null;
         var _loc6_:IGameObject = null;
         if(userPropertyService.rank < this.getMinRankIndex(param1))
         {
            return param1;
         }
         var _loc3_:Vector.<IGameObject> = this.getModifications(param1);
         var _loc4_:int = int(_loc3_.length);
         var _loc5_:int = _loc4_ - 1;
         while(_loc5_ >= 0)
         {
            _loc6_ = _loc3_[_loc5_];
            if(userPropertyService.rank >= this.getMinRankIndex(_loc6_))
            {
               _loc2_ = _loc6_;
               break;
            }
            _loc5_--;
         }
         return _loc2_;
      }
      
      public function isPremiumItem(param1:IGameObject) : Boolean
      {
         return PremiumItem(param1.adapt(PremiumItem)).isPremiumItem();
      }
      
      public function isPresent(param1:IGameObject) : Boolean
      {
         return this.getCategory(param1) == ItemCategoryEnum.PRESENT;
      }
      
      public function isGivenPresent(param1:IGameObject) : Boolean
      {
         return this.getCategory(param1) == ItemCategoryEnum.GIVEN_PRESENT;
      }
      
      public function getUserItemByClass(param1:IGameClass) : IGameObject
      {
         var _loc2_:Object = null;
         var _loc3_:IGameObject = null;
         for(_loc2_ in this.hasItemMap)
         {
            _loc3_ = IGameObject(_loc2_);
            if(this.isModificationItem(_loc3_) && this.getBaseClass(_loc3_) == param1)
            {
               return this.getMaxUserModificationItem(_loc3_);
            }
         }
         return null;
      }
      
      private function getBaseClass(param1:IGameObject) : IGameClass
      {
         var userObject:IGameObject = param1;
         try
         {
            return this.getModifications(userObject)[0].gameClass;
         }
         catch(e:Error)
         {
            throw new Error("id=" + userObject.id + ", message" + e.message,e.errorID);
         }
      }
      
      public function getMountedItemsByCategory(param1:ItemCategoryEnum) : Vector.<IGameObject>
      {
         var _loc3_:* = undefined;
         var _loc2_:* = new Vector.<IGameObject>();
         for each(_loc3_ in this.mountedItems)
         {
            if(this.getCategory(_loc3_) == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

