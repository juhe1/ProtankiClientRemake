package projects.tanks.client.panel.model.shop.specialkit.view
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PayPalKitViewModelBase extends Model
   {

      protected var server:PayPalKitViewModelServer;

      public static const modelId:Long = Long.getLong(356896316,-88712144);

      public function PayPalKitViewModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PayPalKitViewModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
