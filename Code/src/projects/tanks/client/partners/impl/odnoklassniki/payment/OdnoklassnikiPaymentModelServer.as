package projects.tanks.client.partners.impl.odnoklassniki.payment
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class OdnoklassnikiPaymentModelServer
   {

      private var model:IModel;

      public function OdnoklassnikiPaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getPaymentTransaction(param1:Long) : void
      {
      }
   }
}
