package scpacker.networking.protocol.codec.custom
{
   import platform.client.core.general.resourcelocale.format.ImagePair;
   import platform.client.core.general.resourcelocale.format.LocalizedFileFormat;
   import platform.client.core.general.resourcelocale.format.StringPair;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecLocalizedFileFormat implements ICodec
   {
      private var newname_4526__END:ICodec;
      
      private var newname_4527__END:ICodec;
      
      public function CodecLocalizedFileFormat(param1:ProtocolInitializer)
      {
         super();
         this.newname_4526__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecImagePair");
         this.newname_4527__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecStringPair");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:LocalizedFileFormat = new LocalizedFileFormat();
         _loc2_.images = this.newname_4526__END.decode(param1) as Vector.<ImagePair>;
         _loc2_.strings = this.newname_4527__END.decode(param1) as Vector.<StringPair>;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:LocalizedFileFormat = LocalizedFileFormat(param2);
         this.newname_4526__END.encode(param1,_loc3_.images);
         this.newname_4527__END.encode(param1,_loc3_.strings);
         return 4;
      }
   }
}

