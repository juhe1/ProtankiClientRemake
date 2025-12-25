package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.referrals.ReferrerIncomeData;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecReferrerIncomeData implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = ReferrerIncomeData;
      
      private var newname_4407__END:ICodec;
      
      private var newname_4276__END:ICodec;
      
      public function CodecReferrerIncomeData(param1:ProtocolInitializer)
      {
         super();
         this.newname_4407__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4276__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:ReferrerIncomeData = new ReferrerIncomeData();
         _loc2_.income = this.newname_4407__END.decode(param1) as int;
         _loc2_.user = this.newname_4276__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ReferrerIncomeData = ReferrerIncomeData(param2);
         this.newname_4407__END.encode(param1,_loc3_.income);
         this.newname_4276__END.encode(param1,_loc3_.user);
         return 4;
      }
   }
}

