package alternativa.tanks.service.upgradingitems
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.alerts.UpgradedItemsAlert;
   import alternativa.tanks.model.garage.upgradingitems.UpgradingItem;
   import alternativa.types.Long;
   import controls.timer.CountDownTimer;
   import controls.timer.CountDownTimerOnCompleteAfter;
   import flash.events.Event;
   import flash.utils.getTimer;
   import forms.events.PartsListEvent;
   import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
   import platform.client.fp10.core.network.handler.OnConnectionClosedServiceListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.models.layout.LayoutState;
   import projects.tanks.client.panel.model.garage.GarageItemInfo;
   import projects.tanks.clients.flash.commons.models.runtime.DataOwner;
   import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   
   public class UpgradingItemsServiceImpl implements UpgradingItemsService, CountDownTimerOnCompleteAfter, OnConnectionClosedServiceListener
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      private var upgradingItems:Vector.<ItemInfo> = new Vector.<ItemInfo>();
      
      private var alert:UpgradedItemsAlert;
      
      private var callback:UpgradingItem;
      
      private var showUpgradeNotifications:Boolean = false;
      
      public function UpgradingItemsServiceImpl()
      {
         super();
      }
      
      public function init(param1:Vector.<GarageItemInfo>, param2:UpgradingItem) : void
      {
         var _loc5_:CountDownTimer = null;
         this.callback = param2;
         var _loc3_:int = getTimer();
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = new CountDownTimer();
            _loc5_.start(_loc3_ + GarageItemInfo(param1[_loc4_]).remainingTimeInMS);
            this.add(param1[_loc4_],_loc5_);
            _loc4_++;
         }
      }
      
      public function add(param1:GarageItemInfo, param2:CountDownTimer) : void
      {
         var _loc3_:ItemInfo = new ItemInfo(param1,param2);
         this.addListener(param2);
         this.upgradingItems.push(_loc3_);
         this.upgradingItems.sort(this.compare);
         if(this.upgradingItems.length == 1)
         {
            lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onBeginLayoutSwitch);
            lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
            this.startShowUpgradeNotifications();
         }
      }
      
      public function remove(param1:IGameObject) : void
      {
         var _loc2_:int = this.upgradingItemsIndexOf(param1);
         if(_loc2_ != -1)
         {
            this.removeByIndex(_loc2_);
         }
      }
      
      private function removeByIndex(param1:int) : void
      {
         this.removeListener(this.upgradingItems[param1].timer);
         this.upgradingItems.splice(param1,1);
      }
      
      private function checkItems() : void
      {
         var _loc2_:ItemInfo = null;
         if(this.alert != null)
         {
            return;
         }
         var _loc1_:Vector.<ItemInfo> = new Vector.<ItemInfo>();
         while(this.upgradingItems.length > 0 && this.upgradingItems[this.upgradingItems.length - 1].timer.getRemainingSeconds() <= 0)
         {
            _loc2_ = this.upgradingItems.pop();
            this.removeListener(_loc2_.timer);
            _loc1_.push(_loc2_);
         }
         this.showUpgradedItems(_loc1_);
         if(this.upgradingItems.length == 0)
         {
            this.stopShowUpgradeNotifications();
         }
      }
      
      private function showUpgradedItems(param1:Vector.<ItemInfo>) : void
      {
         this.show(param1,TanksLocale.TEXT_HEADER_CONGRATULATION,localeService.getText(TanksLocale.TEXT_GARAGE_UPGRADE_COMPLETE_TEXT));
      }
      
      public function getCountDownTimer(param1:IGameObject) : CountDownTimer
      {
         var _loc2_:int = this.upgradingItemsIndexOf(param1);
         if(_loc2_ != -1)
         {
            return this.upgradingItems[_loc2_].timer;
         }
         return null;
      }
      
      public function onMount(param1:IGameObject, param2:IGameObject) : void
      {
         var _loc3_:int = this.upgradingItemsIndexOf(param1);
         var _loc4_:int = this.upgradingItemsIndexOf(param2);
         if(_loc3_ != -1)
         {
            this.upgradingItems[_loc3_].info.mounted = false;
         }
         if(_loc4_ != -1)
         {
            this.upgradingItems[_loc4_].info.mounted = true;
         }
      }
      
      private function show(param1:Vector.<ItemInfo>, param2:String, param3:String) : void
      {
         if(param1.length > 0)
         {
            this.alert = new UpgradedItemsAlert(param1,param2,param3);
            this.alert.addEventListener(Event.CANCEL,this.onClose);
            this.alert.addEventListener(PartsListEvent.ITEM_CLICK,this.onItemSelect);
         }
      }
      
      private function onItemSelect(param1:PartsListEvent) : void
      {
         this.callback.select(this.alert.partsList.selectedItem);
         this.closeAlert();
      }
      
      private function onClose(param1:Event) : void
      {
         this.closeAlert();
      }
      
      private function closeAlert() : void
      {
         this.alert.removeEventListener(Event.CANCEL,this.onClose);
         this.alert.removeEventListener(PartsListEvent.ITEM_CLICK,this.onItemSelect);
         this.alert = null;
         this.checkItems();
      }
      
      private function onBeginLayoutSwitch(param1:LobbyLayoutServiceEvent) : void
      {
         this.stopShowUpgradeNotifications();
      }
      
      private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void
      {
         if(param1.state != LayoutState.BATTLE)
         {
            this.startShowUpgradeNotifications();
            this.checkItems();
         }
      }
      
      private function startShowUpgradeNotifications() : void
      {
         if(!this.showUpgradeNotifications)
         {
            if(lobbyLayoutService.getCurrentState() != LayoutState.BATTLE)
            {
               this.showUpgradeNotifications = true;
            }
         }
      }
      
      private function stopShowUpgradeNotifications() : void
      {
         if(this.showUpgradeNotifications)
         {
            this.showUpgradeNotifications = false;
            if(this.upgradingItems.length == 0)
            {
               lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onBeginLayoutSwitch);
               lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
            }
         }
      }
      
      public function onCompleteAfter(param1:CountDownTimer, param2:Boolean) : void
      {
         var _loc3_:int = this.indexOfByTimer(param1);
         this.callback.itemUpgraded(this.upgradingItems[_loc3_].info.item);
         if(this.showUpgradeNotifications)
         {
            if(param2)
            {
               this.removeByIndex(_loc3_);
            }
            else
            {
               this.checkItems();
            }
         }
      }
      
      public function reset() : void
      {
         var _loc1_:ItemInfo = null;
         for each(_loc1_ in this.upgradingItems)
         {
            _loc1_.timer.destroy();
         }
         this.upgradingItems.length = 0;
      }
      
      public function onConnectionClosed(param1:ConnectionCloseStatus) : void
      {
         this.reset();
      }
      
      private function compare(param1:ItemInfo, param2:ItemInfo) : Number
      {
         return param2.timer.getEndTime() - param1.timer.getEndTime();
      }
      
      private function upgradingItemsIndexOf(param1:IGameObject) : int
      {
         var _loc4_:ItemInfo = null;
         var _loc2_:Long = DataOwner(param1.adapt(DataOwner)).getDataOwnerId();
         var _loc3_:int = 0;
         while(_loc3_ < this.upgradingItems.length)
         {
            _loc4_ = this.upgradingItems[_loc3_];
            if(this.equalsLong(_loc4_.ownerId,_loc2_))
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function indexOfByTimer(param1:CountDownTimer) : int
      {
         var _loc3_:ItemInfo = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.upgradingItems.length)
         {
            _loc3_ = this.upgradingItems[_loc2_];
            if(_loc3_.timer == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function addListener(param1:CountDownTimer) : void
      {
         param1.addListener(CountDownTimerOnCompleteAfter,this);
      }
      
      private function removeListener(param1:CountDownTimer) : void
      {
         param1.removeListener(CountDownTimerOnCompleteAfter,this);
      }
      
      public function informServerAboutUpgradedItem(param1:IGameObject) : void
      {
         this.callback.itemUpgraded(param1);
      }
      
      public function equalsLong(param1:Long, param2:Long) : Boolean
      {
         return param1.high == param2.high && param1.low == param2.low;
      }
   }
}

