package com.hurlant.crypto.tls
{
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.crypto.hash.SHA1;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class SSLSecurityParameters implements ISecurityParameters
   {
      
      public static const COMPRESSION_NULL:uint = 0;
      
      public static const PROTOCOL_VERSION:uint = 768;
      
      private var entity:uint;
      
      private var bulkCipher:uint;
      
      private var cipherType:uint;
      
      private var keySize:uint;
      
      private var keyMaterialLength:uint;
      
      private var keyBlock:ByteArray;
      
      private var IVSize:uint;
      
      private var MAC_length:uint;
      
      private var macAlgorithm:uint;
      
      private var hashSize:uint;
      
      private var compression:uint;
      
      private var masterSecret:ByteArray;
      
      private var clientRandom:ByteArray;
      
      private var serverRandom:ByteArray;
      
      private var pad_1:ByteArray;
      
      private var pad_2:ByteArray;
      
      private var ignoreCNMismatch:Boolean = true;
      
      private var trustAllCerts:Boolean = false;
      
      private var trustSelfSigned:Boolean = false;
      
      public var keyExchange:uint;
      
      public function SSLSecurityParameters(param1:uint, param2:ByteArray = null, param3:ByteArray = null)
      {
         super();
         this.entity = param1;
         this.reset();
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
         this.pad_1 = new ByteArray();
         this.pad_2 = new ByteArray();
         var _loc2_:int = 0;
         while(_loc2_ < 48)
         {
            this.pad_1.writeByte(54);
            this.pad_2.writeByte(92);
            _loc2_++;
         }
      }
      
      public function setCompression(param1:uint) : void
      {
         this.compression = param1;
      }
      
      public function setPreMasterSecret(param1:ByteArray) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:ByteArray = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:ByteArray = new ByteArray();
         var _loc8_:SHA1 = new SHA1();
         var _loc9_:MD5 = new MD5();
         var _loc10_:ByteArray = new ByteArray();
         _loc10_.writeBytes(param1);
         _loc10_.writeBytes(this.clientRandom);
         _loc10_.writeBytes(this.serverRandom);
         this.masterSecret = new ByteArray();
         var _loc11_:uint = 65;
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc2_.position = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc6_ + 1)
            {
               _loc2_.writeByte(_loc11_);
               _loc7_++;
            }
            _loc11_++;
            _loc2_.writeBytes(_loc10_);
            _loc4_ = _loc8_.hash(_loc2_);
            _loc3_.position = 0;
            _loc3_.writeBytes(param1);
            _loc3_.writeBytes(_loc4_);
            _loc5_ = _loc9_.hash(_loc3_);
            this.masterSecret.writeBytes(_loc5_);
            _loc6_++;
         }
         _loc10_.position = 0;
         _loc10_.writeBytes(this.masterSecret);
         _loc10_.writeBytes(this.serverRandom);
         _loc10_.writeBytes(this.clientRandom);
         this.keyBlock = new ByteArray();
         _loc2_ = new ByteArray();
         _loc3_ = new ByteArray();
         _loc11_ = 65;
         _loc6_ = 0;
         while(_loc6_ < 16)
         {
            _loc2_.position = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc6_ + 1)
            {
               _loc2_.writeByte(_loc11_);
               _loc7_++;
            }
            _loc11_++;
            _loc2_.writeBytes(_loc10_);
            _loc4_ = _loc8_.hash(_loc2_);
            _loc3_.position = 0;
            _loc3_.writeBytes(this.masterSecret);
            _loc3_.writeBytes(_loc4_,0);
            _loc5_ = _loc9_.hash(_loc3_);
            this.keyBlock.writeBytes(_loc5_);
            _loc6_++;
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
         var _loc7_:ByteArray = null;
         var _loc9_:ByteArray = null;
         var _loc10_:ByteArray = null;
         var _loc3_:SHA1 = new SHA1();
         var _loc4_:MD5 = new MD5();
         var _loc5_:ByteArray = new ByteArray();
         var _loc6_:ByteArray = new ByteArray();
         var _loc8_:ByteArray = new ByteArray();
         var _loc11_:ByteArray = new ByteArray();
         if(param1 == TLSEngine.CLIENT)
         {
            _loc11_.writeUnsignedInt(1129074260);
         }
         else
         {
            _loc11_.writeUnsignedInt(1397904978);
         }
         this.masterSecret.position = 0;
         _loc5_.writeBytes(param2);
         _loc5_.writeBytes(_loc11_);
         _loc5_.writeBytes(this.masterSecret);
         _loc5_.writeBytes(this.pad_1,0,40);
         _loc7_ = _loc3_.hash(_loc5_);
         _loc6_.writeBytes(this.masterSecret);
         _loc6_.writeBytes(this.pad_2,0,40);
         _loc6_.writeBytes(_loc7_);
         _loc9_ = _loc3_.hash(_loc6_);
         _loc5_ = new ByteArray();
         _loc5_.writeBytes(param2);
         _loc5_.writeBytes(_loc11_);
         _loc5_.writeBytes(this.masterSecret);
         _loc5_.writeBytes(this.pad_1);
         _loc7_ = _loc4_.hash(_loc5_);
         _loc6_ = new ByteArray();
         _loc6_.writeBytes(this.masterSecret);
         _loc6_.writeBytes(this.pad_2);
         _loc6_.writeBytes(_loc7_);
         _loc10_ = _loc4_.hash(_loc6_);
         _loc8_.writeBytes(_loc10_,0,_loc10_.length);
         _loc8_.writeBytes(_loc9_,0,_loc9_.length);
         var _loc12_:String = Hex.fromArray(_loc8_);
         _loc8_.position = 0;
         return _loc8_;
      }
      
      public function computeCertificateVerify(param1:uint, param2:ByteArray) : ByteArray
      {
         return null;
      }
      
      public function getConnectionStates() : Object
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:ByteArray = null;
         var _loc8_:ByteArray = null;
         var _loc9_:ByteArray = null;
         var _loc10_:SSLConnectionState = null;
         var _loc11_:SSLConnectionState = null;
         if(this.masterSecret != null)
         {
            _loc1_ = this.hashSize as Number;
            _loc2_ = this.keySize as Number;
            _loc3_ = this.IVSize as Number;
            _loc4_ = new ByteArray();
            _loc5_ = new ByteArray();
            _loc6_ = new ByteArray();
            _loc7_ = new ByteArray();
            _loc8_ = new ByteArray();
            _loc9_ = new ByteArray();
            this.keyBlock.position = 0;
            this.keyBlock.readBytes(_loc4_,0,_loc1_);
            this.keyBlock.readBytes(_loc5_,0,_loc1_);
            this.keyBlock.readBytes(_loc6_,0,_loc2_);
            this.keyBlock.readBytes(_loc7_,0,_loc2_);
            this.keyBlock.readBytes(_loc8_,0,_loc3_);
            this.keyBlock.readBytes(_loc9_,0,_loc3_);
            this.keyBlock.position = 0;
            _loc10_ = new SSLConnectionState(this.bulkCipher,this.cipherType,this.macAlgorithm,_loc4_,_loc6_,_loc8_);
            _loc11_ = new SSLConnectionState(this.bulkCipher,this.cipherType,this.macAlgorithm,_loc5_,_loc7_,_loc9_);
            if(this.entity == TLSEngine.CLIENT)
            {
               return {
                  "read":_loc11_,
                  "write":_loc10_
               };
            }
            return {
               "read":_loc10_,
               "write":_loc11_
            };
         }
         return {
            "read":new SSLConnectionState(),
            "write":new SSLConnectionState()
         };
      }
   }
}

