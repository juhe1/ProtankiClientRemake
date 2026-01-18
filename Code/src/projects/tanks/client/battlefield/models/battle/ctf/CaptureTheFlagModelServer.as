package projects.tanks.client.battlefield.models.battle.ctf
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.capturetheflag.DropFlagOutPacket;

   public class CaptureTheFlagModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function CaptureTheFlagModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function dropFlagCommand() : void
      {
         this.network.send(new DropFlagOutPacket());
      }
   }
}
