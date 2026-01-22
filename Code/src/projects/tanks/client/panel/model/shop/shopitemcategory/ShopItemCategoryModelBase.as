package projects.tanks.client.panel.model.shop.shopitemcategory
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShopItemCategoryModelBase extends Model
   {

      protected var server:ShopItemCategoryModelServer;

      public static const modelId:Long = Long.getLong(993751953,1293637298);

      public function ShopItemCategoryModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShopItemCategoryModelServer(IModel(this));
      }

      protected function getInitParam() : ShopItemCategoryCC
      {
         return ShopItemCategoryCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
