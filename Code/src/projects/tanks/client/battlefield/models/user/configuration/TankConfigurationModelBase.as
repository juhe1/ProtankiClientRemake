package projects.tanks.client.battlefield.models.user.configuration
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankConfigurationModelBase extends Model
   {

      protected var server:TankConfigurationModelServer;

      private static const modelId:Long = Long.getLong(772311175,935242478);

      public function TankConfigurationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankConfigurationModelServer(IModel(this));
      }

      protected function getInitParam() : TankConfigurationCC
      {
         return TankConfigurationCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
