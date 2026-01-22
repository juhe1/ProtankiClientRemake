package projects.tanks.client.panel.model.payment.modes.braintree
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BraintreePaymentModelBase extends Model
   {

      protected var server:BraintreePaymentModelServer;

      public static const modelId:Long = Long.getLong(176586390,-1429295990);

      public function BraintreePaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BraintreePaymentModelServer(IModel(this));
      }

      protected function getInitParam() : BraintreePaymentCC
      {
         return BraintreePaymentCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
