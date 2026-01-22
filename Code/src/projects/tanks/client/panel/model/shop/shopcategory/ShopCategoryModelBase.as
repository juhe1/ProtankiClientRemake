package projects.tanks.client.panel.model.shop.shopcategory
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShopCategoryModelBase extends Model
   {

      protected var server:ShopCategoryModelServer;

      public static const modelId:Long = Long.getLong(1873836778,65983182);

      public function ShopCategoryModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShopCategoryModelServer(IModel(this));
      }

      protected function getInitParam() : ShopCategoryCC
      {
         return ShopCategoryCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
