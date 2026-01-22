package projects.tanks.client.panel.model.shop.discount
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShopDiscountModelBase extends Model
   {

      protected var server:ShopDiscountModelServer;

      public static const modelId:Long = Long.getLong(1969380491,159728732);

      public function ShopDiscountModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShopDiscountModelServer(IModel(this));
      }

      protected function getInitParam() : ShopDiscountCC
      {
         return ShopDiscountCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
