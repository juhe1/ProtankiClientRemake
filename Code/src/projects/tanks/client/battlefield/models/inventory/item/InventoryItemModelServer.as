package projects.tanks.client.battlefield.models.inventory.item
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class InventoryItemModelServer
   {

      private var model:IModel;

      public function InventoryItemModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function activate() : void
      {
      }
   }
}
