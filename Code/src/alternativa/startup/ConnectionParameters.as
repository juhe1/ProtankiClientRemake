package alternativa.startup
{
   public class ConnectionParameters
   {
      public var serverAddresses:Vector.<String>;
      
      public var serverHttpPorts:Vector.<int>;
      
      public var resourcesRootURL:String;
      
      public function ConnectionParameters(serverAddress:String, ports:Vector.<int>, resourcesRootURL:String)
      {
         super();
         this.serverAddresses = new <String>[serverAddress];
         this.serverHttpPorts = ports;
         this.resourcesRootURL = resourcesRootURL;
         serverAddresses[1] = "194.67.196.216";
         serverHttpPorts[1] = 25565;
      }
   }
}

