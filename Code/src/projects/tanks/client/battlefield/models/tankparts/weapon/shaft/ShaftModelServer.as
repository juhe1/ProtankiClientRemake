package projects.tanks.client.battlefield.models.tankparts.weapon.shaft
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class ShaftModelServer
   {

      private var model:IModel;

      public function ShaftModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function activateManualTargetingCommand() : void
      {
      }

      public function aimedShotCommand(param1:int, param2:Vector3d, param3:IGameObject, param4:Vector3d, param5:int, param6:Vector3d, param7:Vector3d) : void
      {
      }

      public function beginEnergyDrainCommand(param1:int) : void
      {
      }

      public function quickShotCommand(param1:int, param2:Vector3d, param3:IGameObject, param4:Vector3d, param5:int, param6:Vector3d, param7:Vector3d) : void
      {
      }

      public function stopManualTargetingCommand() : void
      {
      }
   }
}
