package alternativa.tanks.model.dailyquest
{
   import projects.tanks.client.panel.model.dailyquest.DailyQuestModelBase;
   import projects.tanks.client.panel.model.dailyquest.IDailyQuestModelBase;
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   
   [ModelInfo]
   public class DailyQuestModel extends DailyQuestModelBase implements IDailyQuestModelBase, DailyQuest
   {
      
      public function DailyQuestModel()
      {
         super();
      }
      
      public function skipDailyQuest(param1:DailyQuestInfo) : void
      {
         if(param1.canSkipForFree)
         {
            server.skipQuestForFree(param1.questId);
         }
         else
         {
            server.skipQuestForCrystals(param1.questId,param1.skipCost);
         }
      }
      
      public function takePrize(param1:DailyQuestInfo) : void
      {
         server.takePrize(param1.questId);
      }
   }
}

