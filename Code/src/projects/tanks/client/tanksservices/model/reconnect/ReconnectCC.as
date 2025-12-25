package projects.tanks.client.tanksservices.model.reconnect
{
   public class ReconnectCC
   {
      
      private var _balancerServletUrl:String;
      
      private var _configUrlTemplate:String;
      
      private var _enabled:Boolean;
      
      private var _enabledChooseServerByRank:Boolean;
      
      private var _items:Vector.<ServerName2NumberItem>;
      
      private var _maxUsersForAutoReconnect:int;
      
      private var _maxUsersOnServer:int;
      
      private var _rank:int;
      
      private var _serverNumber:int;
      
      private var _serverPrefix:String;
      
      public function ReconnectCC(param1:String = null, param2:String = null, param3:Boolean = false, param4:Boolean = false, param5:Vector.<ServerName2NumberItem> = null, param6:int = 0, param7:int = 0, param8:int = 0, param9:int = 0, param10:String = null)
      {
         super();
         this._balancerServletUrl = param1;
         this._configUrlTemplate = param2;
         this._enabled = param3;
         this._enabledChooseServerByRank = param4;
         this._items = param5;
         this._maxUsersForAutoReconnect = param6;
         this._maxUsersOnServer = param7;
         this._rank = param8;
         this._serverNumber = param9;
         this._serverPrefix = param10;
      }
      
      public function get balancerServletUrl() : String
      {
         return this._balancerServletUrl;
      }
      
      public function set balancerServletUrl(param1:String) : void
      {
         this._balancerServletUrl = param1;
      }
      
      public function get configUrlTemplate() : String
      {
         return this._configUrlTemplate;
      }
      
      public function set configUrlTemplate(param1:String) : void
      {
         this._configUrlTemplate = param1;
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
      }
      
      public function get enabledChooseServerByRank() : Boolean
      {
         return this._enabledChooseServerByRank;
      }
      
      public function set enabledChooseServerByRank(param1:Boolean) : void
      {
         this._enabledChooseServerByRank = param1;
      }
      
      public function get items() : Vector.<ServerName2NumberItem>
      {
         return this._items;
      }
      
      public function set items(param1:Vector.<ServerName2NumberItem>) : void
      {
         this._items = param1;
      }
      
      public function get maxUsersForAutoReconnect() : int
      {
         return this._maxUsersForAutoReconnect;
      }
      
      public function set maxUsersForAutoReconnect(param1:int) : void
      {
         this._maxUsersForAutoReconnect = param1;
      }
      
      public function get maxUsersOnServer() : int
      {
         return this._maxUsersOnServer;
      }
      
      public function set maxUsersOnServer(param1:int) : void
      {
         this._maxUsersOnServer = param1;
      }
      
      public function get rank() : int
      {
         return this._rank;
      }
      
      public function set rank(param1:int) : void
      {
         this._rank = param1;
      }
      
      public function get serverNumber() : int
      {
         return this._serverNumber;
      }
      
      public function set serverNumber(param1:int) : void
      {
         this._serverNumber = param1;
      }
      
      public function get serverPrefix() : String
      {
         return this._serverPrefix;
      }
      
      public function set serverPrefix(param1:String) : void
      {
         this._serverPrefix = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ReconnectCC [";
         _loc1_ += "balancerServletUrl = " + this.balancerServletUrl + " ";
         _loc1_ += "configUrlTemplate = " + this.configUrlTemplate + " ";
         _loc1_ += "enabled = " + this.enabled + " ";
         _loc1_ += "enabledChooseServerByRank = " + this.enabledChooseServerByRank + " ";
         _loc1_ += "items = " + this.items + " ";
         _loc1_ += "maxUsersForAutoReconnect = " + this.maxUsersForAutoReconnect + " ";
         _loc1_ += "maxUsersOnServer = " + this.maxUsersOnServer + " ";
         _loc1_ += "rank = " + this.rank + " ";
         _loc1_ += "serverNumber = " + this.serverNumber + " ";
         _loc1_ += "serverPrefix = " + this.serverPrefix + " ";
         return _loc1_ + "]";
      }
   }
}

