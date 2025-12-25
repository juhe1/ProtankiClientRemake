package scpacker.networking.protocol.codec.custom
{
   import platform.client.core.general.resourcelocale.format.StringPair;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecStringPair implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = StringPair;
      
      private var newname_4337__END:ICodec;
      
      private var newname_4338__END:ICodec;
      
      public function CodecStringPair(param1:ProtocolInitializer)
      {
         super();
         this.newname_4337__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4338__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:StringPair = new StringPair();
         _loc2_.key = this.newname_4337__END.decode(param1) as String;
         _loc2_.value = this.newname_4338__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:StringPair = StringPair(param2);
         this.newname_4337__END.encode(param1,_loc3_.key);
         this.newname_4338__END.encode(param1,_loc3_.value);
         return 4;
      }
   }
}

