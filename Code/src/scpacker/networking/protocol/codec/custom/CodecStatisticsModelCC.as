package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battleservice.BattleMode;
   import flash.utils.ByteArray;
   import newname_2265__END.newname_2266__END;
   import projects.tanks.client.battleservice.model.statistics.newname_4552__END;
   import projects.tanks.client.battleservice.model.createparams.BattleLimits;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.battleservice.model.statistics.StatisticsModelCC;
   import projects.tanks.client.battleservice.EquipmentConstraintsMode;
   
   public class CodecStatisticsModelCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = StatisticsModelCC;
      
      private var newname_4111__END:ICodec;
      
      private var newname_4112__END:ICodec;
      
      private var newname_4553__END:ICodec;
      
      private var newname_4114__END:ICodec;
      
      private var newname_4224__END:ICodec;
      
      private var newname_4554__END:ICodec;
      
      private var newname_4116__END:ICodec;
      
      private var newname_4555__END:ICodec;
      
      private var newname_4556__END:ICodec;
      
      private var newname_4118__END:ICodec;
      
      private var newname_4557__END:ICodec;
      
      private var newname_4558__END:ICodec;
      
      private var newname_4559__END:ICodec;
      
      private var newname_4560__END:ICodec;
      
      private var newname_4561__END:ICodec;
      
      public function CodecStatisticsModelCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4111__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecBattleMode");
         this.newname_4112__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecEquipmentConstraintsMode");
         this.newname_4553__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4114__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecBattleLimits");
         this.newname_4224__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4554__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4116__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4555__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4556__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4118__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4557__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4558__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4559__END = param1.getCodec("scpacker.networking.protocol.codec.complex.VectorCodecString");
         this.newname_4560__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4561__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:StatisticsModelCC = new StatisticsModelCC();
         _loc2_.battleMode = this.newname_4111__END.decode(param1) as BattleMode;
         _loc2_.equipmentConstraintsMode = this.newname_4112__END.decode(param1) as EquipmentConstraintsMode;
         _loc2_.fund = this.newname_4553__END.decode(param1) as int;
         _loc2_.limits = this.newname_4114__END.decode(param1) as BattleLimits;
         _loc2_.mapName = this.newname_4224__END.decode(param1) as String;
         _loc2_.maxPeopleCount = this.newname_4116__END.decode(param1) as int;
         _loc2_.parkourMode = this.newname_4118__END.decode(param1) as Boolean;
         _loc2_.premiumBonusInPercent = this.newname_4557__END.decode(param1) as int;
         _loc2_.spectator = this.newname_4558__END.decode(param1) as Boolean;
         _loc2_.suspiciousUserIds = this.newname_4559__END.decode(param1) as Vector.<String>;
         _loc2_.timeLeft = this.newname_4560__END.decode(param1) as int;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:StatisticsModelCC = StatisticsModelCC(param2);
         this.newname_4112__END.encode(param1,_loc3_.equipmentConstraintsMode);
         this.newname_4553__END.encode(param1,_loc3_.fund);
         this.newname_4114__END.encode(param1,_loc3_.limits);
         this.newname_4224__END.encode(param1,_loc3_.mapName);
         this.newname_4554__END.encode(param1,_loc3_.matchBattle);
         this.newname_4116__END.encode(param1,_loc3_.maxPeopleCount);
         this.newname_4555__END.encode(param1,_loc3_.modeName);
         this.newname_4556__END.encode(param1,_loc3_.newbiesAbonementBonusInPercent);
         this.newname_4118__END.encode(param1,_loc3_.parkourMode);
         this.newname_4557__END.encode(param1,_loc3_.premiumBonusInPercent);
         this.newname_4558__END.encode(param1,_loc3_.spectator);
         this.newname_4559__END.encode(param1,_loc3_.suspiciousUserIds);
         this.newname_4560__END.encode(param1,_loc3_.timeLeft);
         this.newname_4561__END.encode(param1,_loc3_.valuableRound);
         return 4;
      }
   }
}

