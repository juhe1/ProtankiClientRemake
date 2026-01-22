package projects.tanks.client.tanksservices.model.notifier.rank
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RankNotifierModelBase extends Model
   {

      protected var server:RankNotifierModelServer;

      public static const modelId:Long = Long.getLong(60229216,350352129);

      public function RankNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RankNotifierModelServer(IModel(this));
      }

      protected function getInitParam() : RankNotifierData
      {
         return RankNotifierData(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
