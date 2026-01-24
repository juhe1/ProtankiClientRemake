package alternativa.tanks.gui.dailyquests.window.events
{
   import flash.events.Event;
   
   public class DailyQuestWindowCloseEvent extends Event
   {
      
      public static const DAILY_QUEST_WINDOW_CLOSE:String = "DailyQuestWindowClose";
      
      public function DailyQuestWindowCloseEvent(param1:String)
      {
         super(param1,true);
      }
   }
}

