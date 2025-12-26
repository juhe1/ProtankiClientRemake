package alternativa.tanks.gui.dailyquests
{
   import alternativa.tanks.service.dailyquest.DailyQuestNotificationEvent;
   import alternativa.tanks.service.dailyquest.DailyQuestNotifierService;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class DailyQuestChangesIndicator extends Sprite
   {
      
      [Inject]
      public static var dailyQuestInfoService:DailyQuestNotifierService;
      
      private static var dailyQuestsChangesIconClass:Class = DailyQuestChangesIndicator_dailyQuestsChangesIconClass;
      
      private static var dailyQuestsChangesIconBitmapData:BitmapData = Bitmap(new dailyQuestsChangesIconClass()).bitmapData;
      
      public function DailyQuestChangesIndicator()
      {
         super();
         var _loc1_:Bitmap = new Bitmap(dailyQuestsChangesIconBitmapData);
         addChild(_loc1_);
         visible = false;
         dailyQuestInfoService.addEventListener(DailyQuestNotificationEvent.SHOW_NOTIFICATION,this.onDailyQuestCompleted);
         dailyQuestInfoService.addEventListener(DailyQuestNotificationEvent.HIDE_NOTIFICATION,this.onDailyQuestChangesViewed);
      }
      
      private function onDailyQuestChangesViewed(param1:DailyQuestNotificationEvent) : void
      {
         visible = false;
      }
      
      private function onDailyQuestCompleted(param1:DailyQuestNotificationEvent) : void
      {
         visible = true;
      }
   }
}

