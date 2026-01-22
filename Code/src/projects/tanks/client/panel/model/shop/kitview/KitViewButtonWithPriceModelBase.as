package projects.tanks.client.panel.model.shop.kitview
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KitViewButtonWithPriceModelBase extends Model
   {

      protected var server:KitViewButtonWithPriceModelServer;

      public static const modelId:Long = Long.getLong(56912630,-752681015);

      public function KitViewButtonWithPriceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KitViewButtonWithPriceModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
