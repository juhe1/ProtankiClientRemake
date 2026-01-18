package projects.tanks.client.battlefield.models.user.spawn
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.tank.ReadyToSpawnEndOutPacket;
   import scpacker.networking.protocol.packets.tank.ReadyToPlaceOutPacket;

   public class TankSpawnerModelServer
   {

      private var model:IModel;
      private var network:Network = Network(OSGi.getInstance().getService(Network));

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
         network.send(new ReadyToSpawnEndOutPacket());
      }

      public function setReadyToPlace() : void
      {
         network.send(new ReadyToPlaceOutPacket());
      }
   }
}
