package projects.tanks.client.panel.model.payment.modes.gate2shop
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class Gate2ShopPaymentModelServer
   {

      private var model:IModel;

      public function Gate2ShopPaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getPaymentUrl(param1:Long) : void
      {
      }

      public function registerEmailAndGetPaymentUrl(param1:Long, param2:String) : void
      {
      }

      public function validateEmail(param1:String) : void
      {
      }
   }
}
