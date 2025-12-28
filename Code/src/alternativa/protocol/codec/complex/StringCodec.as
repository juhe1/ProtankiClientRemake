package alternativa.protocol.codec.complex
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.impl.LengthCodecHelper;
   import flash.utils.ByteArray;
   
   public class StringCodec implements ICodec
   {
      
      public function StringCodec()
      {
         super();
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(String(param2));
         var _loc4_:int = int(_loc3_.length);
         LengthCodecHelper.encodeLength(param1,_loc4_);
         param1.writer.writeBytes(_loc3_,0,_loc4_);
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:int = LengthCodecHelper.decodeLength(param1);
         return param1.reader.readUTFBytes(_loc2_);
      }
      
      public function init(param1:IProtocol) : void
      {
      }
   }
}

