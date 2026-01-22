package projects.tanks.client.battleservice.model.statistics.dm
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class StatisticsDMModelBase extends Model
   {

      protected var server:StatisticsDMModelServer;

      public static const modelId:Long = Long.getLong(575618390,177970779);

      public function StatisticsDMModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new StatisticsDMModelServer(IModel(this));
      }

      protected function getInitParam() : StatisticsDMCC
      {
         return StatisticsDMCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
