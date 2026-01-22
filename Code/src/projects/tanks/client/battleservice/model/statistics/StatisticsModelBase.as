package projects.tanks.client.battleservice.model.statistics
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class StatisticsModelBase extends Model
   {

      protected var server:StatisticsModelServer;

      public static const modelId:Long = Long.getLong(485575169,-17734339);

      public function StatisticsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new StatisticsModelServer(IModel(this));
      }

      protected function getInitParam() : StatisticsModelCC
      {
         return StatisticsModelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
