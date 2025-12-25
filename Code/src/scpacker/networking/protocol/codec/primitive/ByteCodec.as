package scpacker.networking.protocol.codec.primitive
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class ByteCodec implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = int;
      
      public function ByteCodec()
      {
         super();
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         param1.writeByte(int(param2));
         return 1;
      }
      
      public function decode(param1:ByteArray) : Object
      {
         return param1.readByte();
      }
   }
}

