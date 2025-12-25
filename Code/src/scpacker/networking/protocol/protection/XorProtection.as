package scpacker.networking.protocol.protection
{
   import flash.utils.ByteArray;
   
   public class XorProtection implements IProtection
   {
      private static const VECTOR_SIZE:int = 8;
      
      private var encodeKeyVector:Vector.<int> = new Vector.<int>(8,true);
      
      private var decodeKeyVector:Vector.<int> = new Vector.<int>(8,true);
      
      private var encodeKeyIndex:int = 0;
      
      private var decodeKeyIndex:int = 0;
      
      private var seedValue:int;
      
      public function XorProtection(param1:Vector.<int>)
      {
         super();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            seedValue ^= param1[_loc2_];
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            decodeKeyVector[_loc2_] = seedValue ^ _loc2_ << 3;
            encodeKeyVector[_loc2_] = seedValue ^ _loc2_ << 3 ^ 0x57;
            _loc2_++;
         }
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = int(param1.length);
         while(_loc3_ < _loc2_)
         {
            _loc4_ = int(param1[_loc3_]);
            param1[_loc3_] = _loc4_ ^ encodeKeyVector[encodeKeyIndex];
            encodeKeyVector[encodeKeyIndex] = _loc4_;
            encodeKeyIndex ^= _loc4_ & 7;
            _loc3_++;
         }
      }
      
      public function decrypt(param1:ByteArray, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = int(param1.length);
         while(_loc4_ < param2)
         {
            decodeKeyVector[decodeKeyIndex] = param1[_loc4_] ^ decodeKeyVector[decodeKeyIndex];
            param1[_loc4_] = decodeKeyVector[decodeKeyIndex];
            decodeKeyIndex ^= decodeKeyVector[decodeKeyIndex] & 7;
            _loc4_++;
         }
      }
   }
}

