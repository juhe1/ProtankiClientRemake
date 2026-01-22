package projects.tanks.client.partners.impl.vkontakte
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class VkontaktePaymentModelServer
   {

      private var model:IModel;

      public function VkontaktePaymentModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function getPaymentTransaction(param1:Long) : void
      {
      }
   }
}
