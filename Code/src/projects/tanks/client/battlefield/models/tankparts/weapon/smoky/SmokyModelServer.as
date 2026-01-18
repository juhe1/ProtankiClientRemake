package projects.tanks.client.battlefield.models.tankparts.weapon.smoky
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.smoky.SmokyFireOutPacket;
   import scpacker.networking.protocol.packets.smoky.SmokyFireStaticOutPacket;
   import scpacker.networking.protocol.packets.smoky.SmokyFireTargetOutPacket;

   public class SmokyModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function SmokyModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function fireCommand(param1:int) : void
      {
         this.network.send(new SmokyFireOutPacket(param1));
      }

      public function fireStaticCommand(param1:int, param2:Vector3d) : void
      {
         this.network.send(new SmokyFireStaticOutPacket(param1, param2));
      }

      public function fireTargetCommand(param1:int, param2:IGameObject, param3:int, param4:Vector3d, param5:Vector3d, param6:Vector3d) : void
      {
         this.network.send(new SmokyFireTargetOutPacket(param1, param2.name, param3, param4, param5, param6));
      }
   }
}
