package projects.tanks.client.partners.impl.asiasoft
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class AsiasoftPaymentModelServer
   {

      private var model:IModel;

      public function AsiasoftPaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function checkBalance(param1:IGameObject) : void
      {
      }

      public function requestPayment(param1:Long) : void
      {
      }
   }
}
