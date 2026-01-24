package alternativa.tanks.gui.dailyquests.window
{
   import alternativa.osgi.service.locale.ILocaleService;
   import controls.TankWindowInner;
   import controls.base.LabelBase;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormatAlign;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class DailyQuestEmptyItemView extends Sprite
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private const TEXT_WHITE_COLOR:uint = 16777215;
      
      private const IMAGE_HEIGHT:int = 120;
      
      private const IMAGE_WIDTH:int = 280;
      
      private const INNER_WINDOW_PADDING:int = 10;
      
      private const BOTTOM_MARGIN:int = 5;
      
      private var innerWindow:TankWindowInner;
      
      private var noQuestsLabel:LabelBase;
      
      public function DailyQuestEmptyItemView()
      {
         super();
         this.addInnerWindow();
         this.addImage();
         this.addLabel();
         this.updateInnerWindowHeight();
      }
      
      private function addInnerWindow() : void
      {
         this.innerWindow = new TankWindowInner(0,0,TankWindowInner.GREEN);
         this.innerWindow.width = QuestWindow.DAILY_QUEST_ITEM_VIEW_WIDTH_NO_QUESTS;
         addChild(this.innerWindow);
      }
      
      private function addImage() : void
      {
         var _loc1_:Bitmap = new Bitmap();
         _loc1_.x = int(this.innerWindow.width / 2 - this.IMAGE_WIDTH / 2);
         _loc1_.y = this.INNER_WINDOW_PADDING;
         _loc1_.bitmapData = DailyQuestItemViewBitmaps.NO_QUESTS_BITMAP_DATA;
         this.innerWindow.addChild(_loc1_);
      }
      
      private function addLabel() : void
      {
         this.noQuestsLabel = new LabelBase();
         this.noQuestsLabel.color = this.TEXT_WHITE_COLOR;
         this.noQuestsLabel.align = TextFormatAlign.CENTER;
         this.noQuestsLabel.text = localeService.getText(TanksLocale.TEXT_DAILY_QUEST_COMPLETED);
         this.noQuestsLabel.x = int(QuestWindow.DAILY_QUEST_ITEM_VIEW_WIDTH_NO_QUESTS / 2 - this.noQuestsLabel.width / 2);
         this.noQuestsLabel.y = this.IMAGE_HEIGHT + this.INNER_WINDOW_PADDING * 2;
         this.innerWindow.addChild(this.noQuestsLabel);
      }
      
      private function updateInnerWindowHeight() : void
      {
         this.innerWindow.height = this.noQuestsLabel.height + this.IMAGE_HEIGHT + this.INNER_WINDOW_PADDING * 3;
      }
      
      public function getHeight() : int
      {
         return this.innerWindow.height + this.BOTTOM_MARGIN;
      }
   }
}

