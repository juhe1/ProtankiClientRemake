package projects.tanks.client.panel.model.shop.specialkit.view
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class NewbieKitViewModelBase extends Model
   {

      protected var server:NewbieKitViewModelServer;

      public static const modelId:Long = Long.getLong(271451623,-874714053);

      public function NewbieKitViewModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new NewbieKitViewModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
