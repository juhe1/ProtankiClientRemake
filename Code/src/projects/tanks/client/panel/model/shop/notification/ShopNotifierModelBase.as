package projects.tanks.client.panel.model.shop.notification
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ShopNotifierModelBase extends Model
   {

      protected var server:ShopNotifierModelServer;

      public static const modelId:Long = Long.getLong(1668161981,-943255745);

      public function ShopNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ShopNotifierModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
