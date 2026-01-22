package projects.tanks.client.panel.model.quest.daily.type.goal
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class CaptureGoalDailyQuestModelBase extends Model
   {

      protected var server:CaptureGoalDailyQuestModelServer;

      public static const modelId:Long = Long.getLong(835552943,1303329520);

      public function CaptureGoalDailyQuestModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new CaptureGoalDailyQuestModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
