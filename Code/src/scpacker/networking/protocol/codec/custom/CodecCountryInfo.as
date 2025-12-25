package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.usercountry.CountryInfo;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecCountryInfo implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = CountryInfo;
      
      private var newname_4100__END:ICodec;
      
      private var newname_4101__END:ICodec;
      
      public function CodecCountryInfo(param1:ProtocolInitializer)
      {
         super();
         this.newname_4100__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4101__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:CountryInfo = new CountryInfo();
         _loc2_.countryCode = this.newname_4100__END.decode(param1) as String;
         _loc2_.countryName = this.newname_4101__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:CountryInfo = CountryInfo(param2);
         this.newname_4100__END.encode(param1,_loc3_.countryCode);
         this.newname_4101__END.encode(param1,_loc3_.countryName);
         return 4;
      }
   }
}

