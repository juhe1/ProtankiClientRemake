package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import projects.tanks.client.battleservice.model.createparams.BattleLimits;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBattleLimits implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BattleLimits;
      
      private var newname_4306__END:ICodec;
      
      private var newname_4307__END:ICodec;
      
      public function CodecBattleLimits(param1:ProtocolInitializer)
      {
         super();
         this.newname_4306__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4307__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BattleLimits = new BattleLimits();
         _loc2_.scoreLimit = this.newname_4306__END.decode(param1) as int;
         _loc2_.timeLimitInSec = this.newname_4307__END.decode(param1) as int;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BattleLimits = BattleLimits(param2);
         var _loc4_:int = 0;
         _loc4_ = _loc4_ + this.newname_4306__END.encode(param1,_loc3_.scoreLimit);
         return _loc4_ + this.newname_4307__END.encode(param1,_loc3_.timeLimitInSec);
      }
   }
}

