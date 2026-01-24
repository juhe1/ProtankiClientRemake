package alternativa.tanks.gui.dailyquests.window.events
{
   import flash.events.Event;
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   
   public class DailyQuestGetPrizeEvent extends Event
   {
      
      public static const DAILY_QUEST_GET_PRIZE:String = "DailyQuestGetPrize";
      
      public var dailyQuestInfo:DailyQuestInfo;
      
      public function DailyQuestGetPrizeEvent(param1:String, param2:DailyQuestInfo)
      {
         super(param1,true);
         this.dailyQuestInfo = param2;
      }
   }
}

