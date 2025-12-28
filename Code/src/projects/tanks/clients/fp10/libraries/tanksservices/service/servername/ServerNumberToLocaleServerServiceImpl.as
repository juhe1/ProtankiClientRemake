package projects.tanks.clients.fp10.libraries.tanksservices.service.servername
{
   import mx.utils.StringUtil;
   import projects.tanks.client.tanksservices.model.reconnect.ServerName2NumberItem;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.address.types.ServerNameParts;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
   
   public class ServerNumberToLocaleServerServiceImpl implements ServerNumberToLocaleServerService
   {
      
      [Inject] // added
      public static var reconnectService:ReconnectService;
      
      [Inject] // added
      public static var addressService:TanksAddressService;
      
      private static const SERVER_NAME_PATTERN:RegExp = /^[A-Za-z]{2}[1-9][0-9]{0,8}$/;
      
      private var serverName2NumberItems:Vector.<ServerName2NumberItem>;
      
      public function ServerNumberToLocaleServerServiceImpl(param1:Vector.<ServerName2NumberItem>)
      {
         super();
         this.serverName2NumberItems = param1;
      }
      
      public function isLocalServer() : Boolean
      {
         return addressService.getServerNumber() == reconnectService.getCurrentServerNumber();
      }
      
      public function getCurrentServerCode() : String
      {
         return this.getServerCode(reconnectService.getCurrentServerNumber());
      }
      
      public function getServerName(param1:int) : String
      {
         var _loc2_:ServerName2NumberItem = this.getServer2NumberItem(param1);
         return StringUtil.substitute(_loc2_.nameTemplate,param1 - _loc2_.shift + 1);
      }
      
      public function getServerCode(param1:int) : String
      {
         var _loc2_:ServerName2NumberItem = this.getServer2NumberItem(param1);
         return _loc2_.prefix + (param1 - _loc2_.shift + 1);
      }
      
      public function getServerLocale(param1:int) : String
      {
         return this.getServer2NumberItem(param1).lang;
      }
      
      public function isValidName(param1:String) : Boolean
      {
         var _loc2_:ServerNameParts = this.parseServerName(param1);
         return _loc2_.isValid();
      }
      
      public function getServerNumber(param1:String) : int
      {
         var _loc2_:ServerNameParts = this.parseServerName(param1);
         if(!_loc2_.isValid())
         {
            throw new Error("Invalid server name: serverName=" + param1);
         }
         return _loc2_.getServerNumber();
      }
      
      private function getServer2NumberItem(param1:int) : ServerName2NumberItem
      {
         var _loc3_:ServerName2NumberItem = null;
         var _loc4_:ServerName2NumberItem = null;
         if(param1 <= 0)
         {
            throw new Error("Server number must be postive: serverNumber=" + param1);
         }
         var _loc2_:int = -1;
         for each(_loc4_ in this.serverName2NumberItems)
         {
            if(_loc4_.shift > _loc2_ && _loc4_.shift <= param1)
            {
               _loc2_ = _loc4_.shift;
               _loc3_ = _loc4_;
            }
         }
         if(_loc3_ == null)
         {
            throw new Error("need is null");
         }
         return _loc3_;
      }
      
      public function getLocaleServerNumber(param1:int) : int
      {
         return param1 - this.getServer2NumberItem(param1).shift + 1;
      }
      
      private function parseServerName(param1:String) : ServerNameParts
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:ServerName2NumberItem = null;
         var _loc5_:int = 0;
         if(this.checkByRegex(param1))
         {
            param1 = param1.toUpperCase();
            _loc2_ = param1.substr(0,2).toUpperCase();
            _loc3_ = parseInt(param1.substr(2));
            _loc4_ = this.findItemByPrefix(_loc2_);
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.shift + _loc3_ - 1;
               if(this.getServerCode(_loc5_) == param1)
               {
                  return new ServerNameParts(true,_loc5_);
               }
            }
         }
         return new ServerNameParts(false);
      }
      
      private function checkByRegex(param1:String) : Boolean
      {
         return SERVER_NAME_PATTERN.test(param1);
      }
      
      private function findItemByPrefix(param1:String) : ServerName2NumberItem
      {
         var _loc2_:ServerName2NumberItem = null;
         for each(_loc2_ in this.serverName2NumberItems)
         {
            if(_loc2_.prefix == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

