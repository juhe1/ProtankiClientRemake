package projects.tanks.client.battlefield.models.user.tank
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;

   public class TankModelServer
   {

      private var model:IModel;

      public function TankModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function deathConfirmationCommand() : void
      {
      }

      public function handleCollisionWithOtherTank(param1:Number) : void
      {
      }

      public function moveCommand(param1:int, param2:int, param3:MoveCommand) : void
      {
      }

      public function movementControlCommand(param1:int, param2:int, param3:int, param4:int) : void
      {
      }
   }
}
