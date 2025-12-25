package alternativa.protocol.impl
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.*;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.codec.complex.ByteArrayCodec;
   import alternativa.protocol.codec.complex.StringCodec;
   import alternativa.protocol.codec.primitive.BooleanCodec;
   import alternativa.protocol.codec.primitive.ByteCodec;
   import alternativa.protocol.codec.primitive.DoubleCodec;
   import alternativa.protocol.codec.primitive.FloatCodec;
   import alternativa.protocol.codec.primitive.IntCodec;
   import alternativa.protocol.codec.primitive.LongCodec;
   import alternativa.protocol.codec.primitive.ShortCodec;
   import alternativa.protocol.codec.primitive.UIntCodec;
   import alternativa.protocol.codec.primitive.UShortCodec;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.Float;
   import alternativa.types.Long;
   import alternativa.types.Short;
   import alternativa.types.UShort;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class Protocol implements IProtocol
   {
      
      public static var defaultInstance:IProtocol = new Protocol();
      
      public function Protocol()
      {
         super();
      }
      
      public function registerCodec(param1:ICodecInfo, param2:ICodec) : void
      {
      }
      
      public function registerCodecForType(param1:Class, param2:ICodec) : void
      {
      }
      
      public function getCodec(param1:ICodecInfo) : ICodec
      {
         return null;
      }
      
      public function makeCodecInfo(param1:Class) : ICodecInfo
      {
         return null;
      }
      
      public function decode(param1:Class, param2:ByteArray) : *
      {
      }
   }
}

