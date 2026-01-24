package alternativa.tanks.model.dailyquest
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   
   public class DailyQuestAdapt implements DailyQuest
   {
      
      private var object:IGameObject;
      
      private var impl:DailyQuest;
      
      public function DailyQuestAdapt(param1:IGameObject, param2:DailyQuest)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function skipDailyQuest(param1:DailyQuestInfo) : void
      {
         var dailyQuestInfo:DailyQuestInfo = param1;
         try
         {
            Model.object = this.object;
            this.impl.skipDailyQuest(dailyQuestInfo);
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function takePrize(param1:DailyQuestInfo) : void
      {
         var dailyQuestInfo:DailyQuestInfo = param1;
         try
         {
            Model.object = this.object;
            this.impl.takePrize(dailyQuestInfo);
         }
         finally
         {
            Model.popObject();
         }
      }
   }
}

