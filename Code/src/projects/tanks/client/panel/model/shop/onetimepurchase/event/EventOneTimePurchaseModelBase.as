package projects.tanks.client.panel.model.shop.onetimepurchase.event
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.panel.model.shop.onetimepurchase.ShopItemOneTimePurchaseCC;

   public class EventOneTimePurchaseModelBase extends Model
   {

      protected var server:EventOneTimePurchaseModelServer;

      public static const modelId:Long = Long.getLong(1592905426,190628822);

      public function EventOneTimePurchaseModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EventOneTimePurchaseModelServer(IModel(this));
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
