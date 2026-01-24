package alternativa.tanks.gui.dailyquests.window
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.dailyquests.window.events.DailyQuestChangeEvent;
   import alternativa.tanks.gui.dailyquests.window.events.DailyQuestWindowCloseEvent;
   import alternativa.tanks.service.dailyquest.DailyQuestNotifierService;
   import alternativa.tanks.service.money.IMoneyService;
   import alternativa.types.Long;
   import controls.base.DefaultButtonBase;
   import controls.base.LabelBase;
   import controls.timer.CountDownTimer;
   import controls.timer.CountDownTimerOnCompleteAfter;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import forms.TankWindowWithHeader;
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   import projects.tanks.client.panel.model.weeklyquest.profile.WeeklyQuestDescription;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
   
   public class QuestWindow extends DialogWindow implements CountDownTimerOnCompleteAfter
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var moneyService:IMoneyService;
      
      [Inject] // added
      public static var dailyQuestNotifierService:DailyQuestNotifierService;
      
      [Inject] // added
      public static var userChangeGameScreenService:UserChangeGameScreenService;
      
      public static const DAILY_QUEST_ITEM_VIEW_WIDTH:int = 280;
      
      public static const DAILY_QUEST_ITEM_VIEW_WIDTH_NO_QUESTS:int = 310;
      
      public static const WINDOW_MARGIN:int = 11;
      
      private const BOTTOM_WINDOW_MARGIN:int = 13;
      
      private const CHANGE_DELAY_IN_MILLISECONDS:int = 1000;
      
      private var window:TankWindowWithHeader;
      
      private var closeButton:DefaultButtonBase;
      
      private var itemViews:Vector.<DailyQuestItemView> = new Vector.<DailyQuestItemView>();
      
      private var infoLink:LabelBase;
      
      private var weeklyQuestPanel:WeeklyQuestInfoPanel;
      
      private var changeButtonDelayTimer:CountDownTimer;
      
      private var changedQuestLoaded:Boolean;
      
      private var changeButtonDelayTimerIsRunning:Boolean;
      
      public function QuestWindow()
      {
         super();
         this.addWindow();
         this.addWeeklyPanel();
         this.addCloseButton();
         this.addInfoLink();
      }
      
      private function addWeeklyPanel() : void
      {
         this.weeklyQuestPanel = new WeeklyQuestInfoPanel();
         this.weeklyQuestPanel.x = WINDOW_MARGIN;
         this.weeklyQuestPanel.y = WINDOW_MARGIN;
         addChild(this.weeklyQuestPanel);
      }
      
      private function addWindow() : void
      {
         this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_MISSIONS,DAILY_QUEST_ITEM_VIEW_WIDTH + WINDOW_MARGIN * 2,0);
         addChild(this.window);
      }
      
      private function addCloseButton() : void
      {
         this.closeButton = new DefaultButtonBase();
         this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
         this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
         this.window.addChild(this.closeButton);
      }
      
      private function addInfoLink() : void
      {
         this.infoLink = new LabelBase();
         this.infoLink.htmlText = "";//localeService.getText(TanksLocale.TEXT_WEEKLY_QUEST_HINT);
         this.window.addChild(this.infoLink);
      }
      
      public function init(param1:Vector.<DailyQuestInfo>) : void
      {
         dailyQuestNotifierService.hideNotification();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.addDailyQuestItemView(param1[_loc2_],_loc2_);
            _loc2_++;
         }
         this.redrawDailyQuests();
      }
      
      private function addDailyQuestItemView(param1:DailyQuestInfo, param2:int) : void
      {
         var _loc3_:DailyQuestItemView = new DailyQuestItemView(param1);
         _loc3_.addEventListener(DailyQuestChangeEvent.DAILY_QUEST_CHANGE,this.onDailyQuestChange);
         _loc3_.x = DAILY_QUEST_ITEM_VIEW_WIDTH * param2 + WINDOW_MARGIN + int(WINDOW_MARGIN / 2) * param2;
         _loc3_.y = WINDOW_MARGIN + WeeklyQuestInfoPanel.HEIGHT + WINDOW_MARGIN;
         this.itemViews.push(_loc3_);
         this.window.addChild(_loc3_);
      }
      
      private function onDailyQuestChange(param1:DailyQuestChangeEvent) : void
      {
         if(Boolean(param1.dailyQuestInfo.canSkipForFree) || Boolean(moneyService.checkEnough(param1.dailyQuestInfo.skipCost)))
         {
            this.changedQuestLoaded = false;
            this.lockChangeButtonsForTime();
         }
         else
         {
            this.onCloseButtonClick();
         }
      }
      
      private function lockChangeButtonsForTime() : void
      {
         this.lockChangeButtons();
         this.createAndStartChangeButtonDelayTimer();
      }
      
      private function createAndStartChangeButtonDelayTimer() : void
      {
         this.changeButtonDelayTimer = new CountDownTimer();
         this.changeButtonDelayTimer.addListener(CountDownTimerOnCompleteAfter,this);
         this.changeButtonDelayTimer.start(getTimer() + this.CHANGE_DELAY_IN_MILLISECONDS);
         this.changeButtonDelayTimerIsRunning = true;
      }
      
      private function lockChangeButtons() : void
      {
         var _loc1_:DailyQuestItemView = null;
         for each(_loc1_ in this.itemViews)
         {
            if(_loc1_.actionButtonIsChangeButton())
            {
               _loc1_.lockActionButton();
            }
         }
      }
      
      public function updateWhenQuestChanged(param1:Long, param2:DailyQuestInfo) : void
      {
         var _loc3_:DailyQuestItemView = null;
         for each(_loc3_ in this.itemViews)
         {
            if(_loc3_.getQuestId() == param1)
            {
               _loc3_.updateItemViewWhenQuestChanged(param2);
            }
            if(_loc3_.actionButtonIsChangeButton())
            {
               _loc3_.updateChangeCost(param2.skipCost);
            }
         }
         this.redrawDailyQuests();
         this.changedQuestLoaded = true;
         if(!this.changeButtonDelayTimerIsRunning)
         {
            this.unlockChangeButtons();
         }
      }
      
      private function redrawDailyQuests() : void
      {
         var _loc1_:int = this.calculateMaxItemViewHeight();
         this.redrawItemViewsWithNewHeight(_loc1_);
         this.updateWindowWidth();
         this.updateElementsParameters(_loc1_);
      }
      
      private function updateWindowWidth() : void
      {
         var _loc1_:uint = this.itemViews.length;
         this.window.width = _loc1_ * DAILY_QUEST_ITEM_VIEW_WIDTH + WINDOW_MARGIN * 2 + int(WINDOW_MARGIN / 2) * (_loc1_ - 1);
         this.updateElementsXPositions();
      }
      
      private function updateElementsXPositions() : void
      {
         this.closeButton.x = int(this.window.width - this.closeButton.width - WINDOW_MARGIN);
         this.infoLink.x = WINDOW_MARGIN;
      }
      
      private function calculateMaxItemViewHeight() : int
      {
         var _loc2_:DailyQuestItemView = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.itemViews)
         {
            _loc1_ = Math.max(_loc1_,_loc2_.getHeight());
         }
         return _loc1_;
      }
      
      private function redrawItemViewsWithNewHeight(param1:int) : void
      {
         var _loc2_:DailyQuestItemView = null;
         for each(_loc2_ in this.itemViews)
         {
            _loc2_.updateWithNewHeight(param1);
         }
      }
      
      public function initWithoutQuests() : void
      {
         this.window.width = DAILY_QUEST_ITEM_VIEW_WIDTH_NO_QUESTS + WINDOW_MARGIN * 2;
         this.updateElementsXPositions();
         var _loc1_:DailyQuestEmptyItemView = new DailyQuestEmptyItemView();
         _loc1_.x = WINDOW_MARGIN;
         _loc1_.y = WINDOW_MARGIN + WeeklyQuestInfoPanel.HEIGHT + WINDOW_MARGIN;
         this.window.addChild(_loc1_);
         this.updateElementsParameters(_loc1_.getHeight());
         this.weeklyQuestPanel.redraw(this.window.width - 2 * WINDOW_MARGIN);
      }
      
      public function initWeeklyQuest(param1:WeeklyQuestDescription) : void
      {
         this.weeklyQuestPanel.init(param1);
         this.weeklyQuestPanel.redraw(this.window.width - 2 * WINDOW_MARGIN);
      }
      
      private function updateElementsParameters(param1:int) : void
      {
         this.window.height = this.BOTTOM_WINDOW_MARGIN + this.closeButton.height + WINDOW_MARGIN + param1 + WINDOW_MARGIN + WeeklyQuestInfoPanel.HEIGHT + WINDOW_MARGIN;
         this.closeButton.y = int(this.window.height - this.closeButton.height - WINDOW_MARGIN);
         this.infoLink.y = int(this.window.height - this.infoLink.height - WINDOW_MARGIN);
      }
      
      public function show() : void
      {
         dialogService.enqueueDialog(this);
      }
      
      public function takePrize(param1:Long) : void
      {
         this.removeCompletedDailyQuestItemView(param1);
         if(this.itemViews.length > 0)
         {
            this.updateItemViewsPosition();
            this.redrawDailyQuests();
         }
         else
         {
            this.initWithoutQuests();
         }
         this.weeklyQuestPanel.showQuestDoneForToday(this.window.width - 2 * WINDOW_MARGIN);
         dialogService.centerDialog(this);
      }
      
      private function removeCompletedDailyQuestItemView(param1:Long) : void
      {
         var _loc2_:DailyQuestItemView = null;
         for each(_loc2_ in this.itemViews)
         {
            if(_loc2_.getQuestId() == param1)
            {
               this.removeItemViewListeners(_loc2_);
               this.window.removeChild(_loc2_);
               this.itemViews.splice(this.itemViews.indexOf(_loc2_),1);
               break;
            }
         }
      }
      
      private function updateItemViewsPosition() : void
      {
         var _loc2_:DailyQuestItemView = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.itemViews.length)
         {
            _loc2_ = this.itemViews[_loc1_];
            _loc2_.x = DAILY_QUEST_ITEM_VIEW_WIDTH * _loc1_ + WINDOW_MARGIN + int(WINDOW_MARGIN / 2) * _loc1_;
            _loc1_++;
         }
      }
      
      private function onCloseButtonClick(param1:MouseEvent = null) : void
      {
         this.removeListeners();
         this.removeChangeButtonDelayTimer();
         dispatchEvent(new DailyQuestWindowCloseEvent(DailyQuestWindowCloseEvent.DAILY_QUEST_WINDOW_CLOSE));
         userChangeGameScreenService.questWindowClosed();
         dialogService.removeDialog(this);
      }
      
      private function removeListeners() : void
      {
         var _loc1_:DailyQuestItemView = null;
         this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
         for each(_loc1_ in this.itemViews)
         {
            this.removeItemViewListeners(_loc1_);
         }
      }
      
      private function removeItemViewListeners(param1:DailyQuestItemView) : void
      {
         param1.removeEventListener(DailyQuestChangeEvent.DAILY_QUEST_CHANGE,this.onDailyQuestChange);
         if(param1.actionButtonIsChangeButton())
         {
            param1.removeChangeButtonListeners();
         }
      }
      
      override protected function cancelKeyPressed() : void
      {
         this.onCloseButtonClick();
      }
      
      override protected function confirmationKeyPressed() : void
      {
         this.onCloseButtonClick();
      }
      
      public function onCompleteAfter(param1:CountDownTimer, param2:Boolean) : void
      {
         this.removeChangeButtonDelayTimer();
         if(this.changedQuestLoaded)
         {
            this.unlockChangeButtons();
         }
      }
      
      private function removeChangeButtonDelayTimer() : void
      {
         if(this.changeButtonDelayTimer != null)
         {
            this.changeButtonDelayTimer.removeListener(CountDownTimerOnCompleteAfter,this);
            this.changeButtonDelayTimer.destroy();
            this.changeButtonDelayTimerIsRunning = false;
         }
      }
      
      private function unlockChangeButtons() : void
      {
         var _loc1_:DailyQuestItemView = null;
         for each(_loc1_ in this.itemViews)
         {
            if(_loc1_.actionButtonIsChangeButton())
            {
               _loc1_.unlockActionButton();
            }
         }
      }
      
      override public function get width() : Number
      {
         return this.window.width;
      }
   }
}

