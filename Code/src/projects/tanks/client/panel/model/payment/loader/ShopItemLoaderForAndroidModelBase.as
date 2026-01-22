package projects.tanks.client.panel.model.payment.loader
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShopItemLoaderForAndroidModelBase extends Model
   {

      protected var server:ShopItemLoaderForAndroidModelServer;

      public static const modelId:Long = Long.getLong(1896396405,832327381);

      public function ShopItemLoaderForAndroidModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShopItemLoaderForAndroidModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
