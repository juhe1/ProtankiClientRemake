package projects.tanks.client.battlefield.models.tankparts.weapon.thunder
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import alternativa.osgi.OSGi;
   import scpacker.networking.Network;
   import scpacker.networking.protocol.packets.thunder.ThunderShootOutPacket;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.ThunderShootSFXCC;
   import scpacker.networking.protocol.packets.thunder.ThunderShootStaticOutPacket;
   import scpacker.networking.protocol.packets.thunder.ThunderShootTargetOutPacket;

   public class ThunderModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function ThunderModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function shootCommand(param1:int) : void
      {
         this.network.send(new ThunderShootOutPacket(param1));
      }

      public function shootStaticCommand(param1:int, param2:Vector3d) : void
      {
         this.network.send(new ThunderShootStaticOutPacket(param1,param2));
      }

      public function shootTargetCommand(param1:int, param2:Vector3d, param3:IGameObject, param4:int, param5:Vector3d, param6:Vector3d) : void
      {
         this.network.send(new ThunderShootTargetOutPacket(param1,param2,param3.name,param4,param5,param6));
      }
   }
}
