package projects.tanks.client.panel.model.payment.modes.leogaming.mobile
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class LeogamingPaymentMobileModelServer
   {

      private var model:IModel;

      public function LeogamingPaymentMobileModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function confirmOrder(param1:String) : void
      {
      }

      public function createOrder(param1:IGameObject, param2:String) : void
      {
      }
   }
}
