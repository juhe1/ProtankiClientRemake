package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.Range;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBattleInfoData implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BattleInfoData;
      
      private var newname_4222__END:ICodec;
      
      private var newname_4224__END:ICodec;
      
      private var newname_4225__END:ICodec;
      
      private var newname_4119__END:ICodec;
      
      private var newname_4120__END:ICodec;
      
      private var newname_4368__END:ICodec;
      
      private var newname_4369__END:ICodec;
      
      private var newname_4228__END:ICodec;
      
      public function CodecBattleInfoData(param1:ProtocolInitializer)
      {
         super();
         this.newname_4222__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4224__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4225__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecBattleMode");
         this.newname_4119__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4120__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4368__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecRange");
         this.newname_4369__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4228__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BattleInfoData = new BattleInfoData();
         _loc2_.battleId = this.newname_4222__END.decode(param1) as String;
         _loc2_.mapName = this.newname_4224__END.decode(param1) as String;
         _loc2_.mode = this.newname_4225__END.decode(param1) as BattleMode;
         _loc2_.privateBattle = this.newname_4119__END.decode(param1) as Boolean;
         _loc2_.proBattle = this.newname_4120__END.decode(param1) as Boolean;
         _loc2_.range = this.newname_4368__END.decode(param1) as Range;
         _loc2_.serverNumber = this.newname_4228__END.decode(param1) as int;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BattleInfoData = BattleInfoData(param2);
         this.newname_4222__END.encode(param1,_loc3_.battleId);
         this.newname_4224__END.encode(param1,_loc3_.mapName);
         this.newname_4225__END.encode(param1,_loc3_.mode);
         this.newname_4119__END.encode(param1,_loc3_.privateBattle);
         this.newname_4120__END.encode(param1,_loc3_.proBattle);
         this.newname_4368__END.encode(param1,_loc3_.range);
         this.newname_4228__END.encode(param1,_loc3_.serverNumber);
         return 4;
      }
   }
}

