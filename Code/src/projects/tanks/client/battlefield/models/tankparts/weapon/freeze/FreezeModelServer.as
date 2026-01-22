package projects.tanks.client.battlefield.models.tankparts.weapon.freeze
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.freeze.FreezeDamageOutPacket;
   import utils.TankNameGameObjectMapper;
   import scpacker.networking.protocol.packets.freeze.FreezeStartOutPacket;
   import scpacker.networking.protocol.packets.freeze.FreezeStopOutPacket;

   public class FreezeModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function FreezeModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function dryShot(param1:int) : void
      {
      }

      public function hitCommand(param1:int, param2:Vector.<IGameObject>, param3:Vector.<int>, param4:Vector.<Vector3d>, param5:Vector.<Vector3d>) : void
      {
         var targets:Vector.<String> = new Vector.<String>();
         for each(var targetGameObject:IGameObject in param2)
         {
            targets.push(TankNameGameObjectMapper.getTankNameByGameObject(targetGameObject));
         }
         this.network.send(new FreezeDamageOutPacket(param1,targets,param3,param4,param5));
      }

      public function startFireCommand(param1:int) : void
      {
         this.network.send(new FreezeStartOutPacket(param1));
      }

      public function stopFireCommand(param1:int) : void
      {
         this.network.send(new FreezeStopOutPacket(param1));
      }
   }
}
