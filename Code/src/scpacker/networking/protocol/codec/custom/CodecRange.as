package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battleservice.Range;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecRange implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = Range;
      
      private var newname_4403__END:ICodec;
      
      private var newname_4404__END:ICodec;
      
      public function CodecRange(param1:ProtocolInitializer)
      {
         super();
         this.newname_4403__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4404__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:Range = new Range();
         _loc2_.max = this.newname_4403__END.decode(param1) as int;
         _loc2_.min = this.newname_4404__END.decode(param1) as int;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:Range = Range(param2);
         var _loc4_:int = 0;
         _loc4_ = _loc4_ + this.newname_4403__END.encode(param1,_loc3_.max);
         return _loc4_ + this.newname_4404__END.encode(param1,_loc3_.min);
      }
   }
}

