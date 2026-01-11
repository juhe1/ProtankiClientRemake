package projects.tanks.client.battlefield.models.tankparts.engine
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class EngineModelBase extends Model
   {

      protected var server:EngineModelServer;

      public static const modelId:Long = Long.getLong(923418047,-17313881);

      public function EngineModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EngineModelServer(IModel(this));
      }

      protected function getInitParam() : EngineCC
      {
         return EngineCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
