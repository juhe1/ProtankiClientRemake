package alternativa.protocol.codec.complex
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.impl.LengthCodecHelper;
   import flash.utils.ByteArray;
   
   public class ByteArrayCodec implements ICodec
   {
      
      public function ByteArrayCodec()
      {
         super();
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         var _loc3_:ByteArray = ByteArray(param2);
         LengthCodecHelper.encodeLength(param1,_loc3_.length);
         param1.writer.writeBytes(_loc3_);
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:int = LengthCodecHelper.decodeLength(param1);
         var _loc3_:ByteArray = new ByteArray();
         if(_loc2_ > 0)
         {
            param1.reader.readBytes(_loc3_,0,_loc2_);
         }
         return _loc3_;
      }
      
      public function init(param1:IProtocol) : void
      {
      }
   }
}

