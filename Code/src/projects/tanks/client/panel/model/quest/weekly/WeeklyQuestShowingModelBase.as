package projects.tanks.client.panel.model.quest.weekly
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class WeeklyQuestShowingModelBase extends Model
   {

      protected var server:WeeklyQuestShowingModelServer;

      public static const modelId:Long = Long.getLong(616930387,851653221);

      public function WeeklyQuestShowingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new WeeklyQuestShowingModelServer(IModel(this));
      }

      protected function getInitParam() : WeeklyQuestShowingCC
      {
         return WeeklyQuestShowingCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
