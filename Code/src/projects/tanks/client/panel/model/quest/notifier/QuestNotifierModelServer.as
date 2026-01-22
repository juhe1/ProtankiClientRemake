package projects.tanks.client.panel.model.quest.notifier
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class QuestNotifierModelServer
   {

      private var model:IModel;

      public function QuestNotifierModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function completedDailyQuestViewed() : void
      {
      }

      public function completedWeeklyQuestViewed() : void
      {
      }

      public function newDailyQuestViewed() : void
      {
      }

      public function newWeeklyQuestViewed() : void
      {
      }
   }
}
