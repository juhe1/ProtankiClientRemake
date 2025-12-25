package scpacker.networking
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.network.INetworkService;
   import scpacker.networking.Network;
   
   public class Connector
   {
      public static var networkService:INetworkService;
      
      private var network:Network;
      
      public function Connector()
      {
         super();
      }
      
      public function connectToServer() : void
      {
         this.network = Network(OSGi.getInstance().getService(Network));
         networkService = OSGi.getInstance().getService(INetworkService) as INetworkService;
         var _loc1_:Vector.<String> = networkService.controlServerAddress;
         var _loc2_:Vector.<int> = networkService.controlServerPorts;
         OSGi.clientLog.log("net","Connecting to server");
         if(_loc1_.length > 1)
         {
            this.network.setExtraHost(_loc1_[1],_loc2_[1]);
         }
         this.network.connect(_loc1_[0],_loc2_[0]);
         OSGi.clientLog.log("net","Connected to server");
      }
   }
}

