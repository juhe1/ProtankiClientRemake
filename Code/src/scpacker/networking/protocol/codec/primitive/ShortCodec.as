package scpacker.networking.protocol.codec.primitive
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class ShortCodec implements ICodec
   {
      public const optionalVector:Boolean = true;
      
      public const element:Class = int;
      
      public function ShortCodec()
      {
         super();
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         param1.writeShort(int(param2));
         return 2;
      }
      
      public function decode(param1:ByteArray) : Object
      {
         return param1.readShort();
      }
   }
}

