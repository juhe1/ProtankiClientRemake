package projects.tanks.client.panel.model.payment.modes.qiwi
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class QiwiPaymentModelServer
   {

      private var model:IModel;

      public function QiwiPaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getPaymentUrl(param1:Long, param2:String) : void
      {
      }
   }
}
