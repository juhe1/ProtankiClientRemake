package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.usercountry.UserCountryCC;
   import projects.tanks.client.panel.model.usercountry.CountryInfo;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecUserCountryCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = UserCountryCC;
      
      private var newname_4346__END:ICodec;
      
      private var newname_4347__END:ICodec;
      
      private var newname_4348__END:ICodec;
      
      public function CodecUserCountryCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4346__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecCountryInfo");
         this.newname_4347__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4348__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:UserCountryCC = new UserCountryCC();
         _loc2_.countries = this.newname_4346__END.decode(param1) as Vector.<CountryInfo>;
         _loc2_.defaultCountryCode = this.newname_4347__END.decode(param1) as String;
         _loc2_.locationCheckEnabled = this.newname_4348__END.decode(param1) as Boolean;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:UserCountryCC = UserCountryCC(param2);
         this.newname_4346__END.encode(param1,_loc3_.countries);
         this.newname_4347__END.encode(param1,_loc3_.defaultCountryCode);
         this.newname_4348__END.encode(param1,_loc3_.locationCheckEnabled);
         return 4;
      }
   }
}

