package projects.tanks.client.tanksservices.model.reconnect
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ReconnectModelBase extends Model
   {

      protected var server:ReconnectModelServer;

      public static const modelId:Long = Long.getLong(1511581132,-1911657689);

      public function ReconnectModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ReconnectModelServer(IModel(this));
      }

      protected function getInitParam() : ReconnectCC
      {
         return ReconnectCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
