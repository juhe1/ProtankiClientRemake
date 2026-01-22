package projects.tanks.client.panel.model.shop.onetimepurchase
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShopItemOneTimePurchaseModelBase extends Model
   {

      protected var server:ShopItemOneTimePurchaseModelServer;

      public static const modelId:Long = Long.getLong(1850966957,-1146243215);

      public function ShopItemOneTimePurchaseModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShopItemOneTimePurchaseModelServer(IModel(this));
      }

      protected function getInitParam() : ShopItemOneTimePurchaseCC
      {
         return ShopItemOneTimePurchaseCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
