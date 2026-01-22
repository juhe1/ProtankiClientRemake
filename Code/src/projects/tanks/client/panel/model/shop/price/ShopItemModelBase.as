package projects.tanks.client.panel.model.shop.price
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShopItemModelBase extends Model
   {

      protected var server:ShopItemModelServer;

      public static const modelId:Long = Long.getLong(161357642,1750616196);

      public function ShopItemModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShopItemModelServer(IModel(this));
      }

      protected function getInitParam() : ShopItemCC
      {
         return ShopItemCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
