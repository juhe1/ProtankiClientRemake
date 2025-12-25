package scpacker.networking.protocol.codec.primitive
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class BooleanCodec implements ICodec
   {
      public function BooleanCodec()
      {
         super();
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         param1.writeByte(!!param2 ? 1 : 0);
         return 1;
      }
      
      public function decode(param1:ByteArray) : Object
      {
         return param1[param1.position++] != 0;
      }
   }
}

