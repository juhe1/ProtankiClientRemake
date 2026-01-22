package projects.tanks.client.panel.model.shop.promo
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShopPromoCodeModelBase extends Model
   {

      protected var server:ShopPromoCodeModelServer;

      public static const modelId:Long = Long.getLong(441391263,1266773881);

      public function ShopPromoCodeModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShopPromoCodeModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
