package projects.tanks.client.panel.model.payment.modes.paygarden
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PayGardenPaymentModelBase extends Model
   {

      protected var server:PayGardenPaymentModelServer;

      public static const modelId:Long = Long.getLong(1881983528,123164696);

      public function PayGardenPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PayGardenPaymentModelServer(IModel(this));
      }

      protected function getInitParam() : PayGardenPaymentCC
      {
         return PayGardenPaymentCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
