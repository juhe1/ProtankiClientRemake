package alternativa.tanks.model.dailyquest
{
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   
   [ModelInterface]
   public interface DailyQuest
   {
      
      function skipDailyQuest(param1:DailyQuestInfo) : void;
      
      function takePrize(param1:DailyQuestInfo) : void;
   }
}

