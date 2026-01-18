package projects.tanks.client.battlefield.models.tankparts.weapon.turret
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.tank.ClientRotateTurretOutPacket;

   public class RotatingTurretModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function RotatingTurretModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function rotate(param1:int, param2:int, param3:RotateTurretCommand) : void
      {
         network.send(new ClientRotateTurretOutPacket(param1,param3,param2));
      }
   }
}
