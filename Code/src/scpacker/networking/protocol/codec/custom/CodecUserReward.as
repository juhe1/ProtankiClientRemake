package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import projects.tanks.client.battleservice.model.statistics.UserReward;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecUserReward implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = UserReward;
      
      private var newname_4418__END:ICodec;
      
      private var newname_4419__END:ICodec;
      
      private var newname_4420__END:ICodec;
      
      private var newname_4098__END:ICodec;
      
      public function CodecUserReward(param1:ProtocolInitializer)
      {
         super();
         this.newname_4418__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4419__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4420__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4098__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:UserReward = new UserReward();
         _loc2_.newbiesAbonementBonusReward = this.newname_4418__END.decode(param1) as int;
         _loc2_.premiumBonusReward = this.newname_4419__END.decode(param1) as int;
         _loc2_.reward = this.newname_4420__END.decode(param1) as int;
         _loc2_.userId = this.newname_4098__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:UserReward = UserReward(param2);
         this.newname_4418__END.encode(param1,_loc3_.newbiesAbonementBonusReward);
         this.newname_4419__END.encode(param1,_loc3_.premiumBonusReward);
         this.newname_4420__END.encode(param1,_loc3_.reward);
         this.newname_4098__END.encode(param1,_loc3_.userId);
         return 4;
      }
   }
}

