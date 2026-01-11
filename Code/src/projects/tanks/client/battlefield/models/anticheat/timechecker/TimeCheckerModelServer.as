package projects.tanks.client.battlefield.models.anticheat.timechecker
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.timechecker.TimeCheckerPongOutPacket;

   public class TimeCheckerModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function TimeCheckerModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function pong(param1:int, param2:int) : void
      {
         network.send(new TimeCheckerPongOutPacket(param1,param2));
      }
   }
}
