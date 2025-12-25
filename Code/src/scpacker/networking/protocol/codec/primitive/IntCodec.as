package scpacker.networking.protocol.codec.primitive
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class IntCodec implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = int;
      
      public function IntCodec()
      {
         super();
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         param1.writeInt(int(param2));
         return 4;
      }
      
      public function decode(param1:ByteArray) : Object
      {
         return param1.readInt();
      }
   }
}

