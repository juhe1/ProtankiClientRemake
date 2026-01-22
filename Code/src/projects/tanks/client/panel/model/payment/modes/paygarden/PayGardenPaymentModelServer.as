package projects.tanks.client.panel.model.payment.modes.paygarden
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class PayGardenPaymentModelServer
   {

      private var model:IModel;

      public function PayGardenPaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getPaymentUrl(param1:Long) : void
      {
      }
   }
}
