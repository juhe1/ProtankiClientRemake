package com.hurlant.crypto.tls
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.crypto.hash.SHA1;
   import com.hurlant.crypto.prng.TLSPRF;
   import com.hurlant.crypto.rsa.RSAKey;
   import flash.utils.ByteArray;
   
   public class TLSSecurityParameters implements ISecurityParameters
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      public static var USER_CERTIFICATE:String;
      
      public static const LOG_CHANNEL:String = "tlsengine";
      
      public static const COMPRESSION_NULL:uint = 0;
      
      public static var IGNORE_CN_MISMATCH:Boolean = true;
      
      public static var ENABLE_USER_CLIENT_CERTIFICATE:Boolean = false;
      
      public static const PROTOCOL_VERSION:uint = 769;
      
      private var cert:ByteArray;
      
      private var key:RSAKey;
      
      private var entity:uint;
      
      private var bulkCipher:uint;
      
      private var cipherType:uint;
      
      private var keySize:uint;
      
      private var keyMaterialLength:uint;
      
      private var IVSize:uint;
      
      private var macAlgorithm:uint;
      
      private var hashSize:uint;
      
      private var compression:uint;
      
      private var masterSecret:ByteArray;
      
      private var clientRandom:ByteArray;
      
      private var serverRandom:ByteArray;
      
      private var ignoreCNMismatch:Boolean = true;
      
      private var trustAllCerts:Boolean = false;
      
      private var trustSelfSigned:Boolean = false;
      
      private var tlsDebug:Boolean = false;
      
      public var keyExchange:uint;
      
      public function TLSSecurityParameters(param1:uint, param2:ByteArray = null, param3:RSAKey = null)
      {
         super();
         this.entity = param1;
         this.reset();
         this.key = param3;
         this.cert = param2;
      }
      
      public function get version() : uint
      {
         return PROTOCOL_VERSION;
      }
      
      public function reset() : void
      {
         this.bulkCipher = BulkCiphers.NULL;
         this.cipherType = BulkCiphers.BLOCK_CIPHER;
         this.macAlgorithm = MACs.NULL;
         this.compression = COMPRESSION_NULL;
         this.masterSecret = null;
      }
      
      public function getBulkCipher() : uint
      {
         return this.bulkCipher;
      }
      
      public function getCipherType() : uint
      {
         return this.cipherType;
      }
      
      public function getMacAlgorithm() : uint
      {
         return this.macAlgorithm;
      }
      
      public function setCipher(param1:uint) : void
      {
         this.bulkCipher = CipherSuites.getBulkCipher(param1);
         this.cipherType = BulkCiphers.getType(this.bulkCipher);
         this.keySize = BulkCiphers.getExpandedKeyBytes(this.bulkCipher);
         this.keyMaterialLength = BulkCiphers.getKeyBytes(this.bulkCipher);
         this.IVSize = BulkCiphers.getIVSize(this.bulkCipher);
         this.keyExchange = CipherSuites.getKeyExchange(param1);
         this.macAlgorithm = CipherSuites.getMac(param1);
         this.hashSize = MACs.getHashSize(this.macAlgorithm);
      }
      
      public function setCompression(param1:uint) : void
      {
         this.compression = param1;
      }
      
      public function setPreMasterSecret(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(this.clientRandom,0,this.clientRandom.length);
         _loc2_.writeBytes(this.serverRandom,0,this.serverRandom.length);
         var _loc3_:TLSPRF = new TLSPRF(param1,"master secret",_loc2_);
         this.masterSecret = new ByteArray();
         _loc3_.nextBytes(this.masterSecret,48);
         if(this.tlsDebug)
         {
         }
      }
      
      public function setClientRandom(param1:ByteArray) : void
      {
         this.clientRandom = param1;
      }
      
      public function setServerRandom(param1:ByteArray) : void
      {
         this.serverRandom = param1;
      }
      
      public function get useRSA() : Boolean
      {
         return KeyExchanges.useRSA(this.keyExchange);
      }
      
      public function computeVerifyData(param1:uint, param2:ByteArray) : ByteArray
      {
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:MD5 = new MD5();
         if(this.tlsDebug)
         {
         }
         _loc3_.writeBytes(_loc4_.hash(param2),0,_loc4_.getHashSize());
         var _loc5_:SHA1 = new SHA1();
         _loc3_.writeBytes(_loc5_.hash(param2),0,_loc5_.getHashSize());
         if(this.tlsDebug)
         {
         }
         var _loc6_:TLSPRF = new TLSPRF(this.masterSecret,param1 == TLSEngine.CLIENT ? "client finished" : "server finished",_loc3_);
         var _loc7_:ByteArray = new ByteArray();
         _loc6_.nextBytes(_loc7_,12);
         if(this.tlsDebug)
         {
            _loc7_.position = 0;
         }
         return _loc7_;
      }
      
      public function computeCertificateVerify(param1:uint, param2:ByteArray) : ByteArray
      {
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:MD5 = new MD5();
         _loc3_.writeBytes(_loc4_.hash(param2),0,_loc4_.getHashSize());
         var _loc5_:SHA1 = new SHA1();
         _loc3_.writeBytes(_loc5_.hash(param2),0,_loc5_.getHashSize());
         _loc3_.position = 0;
         var _loc6_:ByteArray = new ByteArray();
         this.key.sign(_loc3_,_loc6_,_loc3_.bytesAvailable);
         _loc6_.position = 0;
         return _loc6_;
      }
      
      public function getConnectionStates() : Object
      {
         var _loc1_:ByteArray = null;
         var _loc2_:TLSPRF = null;
         var _loc3_:ByteArray = null;
         var _loc4_:ByteArray = null;
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:ByteArray = null;
         var _loc8_:ByteArray = null;
         var _loc9_:TLSConnectionState = null;
         var _loc10_:TLSConnectionState = null;
         if(this.masterSecret != null)
         {
            _loc1_ = new ByteArray();
            _loc1_.writeBytes(this.serverRandom,0,this.serverRandom.length);
            _loc1_.writeBytes(this.clientRandom,0,this.clientRandom.length);
            _loc2_ = new TLSPRF(this.masterSecret,"key expansion",_loc1_);
            _loc3_ = new ByteArray();
            _loc2_.nextBytes(_loc3_,this.hashSize);
            _loc4_ = new ByteArray();
            _loc2_.nextBytes(_loc4_,this.hashSize);
            _loc5_ = new ByteArray();
            _loc2_.nextBytes(_loc5_,this.keyMaterialLength);
            _loc6_ = new ByteArray();
            _loc2_.nextBytes(_loc6_,this.keyMaterialLength);
            _loc7_ = new ByteArray();
            _loc2_.nextBytes(_loc7_,this.IVSize);
            _loc8_ = new ByteArray();
            _loc2_.nextBytes(_loc8_,this.IVSize);
            _loc9_ = new TLSConnectionState(this.bulkCipher,this.cipherType,this.macAlgorithm,_loc3_,_loc5_,_loc7_);
            _loc10_ = new TLSConnectionState(this.bulkCipher,this.cipherType,this.macAlgorithm,_loc4_,_loc6_,_loc8_);
            if(this.entity == TLSEngine.CLIENT)
            {
               return {
                  "read":_loc10_,
                  "write":_loc9_
               };
            }
            return {
               "read":_loc9_,
               "write":_loc10_
            };
         }
         return {
            "read":new TLSConnectionState(),
            "write":new TLSConnectionState()
         };
      }
   }
}

