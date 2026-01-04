package alternativa.tanks.model.garage.upgrade
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.tanks.gui.GarageWindowEvent;
   import alternativa.tanks.gui.IGarageWindow;
   import alternativa.tanks.gui.ItemInfoPanel;
   import alternativa.tanks.gui.upgrade.ItemPropertyUpgradeEvent;
   import alternativa.tanks.model.item.upgradable.UpgradableItem;
   import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
   import alternativa.tanks.service.garage.GarageService;
   import alternativa.tanks.service.item.ItemService;
   import alternativa.tanks.service.money.IMoneyService;
   import alternativa.tanks.service.upgradingitems.UpgradingItemsService;
   import controls.timer.CountDownTimer;
   import controls.timer.CountDownTimerOnCompleteBefore;
   import flash.events.Event;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.garage.models.garage.upgrade.IUpgradeGarageItemModelBase;
   import projects.tanks.client.garage.models.garage.upgrade.UpgradeGarageItemModelBase;
   import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   
   [ModelInfo]
   public class UpgradeGarageItemModel extends UpgradeGarageItemModelBase implements IUpgradeGarageItemModelBase, UpgradeGarageItem, ObjectLoadPostListener, CountDownTimerOnCompleteBefore, ObjectUnloadListener, ObjectLoadListener, FlushUpgrades
   {
      
      [Inject] // added
      public static var upgradingItemsService:UpgradingItemsService;
      
      [Inject] // added
      public static var moneyService:IMoneyService;
      
      [Inject] // added
      public static var garageService:GarageService;
      
      [Inject] // added
      public static var itemService:ItemService;
      
      [Inject] // added
      public static var clientLog:IClientLog;
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      private var garageWindow:IGarageWindow;
      
      private var itemInfoPanel:ItemInfoPanel;
      
      private var selectedTimer:CountDownTimer;
      
      private var selectedItem:IGameObject;
      
      private var delayUpgrades:DelayUpgrades;
      
      public function UpgradeGarageItemModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         this.selectedTimer = null;
         this.delayUpgrades = new DelayUpgrades(FlushUpgrades(object.adapt(FlushUpgrades)));
         lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onBeginLayoutSwitch);
      }
      
      private function onBeginLayoutSwitch(param1:LobbyLayoutServiceEvent) : void
      {
         if(this.delayUpgrades.isDelayed())
         {
            this.delayUpgrades.flushToServer();
         }
      }
      
      public function objectLoadedPost() : void
      {
         this.garageWindow = garageService.getView();
         this.itemInfoPanel = this.garageWindow.getItemInfoPanel();
         this.itemInfoPanel.addEventListener(ItemPropertyUpgradeEvent.SPEED_UP,getFunctionWrapper(this.onSpeedUp));
         this.itemInfoPanel.addEventListener(ItemPropertyUpgradeEvent.UPGRADE_STARTED,getFunctionWrapper(this.onUpgradeStarted));
         this.itemInfoPanel.addEventListener(ItemPropertyUpgradeEvent.FLUSH_UPGRADES,getFunctionWrapper(this.onFlushUpgrades));
         this.garageWindow.addEventListener(GarageWindowEvent.STORE_ITEM_SELECTED,getFunctionWrapper(this.onStoreListSelect));
         this.garageWindow.addEventListener(GarageWindowEvent.WAREHOUSE_ITEM_SELECTED,getFunctionWrapper(this.onDepotListSelect));
      }
      
      public function objectUnloaded() : void
      {
         lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onBeginLayoutSwitch);
         this.itemInfoPanel.removeEventListener(ItemPropertyUpgradeEvent.SPEED_UP,getFunctionWrapper(this.onSpeedUp));
         this.itemInfoPanel.removeEventListener(ItemPropertyUpgradeEvent.UPGRADE_STARTED,getFunctionWrapper(this.onUpgradeStarted));
         this.itemInfoPanel.removeEventListener(ItemPropertyUpgradeEvent.FLUSH_UPGRADES,getFunctionWrapper(this.onFlushUpgrades));
         this.garageWindow.removeEventListener(GarageWindowEvent.STORE_ITEM_SELECTED,getFunctionWrapper(this.onStoreListSelect));
         this.garageWindow.removeEventListener(GarageWindowEvent.WAREHOUSE_ITEM_SELECTED,getFunctionWrapper(this.onDepotListSelect));
         this.deselectTimer();
         this.delayUpgrades = null;
         this.garageWindow = null;
         this.itemInfoPanel = null;
      }
      
      public function isUpgradesEnabled() : Boolean
      {
         return false;
      }
      
      public function itemAlreadyUpgraded(param1:int) : void
      {
         moneyService.changeCrystals(param1);
      }
      
      private function onSpeedUp(param1:ItemPropertyUpgradeEvent) : void
      {
         var _loc2_:UpgradableItemParams = itemService.getUpgradableItemParams(this.selectedItem);
         if(_loc2_.getInitialSpeedUpPrice() == param1.getPrice() && this.delayUpgrades.isDelayedItem(this.selectedItem))
         {
            this.delayUpgrades.speedUp(param1.getPrice());
         }
         else
         {
            this.delayUpgrades.flushToServer();
            server.speedUp(this.selectedItem,param1.getPrice());
         }
         moneyService.spend(param1.getPrice());
         param1.getTimer().stop();
      }
      
      private function onUpgradeStarted(param1:ItemPropertyUpgradeEvent) : void
      {
         var _loc2_:UpgradableItemParams = itemService.getUpgradableItemParams(this.selectedItem);
         this.delayUpgrades.startUpgrade(this.selectedItem,param1.getPrice(),_loc2_.getTimeInSeconds());
         _loc2_.startUpgrade(param1.getTimer());
         moneyService.spend(param1.getPrice());
         this.selectTimer(param1.getTimer());
         upgradingItemsService.add(itemService.getGarageItemInfo(this.selectedItem),param1.getTimer());
      }
      
      public function onCompleteBefore(param1:CountDownTimer, param2:Boolean) : void
      {
         var _loc3_:UpgradableItem = null;
         if(this.selectedTimer == param1)
         {
            _loc3_ = UpgradableItem(this.selectedItem.adapt(UpgradableItem));
            this.selectedTimer = null;
            _loc3_.speedUp();
            upgradingItemsService.remove(this.selectedItem);
            if(!param2)
            {
               upgradingItemsService.informServerAboutUpgradedItem(this.selectedItem);
            }
            this.garageWindow.getItemInfoPanel().itemUpgraded();
            if(_loc3_.getUpgradableItem().isFullUpgraded())
            {
               this.garageWindow.itemFullUpgraded(this.selectedItem);
            }
         }
      }
      
      private function selectTimer(param1:CountDownTimer) : void
      {
         this.deselectTimer();
         if(param1 != null)
         {
            this.selectedTimer = param1;
            this.selectedTimer.addListener(CountDownTimerOnCompleteBefore,this);
         }
      }
      
      private function deselectTimer() : void
      {
         if(this.selectedTimer != null)
         {
            this.selectedTimer.removeListener(CountDownTimerOnCompleteBefore,this);
            this.selectedTimer = null;
         }
      }
      
      private function onDepotListSelect(param1:GarageWindowEvent) : void
      {
         this.onItemSelected(param1.item,true);
      }
      
      private function onStoreListSelect(param1:GarageWindowEvent) : void
      {
         this.onItemSelected(param1.item,false);
      }
      
      private function onItemSelected(param1:IGameObject, param2:Boolean) : void
      {
         if(this.selectedItem != param1)
         {
            this.deselectTimer();
            this.selectedItem = param1;
            if(param2)
            {
               if(this.selectedItem.hasModel(UpgradableItem))
               {
                  this.selectTimer(UpgradableItem(this.selectedItem.adapt(UpgradableItem)).getCountDownTimer());
               }
            }
         }
      }
      
      private function onFlushUpgrades(param1:Event) : void
      {
         if(this.delayUpgrades.isDelayed())
         {
            this.delayUpgrades.flushToServer();
         }
      }
      
      public function flushToServer(param1:DelayUpgrades, param2:IGameObject) : void
      {
         var _loc3_:int = 0;
         if(param1.isDelayed())
         {
            _loc3_ = param1.getNumLevels();
            if(_loc3_ > 0)
            {
               server.instantUpgrade(param2,_loc3_,param1.getPrice());
            }
            if(param1.isUpgradeStarted())
            {
               server.upgradeItem(param2,param1.getStartUpgradePrice(),param1.getUpgradeTime());
            }
         }
      }
   }
}

