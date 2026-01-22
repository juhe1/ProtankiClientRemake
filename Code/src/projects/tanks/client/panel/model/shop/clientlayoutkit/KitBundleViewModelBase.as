package projects.tanks.client.panel.model.shop.clientlayoutkit
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KitBundleViewModelBase extends Model
   {

      protected var server:KitBundleViewModelServer;

      public static const modelId:Long = Long.getLong(207099459,142283800);

      public function KitBundleViewModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KitBundleViewModelServer(IModel(this));
      }

      protected function getInitParam() : KitBundleViewCC
      {
         return KitBundleViewCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
