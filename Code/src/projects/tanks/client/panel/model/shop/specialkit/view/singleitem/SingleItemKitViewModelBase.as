package projects.tanks.client.panel.model.shop.specialkit.view.singleitem
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SingleItemKitViewModelBase extends Model
   {

      protected var server:SingleItemKitViewModelServer;

      public static const modelId:Long = Long.getLong(1606448211,-1233422259);

      public function SingleItemKitViewModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SingleItemKitViewModelServer(IModel(this));
      }

      protected function getInitParam() : SingleItemKitViewCC
      {
         return SingleItemKitViewCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
