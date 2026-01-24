package projects.tanks.client.panel.model.quest.daily
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import alternativa.types.Long;

   public class DailyQuestShowingModelServer
   {

      private var model:IModel;

      public function DailyQuestShowingModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function givePrize(param1:Long) : void
      {
      }

      public function openWindow() : void
      {
      }

      public function skipQuestForCrystals(param1:Long, param2:int) : void
      {
      }

      public function skipQuestForFree(param1:Long) : void
      {
      }

      public function skipQuestForShowedAds(param1:Long) : void
      {
      }
   }
}
