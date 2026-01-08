package projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;

   public class ArtilleryElevatingBarrelModelServer
   {

      private var model:IModel;

      public function ArtilleryElevatingBarrelModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function update(param1:int, param2:int, param3:RotateTurretCommand) : void
      {
      }
   }
}
