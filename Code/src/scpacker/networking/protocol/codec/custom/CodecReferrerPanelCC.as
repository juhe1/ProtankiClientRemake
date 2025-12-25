package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.referrals.ReferrerPanelCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecReferrerPanelCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = ReferrerPanelCC;
      
      private var newname_4302__END:ICodec;
      
      private var newname_4303__END:ICodec;
      
      public function CodecReferrerPanelCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4302__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4303__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:ReferrerPanelCC = new ReferrerPanelCC();
         _loc2_.hash = this.newname_4302__END.decode(param1) as String;
         _loc2_.host = this.newname_4303__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ReferrerPanelCC = ReferrerPanelCC(param2);
         this.newname_4302__END.encode(param1,_loc3_.hash);
         this.newname_4303__END.encode(param1,_loc3_.host);
         return 4;
      }
   }
}

