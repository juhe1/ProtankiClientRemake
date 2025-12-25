package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.commons.models.tips.item.TipItemCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.LocalizedImageResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecTipItemCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = TipItemCC;
      
      private var newname_4252__END:ICodec;
      
      public function CodecTipItemCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4252__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:TipItemCC = new TipItemCC();
         _loc2_.preview = this.newname_4252__END.decode(param1) as LocalizedImageResource;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:TipItemCC = TipItemCC(param2);
         this.newname_4252__END.encode(param1,_loc3_.preview);
         return 4;
      }
   }
}

