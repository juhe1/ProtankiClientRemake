package alternativa.tanks.gui.panel.buttons
{
   import alternativa.tanks.gui.dailyquests.DailyQuestChangesIndicator;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class DailyQuestsButton extends MainPanelSmallButton
   {
      
      private static const startIconClass:Class = DailyQuestsButton_startIconClass;
      
      private static const starIcon:BitmapData = Bitmap(new startIconClass()).bitmapData;
      
      private static const INDICATOR_X_OFFSET:int = 10;
      
      private static const INDICATOR_Y_OFFSET:int = -4;
      
      public function DailyQuestsButton()
      {
         super(starIcon,3,4);
         var _loc1_:DailyQuestChangesIndicator = new DailyQuestChangesIndicator();
         addChild(_loc1_);
         _loc1_.x = INDICATOR_X_OFFSET;
         _loc1_.y = INDICATOR_Y_OFFSET;
      }
   }
}

