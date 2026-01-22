package projects.tanks.client.panel.model.payment.modes
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PaymentModeModelBase extends Model
   {

      protected var server:PaymentModeModelServer;

      public static const modelId:Long = Long.getLong(1105601461,1114828071);

      public function PaymentModeModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PaymentModeModelServer(IModel(this));
      }

      protected function getInitParam() : PayModeCC
      {
         return PayModeCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
