package projects.tanks.client.battlefield.models.inventory.sfx
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class InventorySfxModelBase extends Model
   {

      protected var server:InventorySfxModelServer;

      private static const modelId:Long = Long.getLong(506159627,-1514632607);

      public function InventorySfxModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new InventorySfxModelServer(IModel(this));
      }

      protected function getInitParam() : InventorySfxCC
      {
         return InventorySfxCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
