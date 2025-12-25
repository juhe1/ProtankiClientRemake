package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import projects.tanks.client.battleselect.model.info.BattleInfoUser;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBattleInfoUser implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BattleInfoUser;
      
      private var newname_4274__END:ICodec;
      
      private var newname_4242__END:ICodec;
      
      private var newname_4275__END:ICodec;
      
      private var newname_4276__END:ICodec;
      
      public function CodecBattleInfoUser(param1:ProtocolInitializer)
      {
         super();
         this.newname_4274__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4242__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4275__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4276__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BattleInfoUser = new BattleInfoUser();
         _loc2_.kills = this.newname_4274__END.decode(param1) as int;
         _loc2_.score = this.newname_4242__END.decode(param1) as int;
         _loc2_.suspicious = this.newname_4275__END.decode(param1) as Boolean;
         _loc2_.user = this.newname_4276__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BattleInfoUser = BattleInfoUser(param2);
         var _loc4_:int = 0;
         _loc4_ = _loc4_ + this.newname_4274__END.encode(param1,_loc3_.kills);
         _loc4_ = _loc4_ + this.newname_4242__END.encode(param1,_loc3_.score);
         _loc4_ = _loc4_ + this.newname_4275__END.encode(param1,_loc3_.suspicious);
         return _loc4_ + this.newname_4276__END.encode(param1,_loc3_.user);
      }
   }
}

