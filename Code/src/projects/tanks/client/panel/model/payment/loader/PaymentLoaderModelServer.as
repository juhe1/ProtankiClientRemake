package projects.tanks.client.panel.model.payment.loader
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.types.ShopCategoryEnum;

   public class PaymentLoaderModelServer
   {

      private var model:IModel;

      public function PaymentLoaderModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function loadPayment(param1:ShopCategoryEnum) : void
      {
      }

      public function loadPaymentWithGarageItem(param1:IGameObject) : void
      {
      }

      public function loadPaymentWithShopItem(param1:IGameObject) : void
      {
      }
   }
}
