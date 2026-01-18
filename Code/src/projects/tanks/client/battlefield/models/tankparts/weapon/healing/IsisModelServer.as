package projects.tanks.client.battlefield.models.tankparts.weapon.healing
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.isida.IsidaResetTargetOutPacket;
   import scpacker.networking.protocol.packets.isida.IsidaSetTargetOutPacket;
   import scpacker.networking.protocol.packets.isida.IsidaStopOutPacket;
   import scpacker.networking.protocol.packets.isida.IsidaTickOutPacket;

   public class IsisModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function IsisModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function resetTarget(param1:int) : void
      {
         this.network.send(new IsidaResetTargetOutPacket(param1));
      }

      public function setTarget(param1:int, param2:IGameObject, param3:int, param4:Vector3d) : void
      {
         this.network.send(new IsidaSetTargetOutPacket(param1,param2.name,param3,param4));
      }

      public function stopWeaponCommand(param1:int) : void
      {
         this.network.send(new IsidaStopOutPacket(param1));
      }

      public function tickCommand(param1:int, param2:int, param3:Vector3d, param4:Vector3d) : void
      {
         this.network.send(new IsidaTickOutPacket(param1,param2,param3,param4));
      }
   }
}
