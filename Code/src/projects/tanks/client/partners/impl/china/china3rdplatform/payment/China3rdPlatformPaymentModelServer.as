package projects.tanks.client.partners.impl.china.china3rdplatform.payment
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class China3rdPlatformPaymentModelServer
   {

      private var model:IModel;

      public function China3rdPlatformPaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getPaymentUrl(param1:Long) : void
      {
      }
   }
}
