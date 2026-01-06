package projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation
{
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;
   
   public interface IArtilleryElevatingBarrelModelBase
   {
      
      function update(param1:RotateTurretCommand) : void;
   }
}

