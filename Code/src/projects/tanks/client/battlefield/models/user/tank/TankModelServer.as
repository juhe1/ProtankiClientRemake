package projects.tanks.client.battlefield.models.user.tank
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.tank.ClientMoveOutPacket;
   import scpacker.networking.protocol.packets.tank.MovementControlInPacket;
   import scpacker.networking.protocol.packets.tank.MovementControlOutPacket;
   import scpacker.networking.protocol.packets.tank.ActivateTankOutPacket;

   public class TankModelServer
   {

      private var model:IModel;

      private var network:Network;

      public function TankModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         this.network = Network(OSGi.getInstance().getService(Network));
      }
      public function activateTankCommand() : void
      {
         this.network.send(new ActivateTankOutPacket());
      }

      public function deathConfirmationCommand() : void
      {
      }

      public function handleCollisionWithOtherTank(param1:Number) : void
      {
      }

      public function moveCommand(param1:int, param2:int, param3:MoveCommand) : void
      {
         this.network.send(new ClientMoveOutPacket(param1,param2,param3));
      }

      public function movementControlCommand(param1:int, param2:int, param3:int) : void
      {
         this.network.send(new MovementControlOutPacket(param1,param2,param3));
      }
   }
}
