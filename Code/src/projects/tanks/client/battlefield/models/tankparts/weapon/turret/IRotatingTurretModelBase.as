package projects.tanks.client.battlefield.models.tankparts.weapon.turret
{
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;
   
   public interface IRotatingTurretModelBase
   {
      
      function rotate(param1:RotateTurretCommand) : void;
   }
}

