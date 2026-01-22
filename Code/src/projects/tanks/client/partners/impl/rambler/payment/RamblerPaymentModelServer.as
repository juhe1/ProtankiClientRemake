package projects.tanks.client.partners.impl.rambler.payment
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class RamblerPaymentModelServer
   {

      private var model:IModel;

      public function RamblerPaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getPaymentTransaction(param1:Long) : void
      {
      }
   }
}
