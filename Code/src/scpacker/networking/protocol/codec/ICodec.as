package scpacker.networking.protocol.codec
{
   import flash.utils.ByteArray;
   
   public interface ICodec
   {
      function encode(param1:ByteArray, param2:Object) : int;
      
      function decode(param1:ByteArray) : Object;
   }
}

