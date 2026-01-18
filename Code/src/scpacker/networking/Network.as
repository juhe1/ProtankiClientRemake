package scpacker.networking
{
   import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
   import platform.client.fp10.core.network.handler.OnConnectionClosedServiceListener;
   import platform.client.fp10.core.service.errormessage.errors.ConnectionClosedError;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.logging.LogService;
   import alternativa.tanks.bg.IBackgroundService;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.describeType;
   import flash.utils.getTimer;
   import platform.client.fp10.core.service.errormessage.IErrorMessageService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import scpacker.networking.protocol.PacketInvoker;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.PacketFactory;
   import scpacker.networking.protocol.AbstractPacket;
   import scpacker.networking.protocol.PacketInitializer;
   import scpacker.logging.IRemoteLogging;
   
   public class Network
   {
      private static var packetInvoker:PacketInvoker;
      
      private static var protocolInitializer:ProtocolInitializer;
      
      private static var packetFactory:PacketFactory;
      
      public static var backgroundService:IBackgroundService;
      
      private var socket:Socket;
      
      private var readPosition:int;
      
      private var payloadBuffer:ByteArray = new ByteArray();
      
      private var inputBuffer:ByteArray = new ByteArray();
      
      private var useExtraHost:Boolean = false;
      
      private var sendBuffer:ByteArray = new ByteArray();
      
      private var extraHost:String;
      
      private var extraPort:int;
      
      public function Network()
      {
         super();
         this.socket = new Socket();
         packetFactory = new PacketFactory();
         packetInvoker = new PacketInvoker();
         OSGi.getInstance().registerService(PacketInvoker,packetInvoker);
         OSGi.getInstance().registerService(PacketFactory,packetFactory);
         protocolInitializer = new ProtocolInitializer();
         OSGi.getInstance().registerService(ProtocolInitializer,protocolInitializer);
         AbstractPacket.protocolInitializer = protocolInitializer;
      }
      
      public function connect(param1:String, param2:int) : void
      {
         var _loc3_:OSGi = null;
         var _loc4_:ProtocolInitializer = null;
         if(!useExtraHost)
         {
            _loc3_ = OSGi.getInstance();
            _loc4_ = ProtocolInitializer(_loc3_.getService(ProtocolInitializer));
            _loc4_.init();
            new PacketInitializer().init(_loc3_);
         }
         this.socket.connect(param1,param2);
         this.socket.addEventListener("socketData",this.onSocketData);
         this.socket.addEventListener("connect",this.onConnect);
         this.socket.addEventListener("close",this.onClose);
         this.socket.addEventListener("ioError",this.ioError);
         this.socket.addEventListener("securityError",this.onSecurityError);
      }
      
      public function destroy() : void
      {
         this.socket.removeEventListener("socketData",this.onSocketData);
         this.socket.removeEventListener("connect",this.onConnect);
         this.socket.removeEventListener("close",this.onClose);
         this.socket.removeEventListener("ioError",this.ioError);
         this.socket.removeEventListener("securityError",this.onSecurityError);
         inputBuffer.clear();
      }
      
      public function send(param1:AbstractPacket) : void
      {
         if(this.socket.connected)
         {
            param1.wrap(sendBuffer);
            this.socket.writeBytes(sendBuffer);
            this.socket.flush();
            sendBuffer.clear();
         }
      }
      
      private function onConnect(param1:Event) : void
      {
      }
      
      private function onSocketData(param1:ProgressEvent) : void
      {
         this.socket.readBytes(this.inputBuffer,this.inputBuffer.length);
         this.processIncoming();
      }
      
      private function processIncoming() : void
      {
         var _loc10_:int = 0;
         var _loc7_:* = false;
         var _loc3_:* = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:AbstractPacket = null;
         var _loc5_:IRemoteLogging = null;
         var _loc8_:String = null;
         var _loc6_:XML = null;
         var _loc2_:String = null;
         this.inputBuffer.position = this.readPosition;
         while(true)
         {
            if(this.inputBuffer.bytesAvailable < 8)
            {
               return;
            }
            _loc10_ = this.inputBuffer.readInt();
            _loc7_ = (_loc10_ >>> 24 & 0x40) != 0;
            _loc3_ = _loc10_ & 16777215;
            _loc1_ = this.inputBuffer.readInt();
            _loc4_ = _loc3_ - 8;
            if(this.inputBuffer.bytesAvailable < _loc4_)
            {
               return;
            }
            if(_loc4_ > 0)
            {
               this.inputBuffer.readBytes(this.payloadBuffer,0,_loc4_);
            }
            protocolInitializer.getProtection().decrypt(payloadBuffer,_loc4_);
            if(_loc7_)
            {
               this.payloadBuffer.uncompress("deflate");
            }
            try
            {
               _loc11_ = packetFactory.getPacket(_loc1_);
               _loc11_.unwrap(this.payloadBuffer);
               packetInvoker.invoke(_loc11_);
            }
            catch(e:Error)
            {
               if(_loc11_ == null)
               {
                  //LogService(OSGi.getInstance().getService(LogService)).getLogger("net").error("error packet does not exists: packetLength %1 packetId %2 \n\n",[_loc3_,_loc1_]);
               } else {
                  LogService(OSGi.getInstance().getService(LogService)).getLogger("net").error("error packet %1 packetLength %2 packetId %3 \n\n %4",[_loc11_,_loc3_,_loc1_,e.getStackTrace()]);
                  trace(e.message);
                  trace(e.getStackTrace());
               }
               _loc5_ = IRemoteLogging(OSGi.getInstance().getService(IRemoteLogging));
               _loc8_ = "";
               _loc6_ = describeType(_loc11_);
               for each(var _loc9_ in _loc6_.variable)
               {
                  _loc2_ = _loc9_.@name;
                  _loc8_ += _loc2_ + " -> " + _loc11_[_loc2_] + "\n";
               }
               _loc5_.log("[Network]\n" + e.getStackTrace() + "\n" + "packetId:" + _loc1_ + "\n" + "user:" + IUserPropertiesService(OSGi.getInstance().getService(IUserPropertiesService)).userName + " " + IUserPropertiesService(OSGi.getInstance().getService(IUserPropertiesService)).rank + "\n" + "Minutes-" + int(getTimer() / 1000 / 60) + "\n" + "PC: " + _loc8_ + "\n\n");
            }
            payloadBuffer.clear();
            if(this.inputBuffer.bytesAvailable == 0)
            {
               break;
            }
            this.readPosition = this.inputBuffer.position;
         }
         this.inputBuffer.clear();
         this.readPosition = 0;
      }
      
      private function closeSocket() : void
      {
         if(this.socket.connected)
         {
            this.socket.flush();
            this.socket.close();
         }
      }
      
      private function onClose(param1:Event) : void
      {
         var _loc4_:int = 0;
         closeSocket();
         var _loc3_:IDisplay = IDisplay(OSGi.getInstance().getService(IDisplay));
         _loc4_ = _loc3_.mainContainer.numChildren - 1;
         while(_loc4_ >= 0)
         {
            if(_loc3_.mainContainer.getChildAt(_loc4_) != _loc3_.backgroundLayer)
            {
               _loc3_.mainContainer.removeChildAt(_loc4_);
            }
            _loc4_--;
         }
         for each(var _loc2_ in OSGi.getInstance().serviceList)
         {
            if(_loc2_ is OnConnectionClosedServiceListener)
            {
               OnConnectionClosedServiceListener(_loc2_).onConnectionClosed(ConnectionCloseStatus.CLOSED_BY_SERVER);
            }
         }
         backgroundService.drawBg();
         backgroundService.showBg();
         IErrorMessageService(OSGi.getInstance().getService(IErrorMessageService)).showMessage(new ConnectionClosedError(ConnectionCloseStatus.CLOSED_BY_SERVER));
      }
      
      private function ioError(param1:IOErrorEvent) : void
      {
         closeSocket();
         if(!useExtraHost)
         {
            reconnectToExtraHost();
            return;
         }
         IErrorMessageService(OSGi.getInstance().getService(IErrorMessageService)).showMessage(new ConnectionClosedError(ConnectionCloseStatus.CONNECTION_ERROR));
         backgroundService.drawBg();
         backgroundService.showBg();
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         closeSocket();
         if(!useExtraHost)
         {
            reconnectToExtraHost();
            return;
         }
         IErrorMessageService(OSGi.getInstance().getService(IErrorMessageService)).showMessage(new ConnectionClosedError(ConnectionCloseStatus.CLOSED_BY_SERVER));
         backgroundService.drawBg();
         backgroundService.showBg();
      }
      
      public function setExtraHost(param1:String, param2:int) : void
      {
         extraHost = param1;
         extraPort = param2;
      }
      
      public function reconnectToExtraHost() : void
      {
         if(useExtraHost)
         {
            return;
         }
         closeSocket();
         OSGi.clientLog.log("net","Reconnecting to extra server");
         destroy();
         socket = new Socket();
         protocolInitializer.reset();
         useExtraHost = true;
         connect(extraHost,extraPort);
      }
   }
}

