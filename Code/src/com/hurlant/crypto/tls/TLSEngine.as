package com.hurlant.crypto.tls
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import com.hurlant.crypto.cert.X509Certificate;
   import com.hurlant.crypto.cert.X509CertificateCollection;
   import com.hurlant.crypto.prng.Random;
   import com.hurlant.util.ArrayUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   [Event(name="data",type="com.hurlant.crypto.tls.TLSEvent")]
   [Event(name="ready",type="com.hurlant.crypto.tls.TLSEvent")]
   [Event(name="socketData",type="flash.events.ProgressEvent")]
   [Event(name="close",type="flash.events.Event")]
   public class TLSEngine extends EventDispatcher
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      public static const LOG_CHANNEL:String = "tlsengine";
      
      public static const SERVER:uint = 0;
      
      public static const CLIENT:uint = 1;
      
      private static const PROTOCOL_HANDSHAKE:uint = 22;
      
      private static const PROTOCOL_ALERT:uint = 21;
      
      private static const PROTOCOL_CHANGE_CIPHER_SPEC:uint = 20;
      
      private static const PROTOCOL_APPLICATION_DATA:uint = 23;
      
      private static const STATE_NEW:uint = 0;
      
      private static const STATE_NEGOTIATING:uint = 1;
      
      private static const STATE_READY:uint = 2;
      
      private static const STATE_CLOSED:uint = 3;
      
      private static const HANDSHAKE_HELLO_REQUEST:uint = 0;
      
      private static const HANDSHAKE_CLIENT_HELLO:uint = 1;
      
      private static const HANDSHAKE_SERVER_HELLO:uint = 2;
      
      private static const HANDSHAKE_CERTIFICATE:uint = 11;
      
      private static const HANDSHAKE_SERVER_KEY_EXCHANGE:uint = 12;
      
      private static const HANDSHAKE_CERTIFICATE_REQUEST:uint = 13;
      
      private static const HANDSHAKE_HELLO_DONE:uint = 14;
      
      private static const HANDSHAKE_CERTIFICATE_VERIFY:uint = 15;
      
      private static const HANDSHAKE_CLIENT_KEY_EXCHANGE:uint = 16;
      
      private static const HANDSHAKE_FINISHED:uint = 20;
      
      public var protocol_version:uint;
      
      private var _entity:uint;
      
      private var _config:TLSConfig;
      
      private var _state:uint;
      
      private var _securityParameters:ISecurityParameters;
      
      private var _currentReadState:IConnectionState;
      
      private var _currentWriteState:IConnectionState;
      
      private var _pendingReadState:IConnectionState;
      
      private var _pendingWriteState:IConnectionState;
      
      private var _handshakePayloads:ByteArray;
      
      private var _handshakeRecords:ByteArray;
      
      private var _iStream:IDataInput;
      
      private var _oStream:IDataOutput;
      
      private var _store:X509CertificateCollection;
      
      private var _otherCertificate:X509Certificate;
      
      private var _otherIdentity:String;
      
      private var _myCertficate:X509Certificate;
      
      private var _myIdentity:String;
      
      private var _packetQueue:Array = [];
      
      private var protocolHandlers:Object;
      
      private var handshakeHandlersServer:Object;
      
      private var handshakeHandlersClient:Object;
      
      private var _entityHandshakeHandlers:Object;
      
      private var _handshakeCanContinue:Boolean = true;
      
      private var _handshakeQueue:Array = [];
      
      private var sendClientCert:Boolean = false;
      
      private var _writeScheduler:uint;
      
      public function TLSEngine(param1:TLSConfig, param2:IDataInput, param3:IDataOutput, param4:String = null)
      {
         this.protocolHandlers = {
            23:this.parseApplicationData,
            22:this.parseHandshake,
            21:this.parseAlert,
            20:this.parseChangeCipherSpec
         };
         this.handshakeHandlersServer = {
            0:this.notifyStateError,
            1:this.parseHandshakeClientHello,
            2:this.notifyStateError,
            11:this.loadCertificates,
            12:this.notifyStateError,
            13:this.notifyStateError,
            14:this.notifyStateError,
            15:this.notifyStateError,
            16:this.parseHandshakeClientKeyExchange,
            20:this.verifyHandshake
         };
         this.handshakeHandlersClient = {
            0:this.parseHandshakeHello,
            1:this.notifyStateError,
            2:this.parseHandshakeServerHello,
            11:this.loadCertificates,
            12:this.parseServerKeyExchange,
            13:this.setStateRespondWithCertificate,
            14:this.sendClientAck,
            15:this.notifyStateError,
            16:this.notifyStateError,
            20:this.verifyHandshake
         };
         super();
         this._entity = param1.entity;
         this._config = param1;
         this._iStream = param2;
         this._oStream = param3;
         this._otherIdentity = param4;
         this._state = STATE_NEW;
         this._entityHandshakeHandlers = this._entity == CLIENT ? this.handshakeHandlersClient : this.handshakeHandlersServer;
         if(this._config.version == SSLSecurityParameters.PROTOCOL_VERSION)
         {
            this._securityParameters = new SSLSecurityParameters(this._entity);
         }
         else
         {
            this._securityParameters = new TLSSecurityParameters(this._entity,this._config.certificate,this._config.privateKey);
         }
         this.protocol_version = this._config.version;
         var _loc5_:Object = this._securityParameters.getConnectionStates();
         this._currentReadState = _loc5_.read;
         this._currentWriteState = _loc5_.write;
         this._handshakePayloads = new ByteArray();
         this._store = new X509CertificateCollection();
      }
      
      public function get peerCertificate() : X509Certificate
      {
         return this._otherCertificate;
      }
      
      public function start() : void
      {
         if(this._entity == CLIENT)
         {
            try
            {
               this.startHandshake();
            }
            catch(e:TLSError)
            {
               handleTLSError(e);
            }
         }
      }
      
      public function dataAvailable(param1:* = null) : void
      {
         var e:* = param1;
         if(this._state == STATE_CLOSED)
         {
            return;
         }
         try
         {
            this.parseRecord(this._iStream);
         }
         catch(e:TLSError)
         {
            handleTLSError(e);
         }
      }
      
      public function close(param1:TLSError = null) : void
      {
         if(this._state == STATE_CLOSED)
         {
            return;
         }
         var _loc2_:ByteArray = new ByteArray();
         if(param1 == null && this._state != STATE_READY)
         {
            _loc2_[0] = 1;
            _loc2_[1] = TLSError.user_canceled;
            this.sendRecord(PROTOCOL_ALERT,_loc2_);
         }
         _loc2_[0] = 2;
         if(param1 == null)
         {
            _loc2_[1] = TLSError.close_notify;
         }
         else
         {
            _loc2_[1] = param1.errorID;
         }
         this.sendRecord(PROTOCOL_ALERT,_loc2_);
         this._state = STATE_CLOSED;
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function parseRecord(param1:IDataInput) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Object = null;
         while(this._state != STATE_CLOSED && param1.bytesAvailable > 4)
         {
            if(this._packetQueue.length > 0)
            {
               _loc7_ = this._packetQueue.shift();
               _loc2_ = _loc7_.data;
               if(param1.bytesAvailable + _loc2_.length >= _loc7_.length)
               {
                  param1.readBytes(_loc2_,_loc2_.length,_loc7_.length - _loc2_.length);
                  this.parseOneRecord(_loc7_.type,_loc7_.length,_loc2_);
               }
               else
               {
                  param1.readBytes(_loc2_,_loc2_.length,param1.bytesAvailable);
                  this._packetQueue.push(_loc7_);
               }
            }
            else
            {
               _loc3_ = uint(param1.readByte());
               _loc4_ = uint(param1.readShort());
               _loc5_ = uint(param1.readShort());
               if(_loc5_ > 16384 + 2048)
               {
                  throw new TLSError("Excessive TLS Record length: " + _loc5_,TLSError.record_overflow);
               }
               if(_loc4_ != this._securityParameters.version)
               {
                  throw new TLSError("Unsupported TLS version: " + _loc4_.toString(16),TLSError.protocol_version);
               }
               _loc2_ = new ByteArray();
               _loc6_ = Math.min(param1.bytesAvailable,_loc5_);
               param1.readBytes(_loc2_,0,_loc6_);
               if(_loc6_ == _loc5_)
               {
                  this.parseOneRecord(_loc3_,_loc5_,_loc2_);
               }
               else
               {
                  this._packetQueue.push({
                     "type":_loc3_,
                     "length":_loc5_,
                     "data":_loc2_
                  });
               }
            }
         }
      }
      
      private function parseOneRecord(param1:uint, param2:uint, param3:ByteArray) : void
      {
         param3 = this._currentReadState.decrypt(param1,param2,param3);
         if(param3.length > 16384)
         {
            throw new TLSError("Excessive Decrypted TLS Record length: " + param3.length,TLSError.record_overflow);
         }
         if(this.protocolHandlers.hasOwnProperty(param1))
         {
            while(param3 != null)
            {
               param3 = this.protocolHandlers[param1](param3);
            }
            return;
         }
         throw new TLSError("Unsupported TLS Record Content Type: " + param1.toString(16),TLSError.unexpected_message);
      }
      
      private function startHandshake() : void
      {
         this._state = STATE_NEGOTIATING;
         this.sendClientHello();
      }
      
      private function parseHandshake(param1:ByteArray) : ByteArray
      {
         var _loc6_:ByteArray = null;
         if(param1.length < 4)
         {
            return null;
         }
         param1.position = 0;
         var _loc2_:ByteArray = param1;
         var _loc3_:uint = _loc2_.readUnsignedByte();
         var _loc4_:uint = _loc2_.readUnsignedByte();
         var _loc5_:uint = uint(_loc4_ << 16 | _loc2_.readUnsignedShort());
         if(_loc5_ + 4 > param1.length)
         {
            return null;
         }
         if(_loc3_ != HANDSHAKE_FINISHED)
         {
            this._handshakePayloads.writeBytes(param1,0,_loc5_ + 4);
         }
         if(this._entityHandshakeHandlers.hasOwnProperty(_loc3_))
         {
            if(this._entityHandshakeHandlers[_loc3_] is Function)
            {
               this._entityHandshakeHandlers[_loc3_](_loc2_);
            }
            if(_loc5_ + 4 < param1.length)
            {
               _loc6_ = new ByteArray();
               _loc6_.writeBytes(param1,_loc5_ + 4,param1.length - (_loc5_ + 4));
               return _loc6_;
            }
            return null;
         }
         throw new TLSError("Unimplemented or unknown handshake type!",TLSError.internal_error);
      }
      
      private function notifyStateError(param1:ByteArray) : void
      {
         throw new TLSError("Invalid handshake state for a TLS Entity type of " + this._entity,TLSError.internal_error);
      }
      
      private function parseClientKeyExchange(param1:ByteArray) : void
      {
         throw new TLSError("ClientKeyExchange is currently unimplemented!",TLSError.internal_error);
      }
      
      private function parseServerKeyExchange(param1:ByteArray) : void
      {
         throw new TLSError("ServerKeyExchange is currently unimplemented!",TLSError.internal_error);
      }
      
      private function verifyHandshake(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         if(this._securityParameters.version == SSLSecurityParameters.PROTOCOL_VERSION)
         {
            param1.readBytes(_loc2_,0,36);
         }
         else
         {
            param1.readBytes(_loc2_,0,12);
         }
         var _loc3_:ByteArray = this._securityParameters.computeVerifyData(1 - this._entity,this._handshakePayloads);
         if(ArrayUtil.equals(_loc2_,_loc3_))
         {
            this._state = STATE_READY;
            dispatchEvent(new TLSEvent(TLSEvent.READY));
            return;
         }
         throw new TLSError("Invalid Finished mac.",TLSError.bad_record_mac);
      }
      
      private function parseHandshakeHello(param1:ByteArray) : void
      {
         if(this._state != STATE_READY)
         {
            return;
         }
         this._handshakePayloads = new ByteArray();
         this.startHandshake();
      }
      
      private function parseHandshakeClientKeyExchange(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:ByteArray = null;
         var _loc5_:Object = null;
         if(this._securityParameters.useRSA)
         {
            _loc2_ = uint(param1.readShort());
            _loc3_ = new ByteArray();
            param1.readBytes(_loc3_,0,_loc2_);
            _loc4_ = new ByteArray();
            this._config.privateKey.decrypt(_loc3_,_loc4_,_loc2_);
            this._securityParameters.setPreMasterSecret(_loc4_);
            _loc5_ = this._securityParameters.getConnectionStates();
            this._pendingReadState = _loc5_.read;
            this._pendingWriteState = _loc5_.write;
            return;
         }
         throw new TLSError("parseHandshakeClientKeyExchange not implemented for DH modes.",TLSError.internal_error);
      }
      
      private function parseHandshakeServerHello(param1:IDataInput) : void
      {
         var _loc2_:uint = uint(param1.readShort());
         if(_loc2_ != this._securityParameters.version)
         {
            throw new TLSError("Unsupported TLS version: " + _loc2_.toString(16),TLSError.protocol_version);
         }
         var _loc3_:ByteArray = new ByteArray();
         param1.readBytes(_loc3_,0,32);
         var _loc4_:uint = uint(param1.readByte());
         var _loc5_:ByteArray = new ByteArray();
         if(_loc4_ > 0)
         {
            param1.readBytes(_loc5_,0,_loc4_);
         }
         this._securityParameters.setCipher(param1.readShort());
         this._securityParameters.setCompression(param1.readByte());
         this._securityParameters.setServerRandom(_loc3_);
      }
      
      private function parseHandshakeClientHello(param1:IDataInput) : void
      {
         var _loc2_:Object = null;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:ByteArray = null;
         var _loc3_:uint = uint(param1.readShort());
         if(_loc3_ != this._securityParameters.version)
         {
            throw new TLSError("Unsupported TLS version: " + _loc3_.toString(16),TLSError.protocol_version);
         }
         var _loc4_:ByteArray = new ByteArray();
         param1.readBytes(_loc4_,0,32);
         var _loc5_:uint = uint(param1.readByte());
         var _loc6_:ByteArray = new ByteArray();
         if(_loc5_ > 0)
         {
            param1.readBytes(_loc6_,0,_loc5_);
         }
         var _loc7_:Array = [];
         var _loc8_:uint = uint(param1.readShort());
         var _loc9_:uint = 0;
         while(_loc9_ < _loc8_ / 2)
         {
            _loc7_.push(param1.readShort());
            _loc9_++;
         }
         var _loc10_:Array = [];
         var _loc11_:uint = uint(param1.readByte());
         _loc9_ = 0;
         while(_loc9_ < _loc11_)
         {
            _loc10_.push(param1.readByte());
            _loc9_++;
         }
         _loc2_ = {
            "random":_loc4_,
            "session":_loc6_,
            "suites":_loc7_,
            "compressions":_loc10_
         };
         var _loc12_:uint = uint(2 + 32 + 1 + _loc5_ + 2 + _loc8_ + 1 + _loc11_);
         var _loc13_:Array = [];
         if(_loc12_ < length)
         {
            _loc14_ = uint(param1.readShort());
            while(_loc14_ > 0)
            {
               _loc15_ = uint(param1.readShort());
               _loc16_ = uint(param1.readShort());
               _loc17_ = new ByteArray();
               param1.readBytes(_loc17_,0,_loc16_);
               _loc14_ -= 4 + _loc16_;
               _loc13_.push({
                  "type":_loc15_,
                  "length":_loc16_,
                  "data":_loc17_
               });
            }
         }
         _loc2_.ext = _loc13_;
         this.sendServerHello(_loc2_);
         this.sendCertificate();
         this.sendServerHelloDone();
      }
      
      private function sendClientHello() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeShort(this._securityParameters.version);
         var _loc2_:Random = new Random();
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.nextBytes(_loc3_,32);
         this._securityParameters.setClientRandom(_loc3_);
         _loc1_.writeBytes(_loc3_,0,32);
         _loc1_.writeByte(32);
         _loc2_.nextBytes(_loc1_,32);
         var _loc4_:Array = this._config.cipherSuites;
         _loc1_.writeShort(2 * _loc4_.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_.writeShort(_loc4_[_loc5_]);
            _loc5_++;
         }
         _loc4_ = this._config.compressions;
         _loc1_.writeByte(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_.writeByte(_loc4_[_loc5_]);
            _loc5_++;
         }
         _loc1_.position = 0;
         this.sendHandshake(HANDSHAKE_CLIENT_HELLO,_loc1_.length,_loc1_);
      }
      
      private function findMatch(param1:Array, param2:Array) : int
      {
         var _loc4_:uint = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = uint(param1[_loc3_]);
            if(param2.indexOf(_loc4_) > -1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function sendServerHello(param1:Object) : void
      {
         var _loc2_:int = this.findMatch(this._config.cipherSuites,param1.suites);
         if(_loc2_ == -1)
         {
            throw new TLSError("No compatible cipher found.",TLSError.handshake_failure);
         }
         this._securityParameters.setCipher(_loc2_);
         var _loc3_:int = this.findMatch(this._config.compressions,param1.compressions);
         if(_loc3_ == 1)
         {
            throw new TLSError("No compatible compression method found.",TLSError.handshake_failure);
         }
         this._securityParameters.setCompression(_loc3_);
         this._securityParameters.setClientRandom(param1.random);
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeShort(this._securityParameters.version);
         var _loc5_:Random = new Random();
         var _loc6_:ByteArray = new ByteArray();
         _loc5_.nextBytes(_loc6_,32);
         this._securityParameters.setServerRandom(_loc6_);
         _loc4_.writeBytes(_loc6_,0,32);
         _loc4_.writeByte(32);
         _loc5_.nextBytes(_loc4_,32);
         _loc4_.writeShort(param1.suites[0]);
         _loc4_.writeByte(param1.compressions[0]);
         _loc4_.position = 0;
         this.sendHandshake(HANDSHAKE_SERVER_HELLO,_loc4_.length,_loc4_);
      }
      
      private function setStateRespondWithCertificate(param1:ByteArray = null) : void
      {
         this.sendClientCert = true;
      }
      
      private function sendCertificate(param1:ByteArray = null) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc2_:ByteArray = this._config.certificate;
         var _loc5_:ByteArray = new ByteArray();
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.length;
            _loc4_ = uint(_loc2_.length + 3);
            _loc5_.writeByte(_loc4_ >> 16);
            _loc5_.writeShort(_loc4_ & 0xFFFF);
            _loc5_.writeByte(_loc3_ >> 16);
            _loc5_.writeShort(_loc3_ & 0xFFFF);
            _loc5_.writeBytes(_loc2_);
         }
         else
         {
            _loc5_.writeShort(0);
            _loc5_.writeByte(0);
         }
         _loc5_.position = 0;
         this.sendHandshake(HANDSHAKE_CERTIFICATE,_loc5_.length,_loc5_);
      }
      
      private function sendCertificateVerify() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:ByteArray = this._securityParameters.computeCertificateVerify(this._entity,this._handshakePayloads);
         _loc2_.position = 0;
         this.sendHandshake(HANDSHAKE_CERTIFICATE_VERIFY,_loc2_.length,_loc2_);
      }
      
      private function sendServerHelloDone() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         this.sendHandshake(HANDSHAKE_HELLO_DONE,_loc1_.length,_loc1_);
      }
      
      private function sendClientKeyExchange() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:Random = null;
         var _loc3_:ByteArray = null;
         var _loc4_:ByteArray = null;
         var _loc5_:ByteArray = null;
         var _loc6_:Object = null;
         if(this._securityParameters.useRSA)
         {
            _loc1_ = new ByteArray();
            _loc1_.writeShort(this._securityParameters.version);
            _loc2_ = new Random();
            _loc2_.nextBytes(_loc1_,46);
            _loc1_.position = 0;
            _loc3_ = new ByteArray();
            _loc3_.writeBytes(_loc1_,0,_loc1_.length);
            _loc3_.position = 0;
            this._securityParameters.setPreMasterSecret(_loc3_);
            _loc4_ = new ByteArray();
            this._otherCertificate.getPublicKey().encrypt(_loc3_,_loc4_,_loc3_.length);
            _loc4_.position = 0;
            _loc5_ = new ByteArray();
            if(this._securityParameters.version > 768)
            {
               _loc5_.writeShort(_loc4_.length);
            }
            _loc5_.writeBytes(_loc4_,0,_loc4_.length);
            _loc5_.position = 0;
            this.sendHandshake(HANDSHAKE_CLIENT_KEY_EXCHANGE,_loc5_.length,_loc5_);
            _loc6_ = this._securityParameters.getConnectionStates();
            this._pendingReadState = _loc6_.read;
            this._pendingWriteState = _loc6_.write;
            return;
         }
         throw new TLSError("Non-RSA Client Key Exchange not implemented.",TLSError.internal_error);
      }
      
      private function sendFinished() : void
      {
         var _loc1_:ByteArray = this._securityParameters.computeVerifyData(this._entity,this._handshakePayloads);
         _loc1_.position = 0;
         this.sendHandshake(HANDSHAKE_FINISHED,_loc1_.length,_loc1_);
      }
      
      private function sendHandshake(param1:uint, param2:uint, param3:IDataInput) : void
      {
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeByte(param1);
         _loc4_.writeByte(0);
         _loc4_.writeShort(param2);
         param3.readBytes(_loc4_,_loc4_.position,param2);
         this._handshakePayloads.writeBytes(_loc4_,0,_loc4_.length);
         this.sendRecord(PROTOCOL_HANDSHAKE,_loc4_);
      }
      
      private function sendChangeCipherSpec() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_[0] = 1;
         this.sendRecord(PROTOCOL_CHANGE_CIPHER_SPEC,_loc1_);
         this._currentWriteState = this._pendingWriteState;
         this._pendingWriteState = null;
      }
      
      public function sendApplicationData(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void
      {
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:uint = param3;
         if(_loc5_ == 0)
         {
            _loc5_ = param1.length;
         }
         while(_loc5_ > 16384)
         {
            _loc4_.position = 0;
            _loc4_.writeBytes(param1,param2,16384);
            _loc4_.position = 0;
            this.sendRecord(PROTOCOL_APPLICATION_DATA,_loc4_);
            param2 += 16384;
            _loc5_ -= 16384;
         }
         _loc4_.position = 0;
         _loc4_.writeBytes(param1,param2,_loc5_);
         _loc4_.position = 0;
         this.sendRecord(PROTOCOL_APPLICATION_DATA,_loc4_);
      }
      
      private function sendRecord(param1:uint, param2:ByteArray) : void
      {
         param2 = this._currentWriteState.encrypt(param1,param2);
         this._oStream.writeByte(param1);
         this._oStream.writeShort(this._securityParameters.version);
         this._oStream.writeShort(param2.length);
         this._oStream.writeBytes(param2,0,param2.length);
         this.scheduleWrite();
      }
      
      private function scheduleWrite() : void
      {
         if(this._writeScheduler != 0)
         {
            return;
         }
         this._writeScheduler = setTimeout(this.commitWrite,0);
      }
      
      private function commitWrite() : void
      {
         clearTimeout(this._writeScheduler);
         this._writeScheduler = 0;
         if(this._state != STATE_CLOSED)
         {
            dispatchEvent(new ProgressEvent(ProgressEvent.SOCKET_DATA));
         }
      }
      
      private function sendClientAck(param1:ByteArray) : void
      {
         if(this._handshakeCanContinue)
         {
            if(this.sendClientCert)
            {
               this.sendCertificate();
            }
            this.sendClientKeyExchange();
            if(this._config.certificate != null)
            {
               this.sendCertificateVerify();
            }
            this.sendChangeCipherSpec();
            this.sendFinished();
         }
      }
      
      private function loadCertificates(param1:ByteArray) : void
      {
         var _loc7_:Boolean = false;
         var _loc8_:uint = 0;
         var _loc9_:ByteArray = null;
         var _loc10_:X509Certificate = null;
         var _loc11_:String = null;
         var _loc12_:RegExp = null;
         var _loc2_:uint = uint(param1.readByte());
         var _loc3_:uint = uint(_loc2_ << 16 | param1.readShort());
         var _loc4_:Array = [];
         while(_loc3_ > 0)
         {
            _loc2_ = uint(param1.readByte());
            _loc8_ = uint(_loc2_ << 16 | param1.readShort());
            _loc9_ = new ByteArray();
            param1.readBytes(_loc9_,0,_loc8_);
            _loc4_.push(_loc9_);
            _loc3_ -= 3 + _loc8_;
         }
         var _loc5_:X509Certificate = null;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc10_ = new X509Certificate(_loc4_[_loc6_]);
            this._store.addCertificate(_loc10_);
            if(_loc5_ == null)
            {
               _loc5_ = _loc10_;
            }
            _loc6_++;
         }
         if(this._config.trustAllCertificates)
         {
            _loc7_ = true;
         }
         else if(this._config.trustSelfSignedCertificates)
         {
            _loc7_ = _loc5_.isSelfSigned(new Date());
         }
         else
         {
            _loc7_ = _loc5_.isSigned(this._store,this._config.CAStore);
         }
         if(_loc7_)
         {
            if(this._otherIdentity == null || this._config.ignoreCommonNameMismatch)
            {
               this._otherCertificate = _loc5_;
            }
            else
            {
               _loc11_ = _loc5_.getCommonName();
               _loc12_ = new RegExp(_loc11_.replace(/[\^\\\-$.[\]|()?+{}]/g,"\\$&").replace(/\*/g,"[^.]+"),"gi");
               if(_loc12_.exec(this._otherIdentity))
               {
                  this._otherCertificate = _loc5_;
               }
               else
               {
                  if(!this._config.promptUserForAcceptCert)
                  {
                     throw new TLSError("Invalid common name: " + _loc5_.getCommonName() + ", expected " + this._otherIdentity,TLSError.bad_certificate);
                  }
                  this._handshakeCanContinue = false;
                  dispatchEvent(new TLSEvent(TLSEvent.PROMPT_ACCEPT_CERT));
               }
            }
         }
         else
         {
            if(!this._config.promptUserForAcceptCert)
            {
               throw new TLSError("Cannot verify certificate",TLSError.bad_certificate);
            }
            this._handshakeCanContinue = false;
            dispatchEvent(new TLSEvent(TLSEvent.PROMPT_ACCEPT_CERT));
         }
      }
      
      public function acceptPeerCertificate() : void
      {
         this._handshakeCanContinue = true;
         this.sendClientAck(null);
      }
      
      public function rejectPeerCertificate() : void
      {
         throw new TLSError("Peer certificate not accepted!",TLSError.bad_certificate);
      }
      
      private function parseAlert(param1:ByteArray) : void
      {
         this.close();
      }
      
      private function parseChangeCipherSpec(param1:ByteArray) : void
      {
         param1.readUnsignedByte();
         if(this._pendingReadState == null)
         {
            throw new TLSError("Not ready to Change Cipher Spec, damnit.",TLSError.unexpected_message);
         }
         this._currentReadState = this._pendingReadState;
         this._pendingReadState = null;
      }
      
      private function parseApplicationData(param1:ByteArray) : void
      {
         if(this._state != STATE_READY)
         {
            throw new TLSError("Too soon for data!",TLSError.unexpected_message);
         }
         dispatchEvent(new TLSEvent(TLSEvent.DATA,param1));
      }
      
      private function handleTLSError(param1:TLSError) : void
      {
         this.close(param1);
      }
   }
}

