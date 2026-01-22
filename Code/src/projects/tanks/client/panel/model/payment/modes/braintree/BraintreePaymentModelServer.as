package projects.tanks.client.panel.model.payment.modes.braintree
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class BraintreePaymentModelServer
   {

      private var model:IModel;

      public function BraintreePaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getPaymentUrl(param1:Long) : void
      {
      }
   }
}
