package projects.tanks.client.battlefield.models.tankparts.weapons.common.stream
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.machinegun.MachineGunStartFireOutPacket;
   import scpacker.networking.protocol.packets.machinegun.MachineGunStopFireOutPacket;
   import scpacker.networking.protocol.packets.machinegun.MachineGunUpdateTargetsOutPacket;
   import scpacker.networking.protocol.packets.machinegun.MachineGunUpdateDirectionOutPacket;

   public class StreamWeaponCommunicationModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function StreamWeaponCommunicationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function startFire(param1:int) : void
      {
         this.network.send(new MachineGunStartFireOutPacket(param1))
      }

      public function stopFire(param1:int) : void
      {
         this.network.send(new MachineGunStopFireOutPacket(param1))
      }

      public function updateTargets(param1:int, param2:Vector3d, param3:Vector.<TargetPosition>) : void
      {
         this.network.send(new MachineGunUpdateTargetsOutPacket(param1,param2,param3))
      }

      public function updateTargetsDummy(param1:int, param2:Vector3d) : void
      {
         this.network.send(new MachineGunUpdateDirectionOutPacket(param1,param2))
      }
   }
}
