package projects.tanks.clients.fp10.libraries.tanksservices.service.address
{
   import alternativa.osgi.OSGi;
   import alternativa.types.Long;
   import flash.events.EventDispatcher;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import platform.client.fp10.core.service.address.AddressService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.address.events.BattleChangedAddressEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.address.events.TanksAddressEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;
   import swfaddress.SWFAddressEvent;
   
   public class TanksAddressServiceImpl extends EventDispatcher implements TanksAddressService
   {
      
      [Inject]
      public static var serverNameService:ServerNumberToLocaleServerService;
      
      [Inject]
      public static var addressService:AddressService;
      
      private const DELAY_LISTEN_ADDRESS_CHANGE:int = 1500;
      
      private var currentValue:String;
      
      private var serverName:String;
      
      private var oldServerName:String;
      
      private var battleId:Long;
      
      private var _locked:Boolean = true;
      
      private var timeoutId:uint;
      
      public function TanksAddressServiceImpl()
      {
         super();
         var _loc1_:String = AddressService(OSGi.getInstance().getService(AddressService)).getValue();
         this.battleId = this.parseBattle(_loc1_);
      }
      
      public function hasBattle() : Boolean
      {
         return this.battleId != null;
      }
      
      public function getBattleId() : Long
      {
         return this.battleId;
      }
      
      public function init(param1:int) : void
      {
         this.oldServerName = this.serverName = serverNameService.getServerCode(param1);
         this.locked = false;
      }
      
      public function back() : void
      {
         this.serverName = this.oldServerName;
         dispatchEvent(new TanksAddressEvent(TanksAddressEvent.BACK));
         this.locked = false;
      }
      
      public function getServerNumber() : int
      {
         return serverNameService.getServerNumber(this.serverName);
      }
      
      public function setServer(param1:int) : void
      {
         if(this.locked)
         {
            return;
         }
         var _loc2_:String = serverNameService.getServerCode(param1);
         this.setServerByNameAndBattle(_loc2_,null);
         this.setParams();
      }
      
      private function setServerByNameAndBattle(param1:String, param2:Long) : void
      {
         if(this.serverName == param1)
         {
            this.setBattle(param2);
            return;
         }
         this.serverName = param1;
         this.battleId = param2;
         this.locked = true;
         dispatchEvent(new TanksAddressEvent(TanksAddressEvent.TRY_CHANGE_SERVER));
      }
      
      public function setBattle(param1:Long) : void
      {
         if(this.locked)
         {
            return;
         }
         if(this.battleId == param1)
         {
            return;
         }
         this.battleId = param1;
         dispatchEvent(new BattleChangedAddressEvent(param1));
         this.setParams();
      }
      
      public function resetBattle() : void
      {
         if(this.locked)
         {
            return;
         }
         this.battleId = null;
         dispatchEvent(new TanksAddressEvent(TanksAddressEvent.BATTLE_RESET));
         this.setParams();
      }
      
      private function onAddressChange(param1:SWFAddressEvent) : void
      {
         if(this.locked)
         {
            return;
         }
         this.setServerByNameAndBattle(this.serverName,this.parseBattle(param1.value));
      }
      
      private function setParams() : void
      {
         var _loc1_:String = "";
         if(this.battleId != null)
         {
            _loc1_ += "battle=" + BattleInfoUtils.getBattleIdUhex(this.battleId);
         }
         addressService.setValue(_loc1_,false);
         this.currentValue = _loc1_;
      }
      
      public function parseBattle(param1:String) : Long
      {
         var _loc2_:int = int(param1.indexOf("battle="));
         if(_loc2_ != -1)
         {
            return Long.fromHexString(param1.substr(_loc2_ + 7,16));
         }
         return null;
      }
      
      public function get locked() : Boolean
      {
         return this._locked;
      }
      
      public function set locked(param1:Boolean) : void
      {
         if(this._locked == param1)
         {
            return;
         }
         if(param1)
         {
            this.lock();
         }
         else
         {
            this.unlock();
         }
      }
      
      private function lock() : void
      {
         this._locked = true;
         addressService.removeEventListener(SWFAddressEvent.CHANGE,this.onAddressChange);
         clearTimeout(this.timeoutId);
      }
      
      private function unlock() : void
      {
         this._locked = false;
         this.timeoutId = setTimeout(this.listenAddressChange,this.DELAY_LISTEN_ADDRESS_CHANGE);
      }
      
      private function listenAddressChange() : void
      {
         addressService.addEventListener(SWFAddressEvent.CHANGE,this.onAddressChange);
         var _loc1_:SWFAddressEvent = new SWFAddressEvent(SWFAddressEvent.CHANGE);
         this.onAddressChange(_loc1_);
      }
   }
}

