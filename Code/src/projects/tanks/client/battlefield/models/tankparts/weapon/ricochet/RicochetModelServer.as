package projects.tanks.client.battlefield.models.tankparts.weapon.ricochet
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.ricochet.RicochetFireOutPacket;
   import scpacker.networking.protocol.packets.ricochet.RicochetFireDummyOutPacket;
   import scpacker.networking.protocol.packets.ricochet.RicochetHitStaticOutPacket;
   import scpacker.networking.protocol.packets.ricochet.RicochetHitTargetOutPacket;

   public class RicochetModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function RicochetModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function fireCommand(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         this.network.send(new RicochetFireOutPacket(param1, param2, param3, param4, param5));
      }

      public function fireDummyCommand(param1:int) : void
      {
         this.network.send(new RicochetFireDummyOutPacket(param1));
      }

      public function hitStaticCommand(param1:int, param2:int, param3:Vector.<Vector3d>) : void
      {
         this.network.send(new RicochetHitStaticOutPacket(param1, param2, param3));
      }

      public function hitTargetCommand(param1:int, param2:IGameObject, param3:int, param4:Vector3d, param5:Vector.<Vector3d>) : void
      {
         this.network.send(new RicochetHitTargetOutPacket(param1, param2.name, param3, param4, param5));
      }
   }
}
