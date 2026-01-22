package projects.tanks.client.panel.model.payment.modes.paypal
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class PayPalPaymentModelServer
   {

      private var model:IModel;

      public function PayPalPaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getPaymentUrl(param1:Long) : void
      {
      }
   }
}
