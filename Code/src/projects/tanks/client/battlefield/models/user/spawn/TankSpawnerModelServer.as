package projects.tanks.client.battlefield.models.user.spawn
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class TankSpawnerModelServer
   {

      private var model:IModel;

      public function TankSpawnerModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function confirmSpawn(param1:int) : void
      {
      }

      public function readyToSpawnCommand() : void
      {
      }

      public function setReadyToPlace() : void
      {
      }
   }
}
