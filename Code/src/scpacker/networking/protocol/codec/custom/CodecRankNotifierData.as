package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.tanksservices.model.notifier.rank.RankNotifierData;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecRankNotifierData implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = RankNotifierData;
      
      private var newname_4172__END:ICodec;
      
      private var newname_4098__END:ICodec;
      
      public function CodecRankNotifierData(param1:ProtocolInitializer)
      {
         super();
         this.newname_4172__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
         this.newname_4098__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:RankNotifierData = new RankNotifierData();
         _loc2_.rank = this.newname_4172__END.decode(param1) as int;
         _loc2_.userId = this.newname_4098__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:RankNotifierData = RankNotifierData(param2);
         this.newname_4172__END.encode(param1,_loc3_.rank);
         this.newname_4098__END.encode(param1,_loc3_.userId);
         return 4;
      }
   }
}

