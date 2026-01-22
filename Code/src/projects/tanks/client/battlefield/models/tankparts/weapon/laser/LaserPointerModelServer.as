package projects.tanks.client.battlefield.models.tankparts.weapon.laser
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import alternativa.osgi.OSGi;
   import scpacker.networking.Network;
   import scpacker.networking.protocol.packets.shaft.ShaftLaserAimAtTankOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftLaserHideOutPacket;
   import scpacker.networking.protocol.packets.shaft.ShaftLaserUpdateDirectionOutPacket;

   public class LaserPointerModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function LaserPointerModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function aimAtTank(param1:IGameObject, param2:Vector3d) : void
      {
         this.network.send(new ShaftLaserAimAtTankOutPacket(param1.name,param2));
      }

      public function hide() : void
      {
         this.network.send(new ShaftLaserHideOutPacket());
      }

      public function updateDirection(param1:Number) : void
      {
         this.network.send(new ShaftLaserUpdateDirectionOutPacket(param1));
      }
   }
}
