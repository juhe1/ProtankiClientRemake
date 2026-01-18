package projects.tanks.client.battlefield.models.tankparts.weapon.railgun
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.packets.railgun.RailgunFireOutPacket;
   import utils.TankNameGameObjectMapper;
   import scpacker.networking.protocol.packets.railgun.RailgunFireDummyOutPacket;
   import scpacker.networking.protocol.packets.railgun.RailgunStartChargingOutPacket;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;

   public class RailgunModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function RailgunModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function fireCommand(param1:int, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>, param5:Vector.<int>, param6:Vector.<Vector3d>, param7:Vector.<Vector3d>) : void
      {
         var targets:Vector.<String> = new Vector.<String>();
         for each(var targetGameObject:IGameObject in param3)
         {
            targets.push(TankNameGameObjectMapper.getTankNameByGameObject(targetGameObject));
         }
         network.send(new RailgunFireOutPacket(param1,param2,targets,param4,param5,param6,param7));
      }

      public function fireDummyCommand(param1:int) : void
      {
         network.send(new RailgunFireDummyOutPacket(param1));
      }

      public function startChargingCommand(param1:int) : void
      {
         network.send(new RailgunStartChargingOutPacket(param1));
      }
   }
}
