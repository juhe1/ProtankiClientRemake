package projects.tanks.client.battlefield.models.tankparts.weapon.turret
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;

   public class RotatingTurretModelServer
   {

      private var model:IModel;

      public function RotatingTurretModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function rotate(param1:int, param2:int, param3:RotateTurretCommand) : void
      {
      }
   }
}
