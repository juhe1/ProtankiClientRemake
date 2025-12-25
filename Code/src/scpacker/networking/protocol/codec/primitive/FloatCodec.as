package scpacker.networking.protocol.codec.primitive
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class FloatCodec implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = Number;
      
      public function FloatCodec()
      {
         super();
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         param1.writeFloat(Number(param2));
         return 4;
      }
      
      public function decode(param1:ByteArray) : Object
      {
         return param1.readFloat();
      }
   }
}

