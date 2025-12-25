package alternativa.protocol
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public interface IProtocol
   {
      
      function registerCodec(param1:ICodecInfo, param2:ICodec) : void;
      
      function registerCodecForType(param1:Class, param2:ICodec) : void;
      
      function getCodec(param1:ICodecInfo) : ICodec;
      
      function makeCodecInfo(param1:Class) : ICodecInfo;
      
      function decode(param1:Class, param2:ByteArray) : *;
   }
}

