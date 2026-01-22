package projects.tanks.client.panel.model.shop.kitpackage.view
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KitPackageViewModelBase extends Model
   {

      protected var server:KitPackageViewModelServer;

      public static const modelId:Long = Long.getLong(1296670147,427202674);

      public function KitPackageViewModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KitPackageViewModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
