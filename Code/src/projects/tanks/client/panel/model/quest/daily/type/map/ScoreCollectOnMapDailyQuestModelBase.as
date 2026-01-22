package projects.tanks.client.panel.model.quest.daily.type.map
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ScoreCollectOnMapDailyQuestModelBase extends Model
   {

      protected var server:ScoreCollectOnMapDailyQuestModelServer;

      public static const modelId:Long = Long.getLong(2038809803,-77133727);

      public function ScoreCollectOnMapDailyQuestModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ScoreCollectOnMapDailyQuestModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
