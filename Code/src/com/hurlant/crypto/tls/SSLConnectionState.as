package com.hurlant.crypto.tls
{
   import com.hurlant.crypto.hash.MAC;
   import com.hurlant.crypto.symmetric.ICipher;
   import com.hurlant.crypto.symmetric.IVMode;
   import com.hurlant.util.ArrayUtil;
   import flash.utils.ByteArray;
   
   public class SSLConnectionState implements IConnectionState
   {
      
      private var bulkCipher:uint;
      
      private var cipherType:uint;
      
      private var CIPHER_key:ByteArray;
      
      private var CIPHER_IV:ByteArray;
      
      private var cipher:ICipher;
      
      private var ivmode:IVMode;
      
      private var macAlgorithm:uint;
      
      private var MAC_write_secret:ByteArray;
      
      private var mac:MAC;
      
      private var seq_lo:uint = 0;
      
      private var seq_hi:uint = 0;
      
      public function SSLConnectionState(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:ByteArray = null, param5:ByteArray = null, param6:ByteArray = null)
      {
         super();
         this.bulkCipher = param1;
         this.cipherType = param2;
         this.macAlgorithm = param3;
         this.MAC_write_secret = param4;
         this.mac = MACs.getMAC(param3);
         this.CIPHER_key = param5;
         this.CIPHER_IV = param6;
         this.cipher = BulkCiphers.getCipher(param1,param5,768);
         if(this.cipher is IVMode)
         {
            this.ivmode = this.cipher as IVMode;
            this.ivmode.IV = param6;
         }
      }
      
      public function decrypt(param1:uint, param2:uint, param3:ByteArray) : ByteArray
      {
         var _loc4_:ByteArray = null;
         var _loc5_:ByteArray = null;
         var _loc6_:uint = 0;
         var _loc7_:ByteArray = null;
         var _loc8_:ByteArray = null;
         if(this.cipherType == BulkCiphers.STREAM_CIPHER)
         {
            if(this.bulkCipher != BulkCiphers.NULL)
            {
               this.cipher.decrypt(param3);
            }
         }
         else
         {
            param3.position = 0;
            if(this.bulkCipher != BulkCiphers.NULL)
            {
               _loc4_ = new ByteArray();
               _loc4_.writeBytes(param3,param3.length - this.CIPHER_IV.length,this.CIPHER_IV.length);
               param3.position = 0;
               this.cipher.decrypt(param3);
               this.CIPHER_IV = _loc4_;
               this.ivmode.IV = _loc4_;
            }
         }
         if(this.macAlgorithm != MACs.NULL)
         {
            _loc5_ = new ByteArray();
            _loc6_ = uint(param3.length - this.mac.getHashSize());
            _loc5_.writeUnsignedInt(this.seq_hi);
            _loc5_.writeUnsignedInt(this.seq_lo);
            _loc5_.writeByte(param1);
            _loc5_.writeShort(_loc6_);
            if(_loc6_ != 0)
            {
               _loc5_.writeBytes(param3,0,_loc6_);
            }
            _loc7_ = this.mac.compute(this.MAC_write_secret,_loc5_);
            _loc8_ = new ByteArray();
            _loc8_.writeBytes(param3,_loc6_,this.mac.getHashSize());
            if(!ArrayUtil.equals(_loc7_,_loc8_))
            {
               throw new TLSError("Bad Mac Data",TLSError.bad_record_mac);
            }
            param3.length = _loc6_;
            param3.position = 0;
         }
         ++this.seq_lo;
         if(this.seq_lo == 0)
         {
            ++this.seq_hi;
         }
         return param3;
      }
      
      public function encrypt(param1:uint, param2:ByteArray) : ByteArray
      {
         var _loc4_:ByteArray = null;
         var _loc5_:ByteArray = null;
         var _loc3_:ByteArray = null;
         if(this.macAlgorithm != MACs.NULL)
         {
            _loc4_ = new ByteArray();
            _loc4_.writeUnsignedInt(this.seq_hi);
            _loc4_.writeUnsignedInt(this.seq_lo);
            _loc4_.writeByte(param1);
            _loc4_.writeShort(param2.length);
            if(param2.length != 0)
            {
               _loc4_.writeBytes(param2);
            }
            _loc3_ = this.mac.compute(this.MAC_write_secret,_loc4_);
            param2.position = param2.length;
            param2.writeBytes(_loc3_);
         }
         param2.position = 0;
         if(this.cipherType == BulkCiphers.STREAM_CIPHER)
         {
            if(this.bulkCipher != BulkCiphers.NULL)
            {
               this.cipher.encrypt(param2);
            }
         }
         else
         {
            this.cipher.encrypt(param2);
            _loc5_ = new ByteArray();
            _loc5_.writeBytes(param2,param2.length - this.CIPHER_IV.length,this.CIPHER_IV.length);
            this.CIPHER_IV = _loc5_;
            this.ivmode.IV = _loc5_;
         }
         ++this.seq_lo;
         if(this.seq_lo == 0)
         {
            ++this.seq_hi;
         }
         return param2;
      }
   }
}

