package projects.tanks.client.panel.model.payment.modes.platbox
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class PlatBoxPaymentModelServer
   {

      private var model:IModel;

      public function PlatBoxPaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function checkNumber(param1:String) : void
      {
      }

      public function initPayment(param1:String, param2:Long) : void
      {
      }
   }
}
