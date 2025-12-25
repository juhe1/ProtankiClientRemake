package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import projects.tanks.client.battleservice.model.statistics.UserStat;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecUserStat implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = UserStat;
      
      private var newname_4367__END:ICodec;
      
      private var newname_4274__END:ICodec;
      
      private var newname_4242__END:ICodec;
      
      private var newname_4276__END:ICodec;
      
      public function CodecUserStat(param1:ProtocolInitializer)
      {
         super();
         this.newname_4367__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         this.newname_4274__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         this.newname_4242__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4276__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:UserStat = new UserStat();
         _loc2_.deaths = this.newname_4367__END.decode(param1) as int;
         _loc2_.kills = this.newname_4274__END.decode(param1) as int;
         _loc2_.score = this.newname_4242__END.decode(param1) as int;
         _loc2_.user = this.newname_4276__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:UserStat = UserStat(param2);
         this.newname_4367__END.encode(param1,_loc3_.deaths);
         this.newname_4274__END.encode(param1,_loc3_.kills);
         this.newname_4242__END.encode(param1,_loc3_.score);
         this.newname_4276__END.encode(param1,_loc3_.user);
         return 4;
      }
   }
}

