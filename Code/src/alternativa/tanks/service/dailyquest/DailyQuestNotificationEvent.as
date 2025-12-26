package alternativa.tanks.service.dailyquest
{
   import flash.events.Event;
   
   public class DailyQuestNotificationEvent extends Event
   {
      
      public static const SHOW_NOTIFICATION:String = "showNotification";
      
      public static const HIDE_NOTIFICATION:String = "hideNotification";
      
      public function DailyQuestNotificationEvent(param1:String)
      {
         super(param1,true);
      }
   }
}

