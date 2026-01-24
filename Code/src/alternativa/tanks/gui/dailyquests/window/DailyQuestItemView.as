package alternativa.tanks.gui.dailyquests.window
{
   import alternativa.tanks.gui.dailyquests.window.buttons.DailyQuestChangeButton;
   import alternativa.tanks.gui.dailyquests.window.buttons.DailyQuestGetPrizeButton;
   import alternativa.tanks.gui.dailyquests.window.events.DailyQuestChangeEvent;
   import alternativa.tanks.gui.dailyquests.window.events.DailyQuestGetPrizeEvent;
   import alternativa.types.Long;
   import controls.TankWindowInner;
   import controls.base.ThreeLineBigButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   
   public class DailyQuestItemView extends Sprite
   {
      
      private const INNER_WINDOW_PADDING:int = 10;
      
      private const IMAGE_HEIGHT:int = 120;
      
      private const IMAGE_WIDTH:int = 280;
      
      private const ACTION_BUTTON_MARGIN:int = 4;
      
      private var innerWindow:TankWindowInner;
      
      private var dailyQuestInfoPanel:DailyQuestItemViewInfoPanel;
      
      private var dailyQuestImage:Bitmap;
      
      private var actionButton:ThreeLineBigButton;
      
      private var dailyQuestInfo:DailyQuestInfo;
      
      public function DailyQuestItemView(param1:DailyQuestInfo)
      {
         super();
         this.dailyQuestInfo = param1;
         this.addInnerWindow();
         this.addImage();
         this.addInfoPanel();
         this.updateInnerWindowHeight();
         this.addActionButton();
      }
      
      private function addInnerWindow() : void
      {
         this.innerWindow = new TankWindowInner(0,0,TankWindowInner.GREEN);
         this.innerWindow.width = QuestWindow.DAILY_QUEST_ITEM_VIEW_WIDTH;
         addChild(this.innerWindow);
      }
      
      private function addImage() : void
      {
         this.dailyQuestImage = new Bitmap();
         this.dailyQuestImage.x = int(this.innerWindow.width / 2 - this.IMAGE_WIDTH / 2);
         this.dailyQuestImage.y = this.INNER_WINDOW_PADDING;
         this.dailyQuestImage.bitmapData = this.dailyQuestInfo.image.data;
         this.innerWindow.addChild(this.dailyQuestImage);
      }
      
      private function addInfoPanel() : void
      {
         this.dailyQuestInfoPanel = new DailyQuestItemViewInfoPanel(this.dailyQuestInfo);
         this.dailyQuestInfoPanel.x = this.INNER_WINDOW_PADDING;
         this.dailyQuestInfoPanel.y = this.IMAGE_HEIGHT + this.INNER_WINDOW_PADDING * 2;
         this.innerWindow.addChild(this.dailyQuestInfoPanel);
      }
      
      private function addActionButton() : void
      {
         this.actionButton = this.createActionButton();
         addChild(this.actionButton);
         this.updateActionButtonPosition();
      }
      
      private function createActionButton() : ThreeLineBigButton
      {
         if(this.dailyQuestInfo.progress == this.dailyQuestInfo.finishCriteria)
         {
            return this.createGetPrizeButton();
         }
         return this.createChangeButton();
      }
      
      private function createChangeButton() : ThreeLineBigButton
      {
         var _loc1_:DailyQuestChangeButton = new DailyQuestChangeButton();
         _loc1_.addEventListener(MouseEvent.CLICK,this.onChangeButtonClick);
         if(this.dailyQuestInfo.canSkipForFree)
         {
            _loc1_.showButtonWithoutCrystals();
         }
         else
         {
            _loc1_.showButtonWithCrystals(this.dailyQuestInfo.skipCost);
         }
         return ThreeLineBigButton(_loc1_);
      }
      
      private function onChangeButtonClick(param1:MouseEvent) : void
      {
         dispatchEvent(new DailyQuestChangeEvent(DailyQuestChangeEvent.DAILY_QUEST_CHANGE,this.dailyQuestInfo));
      }
      
      private function createGetPrizeButton() : ThreeLineBigButton
      {
         var _loc1_:ThreeLineBigButton = new DailyQuestGetPrizeButton();
         _loc1_.addEventListener(MouseEvent.CLICK,this.onGetPrizeButtonClick);
         return _loc1_;
      }
      
      private function onGetPrizeButtonClick(param1:MouseEvent) : void
      {
         this.actionButton.removeEventListener(MouseEvent.CLICK,this.onGetPrizeButtonClick);
         dispatchEvent(new DailyQuestGetPrizeEvent(DailyQuestGetPrizeEvent.DAILY_QUEST_GET_PRIZE,this.dailyQuestInfo));
      }
      
      private function updateActionButtonPosition() : void
      {
         this.actionButton.x = int(QuestWindow.DAILY_QUEST_ITEM_VIEW_WIDTH / 2 - this.actionButton.width / 2);
         this.actionButton.y = this.innerWindow.height + QuestWindow.WINDOW_MARGIN - this.ACTION_BUTTON_MARGIN;
      }
      
      private function updateInnerWindowHeight() : void
      {
         this.innerWindow.height = this.dailyQuestInfoPanel.getHeight() + this.IMAGE_HEIGHT + this.INNER_WINDOW_PADDING * 3;
      }
      
      public function updateItemViewWhenQuestChanged(param1:DailyQuestInfo) : void
      {
         this.dailyQuestInfo = param1;
         this.dailyQuestImage.bitmapData = param1.image.data;
         this.dailyQuestInfoPanel.updatePanel(param1);
         this.updateInnerWindowHeight();
         this.updateActionButtonPosition();
      }
      
      public function updateWithNewHeight(param1:int) : void
      {
         this.innerWindow.height = param1 - (QuestWindow.WINDOW_MARGIN + this.actionButton.height);
         var _loc2_:int = param1 - this.calculateHeightWithoutInfoPanel();
         this.dailyQuestInfoPanel.updatePanelHeight(_loc2_);
         this.actionButton.y = param1 - this.actionButton.height - this.ACTION_BUTTON_MARGIN;
      }
      
      public function updateChangeCost(param1:int) : void
      {
         this.dailyQuestInfo.canSkipForFree = false;
         this.dailyQuestInfo.skipCost = param1;
         DailyQuestChangeButton(this.actionButton).showButtonWithCrystals(param1);
      }
      
      public function getHeight() : int
      {
         return this.dailyQuestInfoPanel.getHeight() + this.calculateHeightWithoutInfoPanel();
      }
      
      private function calculateHeightWithoutInfoPanel() : int
      {
         return this.IMAGE_HEIGHT + this.INNER_WINDOW_PADDING * 3 + QuestWindow.WINDOW_MARGIN + this.actionButton.height;
      }
      
      public function getQuestId() : Long
      {
         return this.dailyQuestInfo.questId;
      }
      
      public function removeChangeButtonListeners() : void
      {
         var _loc1_:DailyQuestChangeButton = DailyQuestChangeButton(this.actionButton);
         _loc1_.removeEventListener(MouseEvent.CLICK,this.onChangeButtonClick);
         _loc1_.removeListeners();
      }
      
      public function actionButtonIsChangeButton() : Boolean
      {
         return this.actionButton is DailyQuestChangeButton;
      }
      
      public function lockActionButton() : void
      {
         this.actionButton.enabled = false;
      }
      
      public function unlockActionButton() : void
      {
         this.actionButton.enabled = true;
      }
   }
}

