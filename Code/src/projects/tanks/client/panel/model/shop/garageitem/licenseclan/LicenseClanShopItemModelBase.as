package projects.tanks.client.panel.model.shop.garageitem.licenseclan
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class LicenseClanShopItemModelBase extends Model
   {

      protected var server:LicenseClanShopItemModelServer;

      public static const modelId:Long = Long.getLong(342831337,-415928029);

      public function LicenseClanShopItemModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new LicenseClanShopItemModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
