
package projects.tanks.client.battleservice.model.latency
{

   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import scpacker.networking.protocol.packets.ping.PongOutPacket;
   import alternativa.osgi.OSGi;

   public class LatencyModelServer
   {
      private var model:IModel;

      private var network:Network = Network(OSGi.getInstance().getService(Network));
      
      public function LatencyModelServer(param1:IModel)
      {
      }
      
      public function pong() : void
      {
         network.send(new PongOutPacket());
      }
   }
}