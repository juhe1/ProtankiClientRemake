package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.bonus.showing.info.BonusInfoCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBonusInfoCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BonusInfoCC;
      
      private var newname_4548__END:ICodec;
      
      private var newname_4447__END:ICodec;
      
      private var newname_4549__END:ICodec;
      
      public function CodecBonusInfoCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4548__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4447__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4549__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BonusInfoCC = new BonusInfoCC();
         _loc2_.bottomText = this.newname_4548__END.decode(param1) as String;
         _loc2_.image = this.newname_4447__END.decode(param1) as ImageResource;
         _loc2_.topText = this.newname_4549__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BonusInfoCC = BonusInfoCC(param2);
         this.newname_4548__END.encode(param1,_loc3_.bottomText);
         this.newname_4447__END.encode(param1,_loc3_.image);
         this.newname_4549__END.encode(param1,_loc3_.topText);
         return 4;
      }
   }
}

