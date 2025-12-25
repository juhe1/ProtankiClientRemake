package alternativa.osgi.service.network
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.logging.LogService;
   import alternativa.startup.ConnectionParameters;
   import flash.net.SharedObject;
   
   public class NetworkService implements INetworkService
   {
      private static const newname_492__END:String = "connection";
      
      private var logService:LogService;
      
      private var _controlServerAddress:Vector.<String>;
      
      private var _controlServerPorts:Vector.<int>;
      
      private var _resourcesRootUrl:String;
      
      public function NetworkService(param1:ConnectionParameters)
      {
         super();
         this._controlServerAddress = param1.serverAddresses;
         this._controlServerPorts = param1.serverHttpPorts;
         this._resourcesRootUrl = param1.resourcesRootURL;
         this.logService = LogService(OSGi.getInstance().getService(LogService));
      }
      
      public function get controlServerAddress() : Vector.<String>
      {
         return this._controlServerAddress;
      }
      
      public function get controlServerPorts() : Vector.<int>
      {
         return this._controlServerPorts;
      }
      
      public function get resourcesRootUrl() : String
      {
         return this._resourcesRootUrl;
      }
      
      public function getLastPort(param1:String) : int
      {
         var _loc2_:SharedObject = SharedObject.getLocal("connection","/");
         return _loc2_.data[param1];
      }
      
      public function saveLastPort(param1:String, param2:int) : void
      {
         var _loc5_:SharedObject = null;
         var _loc4_:* = param1;
         var _loc3_:* = param2;
         try
         {
            _loc5_ = SharedObject.getLocal("connection","/");
            _loc5_.data[_loc4_] = _loc3_;
            _loc5_.flush();
            return;
         }
         catch(e:Error)
         {
            logService.getLogger("NetworkServer").warning("Error stored port in shared object, Message = %1",[e]);
         }
      }
   }
}

