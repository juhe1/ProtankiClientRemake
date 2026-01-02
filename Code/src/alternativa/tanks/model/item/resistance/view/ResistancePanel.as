package alternativa.tanks.model.item.resistance.view
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.GarageWindowEvent;
   import alternativa.tanks.gui.ItemInfoPanel;
   import alternativa.tanks.gui.buttons.GarageButton;
   import alternativa.tanks.gui.buttons.TimerButton;
   import alternativa.tanks.gui.buttons.TimerButtonEvent;
   import alternativa.tanks.gui.upgrade.SelectUpgradeWindow;
   import alternativa.tanks.gui.upgrade.UpgradeButton;
   import alternativa.tanks.model.item.upgradable.UpgradableItem;
   import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
   import alternativa.tanks.service.garage.GarageService;
   import alternativa.tanks.service.item.ItemService;
   import alternativa.tanks.service.resistance.ResistanceService;
   import alternativa.tanks.tracker.ITrackerService;
   import controls.timer.CountDownTimer;
   import flash.display.DisplayObjectContainer;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import platform.client.fp10.core.type.AutoClosable;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   
   public class ResistancePanel implements AutoClosable
   {
      
      [Inject]
      public static var itemService:ItemService;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var garageService:GarageService;
      
      [Inject]
      public static var trackerService:ITrackerService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      [Inject]
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject]
      public static var userGarageActionsService:UserGarageActionsService;
      
      [Inject]
      public static var delayMountCategoryService:IDelayMountCategoryService;
      
      [Inject]
      public static var resistancesService:ResistanceService;
      
      [Inject]
      public static var userPropertiesService:IUserPropertiesService;
      
      private const BUTTON_WIDTH:Number = 120;
      
      private const MARGIN:Number = 11;
      
      private const SPACE:Number = 15;
      
      private var selectWindow:SelectUpgradeWindow;
      
      private var buyButton:GarageButton = new GarageButton();
      
      private var upgradeButton:UpgradeButton = new UpgradeButton();
      
      private var equipButton:TimerButton = new TimerButton();
      
      private var item:IGameObject;
      
      private var garageWindowDispatcher:IEventDispatcher;
      
      public function ResistancePanel()
      {
         super();
         this.buyButton.width = this.BUTTON_WIDTH;
         this.upgradeButton.width = this.BUTTON_WIDTH;
         this.equipButton.width = this.BUTTON_WIDTH;
         this.buyButton.x = this.MARGIN;
         this.upgradeButton.x = this.buyButton.x + this.BUTTON_WIDTH + this.SPACE;
         this.equipButton.x = this.upgradeButton.x + this.BUTTON_WIDTH + this.SPACE;
         this.buyButton.setText(localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_BUY_TEXT));
         this.buyButton.addEventListener(MouseEvent.CLICK,this.onButtonBuyClick);
         this.upgradeButton.addEventListener(MouseEvent.CLICK,this.onButtonUpgradeClick);
         this.equipButton.addEventListener(MouseEvent.CLICK,this.onButtonEquipClick);
      }
      
      private function updateButtonsVisibility() : void
      {
         this.buyButton.visible = Boolean(itemService.canBuy(this.item)) || Boolean(itemService.hasNextModification(this.item));
         this.upgradeButton.visible = !itemService.canBuy(this.item) && Boolean(itemService.isModificationItem(this.item));
         this.equipButton.visible = (!resistancesService.getView().isFull() || resistancesService.isMounted(this.item)) && !itemService.canBuy(this.item);
      }
      
      public function onDoubleClick() : *
      {
         if(garageService.getView().isItemInDepot(this.item))
         {
            if(resistancesService.isMounted(this.item))
            {
               this.onButtonUpgradeClickInternal();
            }
            else
            {
               this.onButtonEquipClickInternal();
            }
         }
         else
         {
            this.onButtonBuyClickInternal();
         }
      }
      
      private function updateBuyButton(param1:IGameObject) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:IGameObject = null;
         var _loc6_:int = 0;
         var _loc2_:* = itemService.canBuy(param1);
         if(this.buyButton.visible)
         {
            _loc3_ = ItemInfoPanel.getRequiredRank(itemService.getMinRankIndex(param1),itemService.getMaxRankIndex(param1));
            if(!_loc2_)
            {
               _loc5_ = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
               _loc4_ = int(itemService.getPrice(_loc5_));
               _loc6_ = int(itemService.getMinRankIndex(_loc5_));
               _loc3_ = userPropertiesService.rank >= _loc6_ ? _loc6_ : int(-_loc6_);
            }
            else
            {
               _loc4_ = int(itemService.getPrice(param1));
            }
            this.updateBuyButtonText(param1,_loc2_);
            this.buyButton.setInfo(_loc4_,1,_loc3_,itemService.isPremiumItem(param1));
         }
      }
      
      private function updateBuyButtonText(param1:IGameObject, param2:Boolean) : void
      {
         var _loc4_:IGameObject = null;
         var _loc3_:String = localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_BUY_TEXT);
         if(itemService.isModificationItem(param1))
         {
            if(param2)
            {
               _loc4_ = itemService.getMaxAvailableModification(param1);
               if(_loc4_ == null)
               {
                  _loc4_ = param1;
               }
            }
            else
            {
               _loc4_ = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
            }
            this.buyButton.setText(_loc3_ + " M" + itemService.getModificationIndex(_loc4_));
         }
         else
         {
            this.buyButton.setText(_loc3_);
         }
      }
      
      public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher, param3:IGameObject) : void
      {
         this.item = param3;
         if(Boolean(itemService.canBuy(param3)) || !resistancesService.canBeMount(param3))
         {
            resistancesService.setOnlyUnmountMode();
         }
         else
         {
            this.setActive();
         }
         this.garageWindowDispatcher = param2;
         param1.addChild(this.buyButton);
         param1.addChild(this.equipButton);
         param1.addChild(this.upgradeButton);
         this.updateButtons();
      }
      
      private function onButtonBuyClickInternal() : void
      {
         var _loc1_:IGameObject = garageService.getView().isItemInDepot(this.item) ? itemService.getMaxAvailableModification(this.item) : this.item;
         garageService.getView().dispatchEvent(new GarageWindowEvent(GarageWindowEvent.BUY_ITEM,_loc1_));
      }
      
      private function onButtonBuyClick(param1:MouseEvent) : void
      {
         this.onButtonBuyClickInternal();
      }
      
      private function onButtonUpgradeClickInternal() : void
      {
         garageService.getView().getItemInfoPanel().upgradeSelectedItem();
      }
      
      private function onButtonUpgradeClick(param1:MouseEvent) : void
      {
         this.onButtonUpgradeClickInternal();
      }
      
      private function onButtonEquipClickInternal() : void
      {
         if(this.isItemMounted())
         {
            resistancesService.unmount(this.item);
         }
         else
         {
            resistancesService.mountIntoFreeSlot(this.item);
         }
         this.updateButtonsLabels();
      }
      
      private function onButtonEquipClick(param1:MouseEvent) : void
      {
         this.onButtonEquipClickInternal();
      }
      
      private function isItemMounted() : Boolean
      {
         return resistancesService.isMounted(this.item);
      }
      
      private function updateButtons() : void
      {
         this.updateButtonsVisibility();
         this.updateButtonsLabels();
         this.updateEquipButton();
      }
      
      private function updateEquipButton() : void
      {
         if(!itemService.hasItem(this.item))
         {
            this.equipButton.enabled = false;
            this.equipButton.hideTime();
            return;
         }
         this.controlTimerEquipButton();
      }
      
      private function updateButtonsLabels() : void
      {
         this.updateBuyButton(this.item);
         var _loc1_:UpgradableItem = UpgradableItem(this.item.adapt(UpgradableItem));
         if(_loc1_.isUpgrading())
         {
            this.upgradeButton.setUpgradingButton(_loc1_.getCountDownTimer(),_loc1_.hasSpeedUpDiscount());
         }
         else if(itemService.isFullUpgraded(this.item))
         {
            this.upgradeButton.setUpgradedButton();
         }
         else
         {
            this.upgradeButton.setUpgradeButton(_loc1_.hasUpgradeDiscount());
         }
         this.equipButton.label = this.isItemMounted() ? localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_UNEQUIP_TEXT) : localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_EQUIP_TEXT);
      }
      
      private function controlTimerEquipButton() : void
      {
         var _loc1_:CountDownTimer = null;
         if(lobbyLayoutService.inBattle())
         {
            if(battleInfoService.reArmorEnabled)
            {
               _loc1_ = delayMountCategoryService.getDownTimer(this.item);
               if(_loc1_.getRemainingSeconds() > 0)
               {
                  this.equipButton.startTimer(_loc1_);
                  this.equipButton.addEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
                  resistancesService.getView().disable();
               }
               else
               {
                  this.setActive();
               }
            }
            else
            {
               this.equipButton.hideTime();
               this.equipButton.enabled = false;
               resistancesService.getView().disable();
            }
         }
         else
         {
            this.setActive();
         }
      }
      
      private function setActive() : void
      {
         this.equipButton.hideTime();
         this.equipButton.enabled = true;
         resistancesService.getView().enable();
      }
      
      private function onCompletedTimer(param1:TimerButtonEvent) : void
      {
         this.equipButton.enabled = true;
         this.equipButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
         resistancesService.getView().enable();
      }
      
      public function close() : void
      {
         this.buyButton.removeEventListener(MouseEvent.CLICK,this.onButtonBuyClick);
         this.upgradeButton.removeEventListener(MouseEvent.CLICK,this.onButtonUpgradeClick);
         this.equipButton.removeEventListener(MouseEvent.CLICK,this.onButtonEquipClick);
         this.equipButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
         this.equipButton.hideTime();
         if(this.selectWindow != null)
         {
            this.selectWindow.destroy();
            this.selectWindow = null;
         }
      }
   }
}

