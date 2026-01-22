package projects.tanks.client.panel.model.shop.description
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShopItemAdditionalDescriptionModelBase extends Model
   {

      protected var server:ShopItemAdditionalDescriptionModelServer;

      public static const modelId:Long = Long.getLong(1818598309,-2022254470);

      public function ShopItemAdditionalDescriptionModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShopItemAdditionalDescriptionModelServer(IModel(this));
      }

      protected function getInitParam() : ShopItemAdditionalDescriptionCC
      {
         return ShopItemAdditionalDescriptionCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
