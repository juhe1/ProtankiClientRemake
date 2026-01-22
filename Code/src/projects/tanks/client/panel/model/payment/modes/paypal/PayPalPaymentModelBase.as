package projects.tanks.client.panel.model.payment.modes.paypal
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PayPalPaymentModelBase extends Model
   {

      protected var server:PayPalPaymentModelServer;

      public static const modelId:Long = Long.getLong(111164588,-1792267498);

      public function PayPalPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PayPalPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
