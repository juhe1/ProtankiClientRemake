package projects.tanks.client.garage.models.item.resistance
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class MountedResistancesModelServer
   {
      private var model:IModel;

      public function MountedResistancesModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function mount(param1:int, param2:IGameObject) : void
      {
      }

      public function unmount(param1:IGameObject) : void
      {
      }
   }
}
