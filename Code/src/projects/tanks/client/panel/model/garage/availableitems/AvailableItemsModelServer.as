package projects.tanks.client.panel.model.garage.availableitems
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class AvailableItemsModelServer
   {

      private var model:IModel;

      public function AvailableItemsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function select(param1:IGameObject) : void
      {
      }
   }
}
