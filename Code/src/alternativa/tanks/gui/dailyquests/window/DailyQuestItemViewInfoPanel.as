package alternativa.tanks.gui.dailyquests.window
{
   import alternativa.osgi.service.locale.ILocaleService;
   import controls.base.LabelBase;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormatAlign;
   import projects.tanks.client.panel.model.dailyquest.DailyQuestPrizeInfo;
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class DailyQuestItemViewInfoPanel extends Sprite
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private var dailyQuestPanelTopLeftCorner:Bitmap;
      
      private var dailyQuestPanelTopCenterLine:Bitmap;
      
      private var dailyQuestPanelTopRightCorner:Bitmap;
      
      private var dailyQuestPanelBottomLeftCorner:Bitmap;
      
      private var dailyQuestPanelBottomCenterLine:Bitmap;
      
      private var dailyQuestPanelBottomRightCorner:Bitmap;
      
      private var dailyQuestPanelLeftLine:Bitmap;
      
      private var dailyQuestPanelRightLine:Bitmap;
      
      private var dailyQuestPanelBackground:Bitmap;
      
      private var dailyQuestInfo:DailyQuestInfo;
      
      private var _width:int;
      
      private var _height:int;
      
      private var goalLabel:LabelBase;
      
      private var progressLabel:LabelBase;
      
      private var goalHeaderLabel:LabelBase;
      
      private var prizeHeaderLabel:LabelBase;
      
      private var prizesContainer:Vector.<LabelBase>;
      
      private const TEXT_LEFT_MARGIN:int = 5;
      
      private const HEADER_TOP_MARGIN:int = 4;
      
      private const TEXT_VERTICAL_MARGIN:int = 14;
      
      private const TEXT_RIGHT_MARGIN:int = 9;
      
      private const PRIZE_BLOCK_TOP_MARGIN:int = 50;
      
      private const PRIZE_ITEM_HEIGHT:int = 14;
      
      private const PRIZE_BOTTOM_MARGIN:int = 8;
      
      private const PANEL_PADDING:int = 10;
      
      private const HEADER_COLOR:uint = 5898034;
      
      private const TEXT_COLOR:uint = 16777215;
      
      public function DailyQuestItemViewInfoPanel(param1:DailyQuestInfo)
      {
         super();
         this.dailyQuestInfo = param1;
         this._width = QuestWindow.DAILY_QUEST_ITEM_VIEW_WIDTH - this.PANEL_PADDING * 2;
         this._height = this.getHeight();
         this.prizesContainer = new Vector.<LabelBase>();
         this.drawTopLine();
         this.drawBottomLine();
         this.drawLeftLine();
         this.drawRightLine();
         this.drawBackground();
         this.addGoalBlock();
         this.addPrizeBlock();
      }
      
      private function drawTopLine() : void
      {
         this.dailyQuestPanelTopLeftCorner = new Bitmap(DailyQuestItemViewBitmaps.LEFT_TOP_CORNER_BITMAP_DATA);
         addChild(this.dailyQuestPanelTopLeftCorner);
         this.dailyQuestPanelTopCenterLine = new Bitmap(DailyQuestItemViewBitmaps.TOP_LINE_BITMAP_DATA);
         addChild(this.dailyQuestPanelTopCenterLine);
         this.dailyQuestPanelTopRightCorner = new Bitmap(DailyQuestItemViewBitmaps.RIGHT_TOP_CORNER_BITMAP_DATA);
         addChild(this.dailyQuestPanelTopRightCorner);
         this.dailyQuestPanelTopCenterLine.x = this.dailyQuestPanelTopLeftCorner.width;
         this.dailyQuestPanelTopRightCorner.x = this._width - this.dailyQuestPanelTopRightCorner.width;
         this.dailyQuestPanelTopCenterLine.width = this.dailyQuestPanelTopRightCorner.x - this.dailyQuestPanelTopCenterLine.x;
      }
      
      private function drawBottomLine() : void
      {
         this.dailyQuestPanelBottomLeftCorner = new Bitmap(DailyQuestItemViewBitmaps.LEFT_BOTTOM_CORNER_BITMAP_DATA);
         this.dailyQuestPanelBottomLeftCorner.y = this._height - this.dailyQuestPanelBottomLeftCorner.height;
         addChild(this.dailyQuestPanelBottomLeftCorner);
         this.dailyQuestPanelBottomCenterLine = new Bitmap(DailyQuestItemViewBitmaps.BOTTOM_LINE_BITMAP_DATA);
         this.dailyQuestPanelBottomCenterLine.y = this.dailyQuestPanelBottomLeftCorner.y;
         this.dailyQuestPanelBottomCenterLine.x = this.dailyQuestPanelBottomLeftCorner.width;
         this.dailyQuestPanelBottomCenterLine.width = this.dailyQuestPanelTopCenterLine.width;
         addChild(this.dailyQuestPanelBottomCenterLine);
         this.dailyQuestPanelBottomRightCorner = new Bitmap(DailyQuestItemViewBitmaps.RIGHT_BOTTOM_CORNER_BITMAP_DATA);
         this.dailyQuestPanelBottomRightCorner.y = this.dailyQuestPanelBottomLeftCorner.y;
         this.dailyQuestPanelBottomRightCorner.x = this.dailyQuestPanelTopRightCorner.x;
         addChild(this.dailyQuestPanelBottomRightCorner);
      }
      
      private function drawLeftLine() : void
      {
         this.dailyQuestPanelLeftLine = new Bitmap(DailyQuestItemViewBitmaps.LEFT_LINE_BITMAP_DATA);
         this.dailyQuestPanelLeftLine.y = this.dailyQuestPanelTopLeftCorner.height;
         this.dailyQuestPanelLeftLine.height = this._height - this.dailyQuestPanelTopLeftCorner.height - this.dailyQuestPanelBottomLeftCorner.height;
         addChild(this.dailyQuestPanelLeftLine);
      }
      
      private function drawRightLine() : void
      {
         this.dailyQuestPanelRightLine = new Bitmap(DailyQuestItemViewBitmaps.RIGHT_LINE_BITMAP_DATA);
         this.dailyQuestPanelRightLine.y = this.dailyQuestPanelLeftLine.y;
         this.dailyQuestPanelRightLine.x = this.dailyQuestPanelBottomRightCorner.x;
         this.dailyQuestPanelRightLine.height = this.dailyQuestPanelLeftLine.height;
         addChild(this.dailyQuestPanelRightLine);
      }
      
      private function drawBackground() : void
      {
         this.dailyQuestPanelBackground = new Bitmap(DailyQuestItemViewBitmaps.BACKGROUND_PIXEL_BITMAP_DATA);
         this.dailyQuestPanelBackground.y = this.dailyQuestPanelTopLeftCorner.height + this.dailyQuestPanelTopLeftCorner.y;
         this.dailyQuestPanelBackground.x = this.dailyQuestPanelTopLeftCorner.width;
         this.dailyQuestPanelBackground.height = this._height - this.dailyQuestPanelBottomLeftCorner.height - this.dailyQuestPanelTopLeftCorner.height;
         this.dailyQuestPanelBackground.width = this._width - this.dailyQuestPanelTopLeftCorner.width - this.dailyQuestPanelTopRightCorner.width;
         addChild(this.dailyQuestPanelBackground);
      }
      
      private function addGoalBlock() : void
      {
         this.addGoalHeaderLabel();
         this.addProgressLabel();
         this.addGoalLabel();
      }
      
      private function addGoalHeaderLabel() : void
      {
         this.goalHeaderLabel = new LabelBase();
         this.goalHeaderLabel.color = this.HEADER_COLOR;
         this.goalHeaderLabel.align = TextFormatAlign.LEFT;
         this.goalHeaderLabel.text = localeService.getText(TanksLocale.TEXT_DAILY_QUEST_GOAL);
         this.goalHeaderLabel.x = this.TEXT_LEFT_MARGIN;
         this.goalHeaderLabel.y = this.HEADER_TOP_MARGIN;
         addChild(this.goalHeaderLabel);
      }
      
      private function addProgressLabel() : void
      {
         this.progressLabel = new LabelBase();
         this.progressLabel.color = this.TEXT_COLOR;
         this.progressLabel.align = TextFormatAlign.LEFT;
         this.progressLabel.text = this.getProgressLabelText();
         this.progressLabel.x = this._width - this.TEXT_RIGHT_MARGIN - this.progressLabel.textWidth;
         this.progressLabel.y = this.goalHeaderLabel.y + this.TEXT_VERTICAL_MARGIN;
         addChild(this.progressLabel);
      }
      
      private function addGoalLabel() : void
      {
         this.goalLabel = new LabelBase();
         this.goalLabel.color = this.TEXT_COLOR;
         this.goalLabel.align = TextFormatAlign.LEFT;
         this.goalLabel.text = this.dailyQuestInfo.description;
         this.goalLabel.wordWrap = true;
         this.goalLabel.width = this.progressLabel.x - this.PANEL_PADDING;
         this.goalLabel.x = this.goalHeaderLabel.x;
         this.goalLabel.y = this.progressLabel.y;
         addChild(this.goalLabel);
      }
      
      private function getProgressLabelText() : String
      {
         return this.dailyQuestInfo.progress + "/" + this.dailyQuestInfo.finishCriteria;
      }
      
      private function addPrizeBlock() : void
      {
         this.prizeHeaderLabel = new LabelBase();
         this.prizeHeaderLabel.color = this.HEADER_COLOR;
         this.prizeHeaderLabel.align = TextFormatAlign.LEFT;
         this.prizeHeaderLabel.text = localeService.getText(TanksLocale.TEXT_DAILY_QUEST_PRIZE);
         this.prizeHeaderLabel.x = this.TEXT_LEFT_MARGIN;
         this.prizeHeaderLabel.y = this.PRIZE_BLOCK_TOP_MARGIN;
         addChild(this.prizeHeaderLabel);
         this.updatePrizesInfo();
      }
      
      public function updatePanel(param1:DailyQuestInfo) : void
      {
         this.dailyQuestInfo = param1;
         this.goalLabel.text = this.dailyQuestInfo.description;
         this.progressLabel.text = this.getProgressLabelText();
         this.progressLabel.x = this._width - this.TEXT_RIGHT_MARGIN - this.progressLabel.textWidth;
         this.updatePanelHeight(this.getHeight());
         this.removeAllPrizes();
         this.updatePrizesInfo();
      }
      
      public function updatePanelHeight(param1:int) : void
      {
         this.dailyQuestPanelBottomLeftCorner.y = param1 - this.dailyQuestPanelBottomLeftCorner.height;
         this.dailyQuestPanelBottomCenterLine.y = this.dailyQuestPanelBottomLeftCorner.y;
         this.dailyQuestPanelBottomRightCorner.y = this.dailyQuestPanelBottomLeftCorner.y;
         this.dailyQuestPanelLeftLine.height = param1 - this.dailyQuestPanelTopLeftCorner.height - this.dailyQuestPanelBottomLeftCorner.height;
         this.dailyQuestPanelRightLine.height = this.dailyQuestPanelLeftLine.height;
         this.dailyQuestPanelBackground.height = param1 - this.dailyQuestPanelBottomLeftCorner.height - this.dailyQuestPanelTopLeftCorner.height;
      }
      
      private function removeAllPrizes() : void
      {
         var _loc1_:LabelBase = null;
         for each(_loc1_ in this.prizesContainer)
         {
            removeChild(_loc1_);
         }
         this.prizesContainer.splice(0,this.prizesContainer.length);
      }
      
      private function updatePrizesInfo() : void
      {
         var _loc2_:DailyQuestPrizeInfo = null;
         var _loc3_:LabelBase = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.dailyQuestInfo.prizes.length)
         {
            _loc2_ = this.dailyQuestInfo.prizes[_loc1_];
            _loc3_ = new LabelBase();
            _loc3_.color = this.TEXT_COLOR;
            _loc3_.align = TextFormatAlign.LEFT;
            _loc3_.text = _loc2_.name + " × " + _loc2_.count;
            _loc3_.x = this.TEXT_LEFT_MARGIN;
            _loc3_.y = this.PRIZE_BLOCK_TOP_MARGIN + this.TEXT_VERTICAL_MARGIN + _loc1_ * this.PRIZE_ITEM_HEIGHT;
            addChild(_loc3_);
            this.prizesContainer.push(_loc3_);
            _loc1_++;
         }
      }
      
      public function getHeight() : int
      {
         return this.PRIZE_BLOCK_TOP_MARGIN + this.TEXT_VERTICAL_MARGIN + this.PRIZE_ITEM_HEIGHT * this.dailyQuestInfo.prizes.length + this.PRIZE_BOTTOM_MARGIN;
      }
   }
}

