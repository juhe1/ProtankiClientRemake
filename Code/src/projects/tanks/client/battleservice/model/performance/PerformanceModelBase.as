package projects.tanks.client.battleservice.model.performance
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PerformanceModelBase extends Model
   {

      protected var server:PerformanceModelServer;

      public static const modelId:Long = Long.getLong(181133769,676290849);

      public function PerformanceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PerformanceModelServer(IModel(this));
      }

      protected function getInitParam() : PerformanceCC
      {
         return PerformanceCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
