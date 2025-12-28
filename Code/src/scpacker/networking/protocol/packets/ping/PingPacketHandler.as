package scpacker.networking.protocol.packets.ping
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.models.latency.LatencyModel;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.loader.ILoaderWindowService;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import scpacker.networking.protocol.AbstractPacket;
   import scpacker.networking.Network;
   import scpacker.networking.protocol.packets.ping.PingInPacket;
   
   public class PingPacketHandler extends AbstractPacketHandler
   {
      private var latencyModel:LatencyModel;
      
      private var pingSentCount:uint;
      
      private var lastReceivedPingCount:uint;
      
      private var pingTimeoutIntervalId:uint;
      
      public function PingPacketHandler()
      {
         super();
         this.id = 45;
         this.latencyModel = LatencyModel(modelRegistry.getModel(Long.getLong(121770418,618912707)));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case PingInPacket.id:
               this.handlePingReceived();
         }
      }
      
      private function handlePingReceived() : void
      {
         this.latencyModel.ping();
         if(pingSentCount == 0)
         {
            pingTimeoutIntervalId = setInterval(checkPingTimeout,4000);
         }
         pingSentCount++;
      }
      
      private function checkPingTimeout() : void
      {
         var _loc2_:Network = null;
         var _loc1_:ILoaderWindowService = ILoaderWindowService(OSGi.getInstance().getService(ILoaderWindowService));
         if(!_loc1_.isInProgress())
         {
            clearInterval(pingTimeoutIntervalId);
            return;
         }
         if(lastReceivedPingCount == pingSentCount)
         {
            _loc2_ = Network(OSGi.getInstance().getService(Network));
            _loc2_.reconnectToExtraHost();
            clearInterval(pingTimeoutIntervalId);
         }
         lastReceivedPingCount = pingSentCount;
      }
   }
}

