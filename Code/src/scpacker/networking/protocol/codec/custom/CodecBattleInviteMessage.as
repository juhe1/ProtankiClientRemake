package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.panel.model.battleinvite.BattleInviteMessage;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBattleInviteMessage implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BattleInviteMessage;
      
      private var newname_4220__END:ICodec;
      
      private var newname_4221__END:ICodec;
      
      private var newname_4222__END:ICodec;
      
      private var newname_4223__END:ICodec;
      
      private var newname_4224__END:ICodec;
      
      private var newname_4225__END:ICodec;
      
      private var newname_4226__END:ICodec;
      
      private var newname_4119__END:ICodec;
      
      private var newname_4227__END:ICodec;
      
      private var newname_4228__END:ICodec;
      
      private var newname_4229__END:ICodec;
      
      public function CodecBattleInviteMessage(param1:ProtocolInitializer)
      {
         super();
         this.newname_4220__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4221__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4222__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4223__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4224__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4225__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecBattleMode");
         this.newname_4226__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4119__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4227__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4228__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4229__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BattleInviteMessage = new BattleInviteMessage();
         _loc2_.availableRank = this.newname_4220__END.decode(param1) as Boolean;
         _loc2_.availableSlot = this.newname_4221__END.decode(param1) as Boolean;
         _loc2_.battleId = this.newname_4222__END.decode(param1) as String;
         _loc2_.mapName = this.newname_4224__END.decode(param1) as String;
         _loc2_.mode = this.newname_4225__END.decode(param1) as BattleMode;
         _loc2_.noSuppliesBattle = this.newname_4226__END.decode(param1) as Boolean;
         _loc2_.privateBattle = this.newname_4119__END.decode(param1) as Boolean;
         _loc2_.remote = false;
         _loc2_.serverNumber = 1;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BattleInviteMessage = BattleInviteMessage(param2);
         this.newname_4220__END.encode(param1,_loc3_.availableRank);
         this.newname_4221__END.encode(param1,_loc3_.availableSlot);
         this.newname_4222__END.encode(param1,_loc3_.battleId);
         this.newname_4224__END.encode(param1,_loc3_.mapName);
         this.newname_4225__END.encode(param1,_loc3_.mode);
         this.newname_4226__END.encode(param1,_loc3_.noSuppliesBattle);
         this.newname_4119__END.encode(param1,_loc3_.privateBattle);
         this.newname_4227__END.encode(param1,_loc3_.remote);
         this.newname_4228__END.encode(param1,_loc3_.serverNumber);
         return 4;
      }
   }
}

