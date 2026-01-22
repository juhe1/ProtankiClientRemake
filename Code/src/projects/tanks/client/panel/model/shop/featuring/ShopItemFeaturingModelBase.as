package projects.tanks.client.panel.model.shop.featuring
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShopItemFeaturingModelBase extends Model
   {

      protected var server:ShopItemFeaturingModelServer;

      public static const modelId:Long = Long.getLong(1418336240,1735229935);

      public function ShopItemFeaturingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShopItemFeaturingModelServer(IModel(this));
      }

      protected function getInitParam() : ShopItemFeaturingCC
      {
         return ShopItemFeaturingCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
