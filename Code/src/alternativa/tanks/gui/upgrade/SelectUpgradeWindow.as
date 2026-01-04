package alternativa.tanks.gui.upgrade
{
   import alternativa.tanks.gui.crystalbutton.CrystalButton;
   import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
   import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
   import alternativa.tanks.service.money.IMoneyService;
   import controls.TankWindowInner;
   import controls.buttons.h50px.GreyBigButtonSkin;
   import controls.buttons.skins.GoldBigButtonSkin;
   import controls.timer.CountDownTimer;
   import controls.timer.CountDownTimerOnTick;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   
   public class SelectUpgradeWindow extends UpgradeWindowBase implements CountDownTimerOnTick
   {
      
      [Inject] // added
      public static var moneyService:IMoneyService;
      
      [Inject] // added
      public static var propertyService:ItemPropertyParamsService;
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      private static const BUTTON_WIDTH:int = 136;
      
      private static const VERTICAL_MARGIN:int = 7;
      
      private static const UPGRADE_TIMEOUT_MS:int = 750;
      
      private var inner:TankWindowInner;
      
      private var properties:Vector.<UpgradableItemPropertyValue>;
      
      private var infos:Vector.<UpgradeInfoForm>;
      
      private var timer:CountDownTimer;
      
      private var upgradableItemParams:UpgradableItemParams;
      
      private var progress:UpgradeProgressForm;
      
      private var okButton:CrystalButton;
      
      public function SelectUpgradeWindow(param1:UpgradableItemParams)
      {
         var _loc5_:UpgradeInfoForm = null;
         this.okButton = new CrystalButton();
         this.upgradableItemParams = param1;
         this.properties = this.getUpgradableProperties(param1.properties);
         super(465,39 * this.properties.length + 152);
         this.inner = new TankWindowInner(440,39 * this.properties.length + 12,TankWindowInner.GREEN);
         this.inner.x = 12;
         this.inner.y = 13;
         addChild(this.inner);
         this.infos = new Vector.<UpgradeInfoForm>(this.properties.length);
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.properties.length)
         {
            _loc5_ = new UpgradeInfoForm(param1,this.properties[_loc4_]);
            _loc2_ = Math.max(_loc2_,_loc5_.getValueMaxWidth());
            _loc3_ = Math.max(_loc3_,_loc5_.getPropertyNameWidth());
            this.infos[_loc4_] = _loc5_;
            _loc5_.y = 39 * _loc4_ + 12;
            this.inner.addChild(_loc5_);
            _loc4_++;
         }
         this.infos[0].align(_loc3_,_loc2_);
         if(!param1.isFullUpgraded())
         {
            _loc3_ += Math.max(375 - this.infos[0].getWidth(),0);
         }
         else
         {
            _loc3_ += Math.max(200 - this.infos[0].getWidth(),0);
         }
         for each(_loc5_ in this.infos)
         {
            _loc5_.align(_loc3_,_loc2_);
         }
         this.progress = new UpgradeProgressForm(param1);
         this.progress.x = 12;
         this.progress.y = this.inner.y + this.inner.height + VERTICAL_MARGIN;
         addChild(this.progress);
         this.okButton.width = BUTTON_WIDTH;
         this.okButton.addEventListener(MouseEvent.CLICK,this.onClick);
         this.okButton.y = this.progress.y + this.progress.height + VERTICAL_MARGIN;
         addChild(this.okButton);
         lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.endSwitch);
         this.updateWidth();
         this.update();
      }
      
      private function getUpgradableProperties(param1:Vector.<UpgradableItemPropertyValue>) : Vector.<UpgradableItemPropertyValue>
      {
         var _loc2_:Vector.<UpgradableItemPropertyValue> = new Vector.<UpgradableItemPropertyValue>();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_].isUpgradable() || param1[_loc3_].isVisibleInInfo())
            {
               _loc2_.push(param1[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function updateWidth() : void
      {
         var _loc1_:int = Math.max(200,this.infos[0].getWidth());
         this.inner.width = _loc1_;
         this.progress.width = _loc1_;
         width = _loc1_ + 25;
      }
      
      private function update() : void
      {
         var _loc1_:UpgradeInfoForm = null;
         if(this.upgradableItemParams.isFullUpgraded())
         {
            removeChild(this.okButton);
            this.okButton.removeEventListener(MouseEvent.CLICK,this.onClick);
            this.okButton = null;
            height = this.progress.y + this.progress.height + VERTICAL_MARGIN * 2 + cancelButton.height + 5;
            this.updateWidth();
         }
         else
         {
            this.okButton.x = width - this.okButton.width >> 1;
            if(this.upgradableItemParams.isUpgrading())
            {
               this.setTimer(this.upgradableItemParams.timer);
            }
            this.updateCrystalButton();
         }
         this.progress.update();
         for each(_loc1_ in this.infos)
         {
            _loc1_.updateForm();
         }
         dialogService.centerDialog(this);
      }
      
      public function openDialog() : void
      {
         dialogService.addDialog(this);
      }
      
      private function setTimer(param1:CountDownTimer) : void
      {
         this.removeTimer();
         this.timer = param1;
         this.progress.setTimer(param1);
         param1.addListener(CountDownTimerOnTick,this);
      }
      
      private function removeTimer() : void
      {
         if(this.timer != null)
         {
            this.timer.removeListener(CountDownTimerOnTick,this);
            this.timer = null;
         }
      }
      
      private function endSwitch(param1:LobbyLayoutServiceEvent) : void
      {
         this.updateCrystalButton();
      }
      
      private function updateCrystalButton() : void
      {
         if(this.upgradableItemParams.isUpgrading())
         {
            this.okButton.setText(localeService.getText(TanksLocale.TEXT_GARAGE_SPEED_UP_TEXT));
            this.okButton.setSkin(GoldBigButtonSkin.GOLD_SKIN);
            this.okButton.setCost(this.upgradableItemParams.getSpeedUpPrice());
            this.okButton.setSale(this.upgradableItemParams.hasSpeedUpDiscount());
         }
         else
         {
            this.okButton.setText(localeService.getText(TanksLocale.TEXT_GARAGE_UPGRADE_TEXT));
            this.okButton.setSkin(GreyBigButtonSkin.GREY_SKIN);
            this.okButton.setCost(this.upgradableItemParams.getStartUpgradePrice());
            this.okButton.setSale(this.upgradableItemParams.hasUpgradeDiscount());
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(this.upgradableItemParams.isUpgrading())
         {
            this.speedUp();
            return;
         }
         this.startUpgrade();
      }
      
      private function speedUp() : void
      {
         var _loc2_:CountDownTimer = null;
         var _loc1_:int = int(this.okButton.getPrice());
         if(moneyService.checkEnough(_loc1_))
         {
            this.okButton.enabled = false;
            _loc2_ = this.timer;
            this.removeTimer();
            dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.SPEED_UP,_loc2_,_loc1_));
         }
         else
         {
            dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.FLUSH_UPGRADES));
         }
      }
      
      override protected function onClose() : void
      {
         this.removeEvents();
         dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.FLUSH_UPGRADES));
         dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.SELECT_WINDOW_CLOSED));
         dialogService.removeDialog(this);
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.endSwitch);
         if(Boolean(this.okButton))
         {
            this.okButton.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         this.removeTimer();
      }
      
      private function startUpgrade() : void
      {
         var _loc2_:CountDownTimer = null;
         var _loc1_:int = int(this.okButton.getPrice());
         if(moneyService.checkEnough(_loc1_))
         {
            _loc2_ = new CountDownTimer();
            _loc2_.start(this.upgradableItemParams.getTimeInSeconds() * 1000 + getTimer());
            this.setTimer(_loc2_);
            this.okButton.enabled = false;
            setTimeout(this.enableOkButton,UPGRADE_TIMEOUT_MS);
            dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.UPGRADE_STARTED,_loc2_,_loc1_));
            this.updateCrystalButton();
         }
         else
         {
            dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.FLUSH_UPGRADES));
         }
      }
      
      private function enableOkButton() : void
      {
         if(Boolean(this.okButton))
         {
            this.updateCrystalButton();
            this.okButton.enabled = true;
         }
      }
      
      public function itemUpgraded() : void
      {
         this.removeTimer();
         this.update();
         setTimeout(this.enableOkButton,UPGRADE_TIMEOUT_MS);
      }
      
      public function destroy() : void
      {
         this.removeEvents();
         dialogService.removeDialog(this);
      }
      
      public function onTick(param1:CountDownTimer) : void
      {
         this.okButton.setCost(this.upgradableItemParams.getSpeedUpPrice());
      }
   }
}

