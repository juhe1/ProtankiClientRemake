package projects.tanks.client.partners.impl.kongregate
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class KongregatePaymentModelServer
   {

      private var model:IModel;

      public function KongregatePaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getPaymentTransaction(param1:Long) : void
      {
      }
   }
}
