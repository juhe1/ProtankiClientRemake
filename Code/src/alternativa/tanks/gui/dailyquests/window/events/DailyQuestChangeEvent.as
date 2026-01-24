package alternativa.tanks.gui.dailyquests.window.events
{
   import flash.events.Event;
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   
   public class DailyQuestChangeEvent extends Event
   {
      
      public static const DAILY_QUEST_CHANGE:String = "DailyQuestChange";
      
      public var dailyQuestInfo:DailyQuestInfo;
      
      public function DailyQuestChangeEvent(param1:String, param2:DailyQuestInfo)
      {
         super(param1,true);
         this.dailyQuestInfo = param2;
      }
   }
}

