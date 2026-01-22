package projects.tanks.client.panel.model.quest.daily
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DailyQuestShowingModelBase extends Model
   {

      protected var server:DailyQuestShowingModelServer;

      public static const modelId:Long = Long.getLong(1734194361,-1013591761);

      public function DailyQuestShowingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DailyQuestShowingModelServer(IModel(this));
      }

      protected function getInitParam() : DailyQuestShowingCC
      {
         return DailyQuestShowingCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
