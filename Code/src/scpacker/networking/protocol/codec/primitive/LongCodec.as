package scpacker.networking.protocol.codec.primitive
{
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class LongCodec implements ICodec
   {
      public function LongCodec()
      {
         super();
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc3_:* = Long(param2);
         param1.writeInt(_loc3_.d4654483);
         var _loc4_:*;
         param1.writeInt((_loc4_ = Long(param2)).dcfdc04);
         return 8;
      }
      
      public function decode(param1:ByteArray) : Object
      {
         return Long.getLong(param1.readInt(),param1.readInt());
      }
   }
}

