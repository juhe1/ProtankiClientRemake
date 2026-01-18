package projects.tanks.client.battlefield.models.tankparts.weapon.twins
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.twins.TwinsFireOutPacket;
   import scpacker.networking.protocol.packets.twins.TwinsFireDummyOutPacket;
   import scpacker.networking.protocol.packets.twins.TwinsHitStaticCommandOutPacket;
   import scpacker.networking.protocol.packets.twins.TwinsHitTargetOutPacket;
   import utils.TankNameGameObjectMapper;

   public class TwinsModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function TwinsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function fireCommand(param1:int, param2:int, param3:int, param4:Vector3d) : void
      {
         this.network.send(new TwinsFireOutPacket(param1,param2,param3,param4));
      }

      public function fireDummyCommand(param1:int, param2:int) : void
      {
         this.network.send(new TwinsFireDummyOutPacket(param1,param2));
      }

      public function hitStaticCommand(param1:int, param2:int, param3:Vector3d) : void
      {
         this.network.send(new TwinsHitStaticCommandOutPacket(param1,param2,param3));
      }

      public function hitTargetCommand(param1:int, param2:int, param3:IGameObject, param4:Vector3d, param5:Vector3d) : void
      {
         this.network.send(new TwinsHitTargetOutPacket(param1,param2,TankNameGameObjectMapper.getTankNameByGameObject(param3),param4,param5));
      }
   }
}
