package projects.tanks.client.battlefield.models.inventory.item
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class InventoryItemModelBase extends Model
   {

      protected var server:InventoryItemModelServer;

      private static const modelId:Long = Long.getLong(1160724760,1672827267);

      public function InventoryItemModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new InventoryItemModelServer(IModel(this));
      }

      protected function getInitParam() : InventoryItemCC
      {
         return InventoryItemCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
