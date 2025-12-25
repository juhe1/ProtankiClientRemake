package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battleservice.BattleCreateParameters;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBattleCreateParameters implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BattleCreateParameters;
      
      private var newname_4110__END:ICodec;
      
      private var newname_4111__END:ICodec;
      
      private var newname_4112__END:ICodec;
      
      private var newname_4113__END:ICodec;
      
      private var newname_4114__END:ICodec;
      
      private var newname_4115__END:ICodec;
      
      private var newname_4116__END:ICodec;
      
      private var newname_4117__END:ICodec;
      
      private var newname_4118__END:ICodec;
      
      private var newname_4119__END:ICodec;
      
      private var newname_4120__END:ICodec;
      
      private var newname_4121__END:ICodec;
      
      private var newname_4122__END:ICodec;
      
      private var newname_4123__END:ICodec;
      
      private var newname_4124__END:ICodec;
      
      private var newname_4125__END:ICodec;
      
      private var newname_4126__END:ICodec;
      
      private var newname_4127__END:ICodec;
      
      private var newname_4128__END:ICodec;
      
      private var newname_4129__END:ICodec;
      
      private var newname_4130__END:ICodec;
      
      private var newname_4131__END:ICodec;
      
      private var newname_4132__END:ICodec;
      
      private var newname_4133__END:ICodec;
      
      private var newname_4134__END:ICodec;
      
      private var newname_4135__END:ICodec;
      
      private var newname_4136__END:ICodec;
      
      public function CodecBattleCreateParameters(param1:ProtocolInitializer)
      {
         super();
         this.newname_4110__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4111__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecBattleMode");
         this.newname_4112__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecEquipmentConstraintsMode");
         this.newname_4113__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4114__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecBattleLimits");
         this.newname_4115__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4116__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4117__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4118__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4119__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4120__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4121__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecRange");
         this.newname_4122__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4123__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecMapTheme");
         this.newname_4124__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4125__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4126__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4127__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4128__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4129__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4130__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4131__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4132__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4133__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4134__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4135__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4136__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         throw new Error("unsupported");
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:int = 0;
         var _loc4_:BattleCreateParameters = BattleCreateParameters(param2);
         _loc3_ += this.newname_4110__END.encode(param1,_loc4_.autoBalance);
         _loc3_ += this.newname_4111__END.encode(param1,_loc4_.battleMode);
         _loc3_ += this.newname_4112__END.encode(param1,_loc4_.equipmentConstraintsMode);
         _loc3_ += this.newname_4113__END.encode(param1,_loc4_.friendlyFire);
         _loc3_ += this.newname_4114__END.encode(param1,_loc4_.limits);
         _loc3_ += this.newname_4115__END.encode(param1,_loc4_.mapId);
         _loc3_ += this.newname_4116__END.encode(param1,_loc4_.maxPeopleCount);
         _loc3_ += this.newname_4117__END.encode(param1,_loc4_.name);
         _loc3_ += this.newname_4118__END.encode(param1,_loc4_.parkourMode);
         _loc3_ += this.newname_4119__END.encode(param1,_loc4_.privateBattle);
         _loc3_ += this.newname_4120__END.encode(param1,_loc4_.proBattle);
         _loc3_ += this.newname_4121__END.encode(param1,_loc4_.rankRange);
         _loc3_ += this.newname_4122__END.encode(param1,_loc4_.reArmorEnabled);
         _loc3_ += this.newname_4123__END.encode(param1,_loc4_.theme);
         _loc3_ += this.newname_4124__END.encode(param1,_loc4_.withoutBonuses);
         _loc3_ += this.newname_4125__END.encode(param1,_loc4_.withoutCrystals);
         _loc3_ += this.newname_4126__END.encode(param1,_loc4_.withoutSupplies);
         _loc3_ += this.newname_4127__END.encode(param1,_loc4_.withoutUpgrades);
         _loc3_ += this.newname_4128__END.encode(param1,_loc4_.reducedResistances);
         _loc3_ += this.newname_4129__END.encode(param1,_loc4_.esportDropTiming);
         _loc3_ += this.newname_4130__END.encode(param1,_loc4_.withoutGoldBoxes);
         _loc3_ += this.newname_4131__END.encode(param1,_loc4_.withoutGoldSiren);
         _loc3_ += this.newname_4132__END.encode(param1,_loc4_.withoutGoldZone);
         _loc3_ += this.newname_4133__END.encode(param1,_loc4_.withoutMedkit);
         _loc3_ += this.newname_4134__END.encode(param1,_loc4_.withoutMines);
         _loc3_ += this.newname_4135__END.encode(param1,_loc4_.randomGold);
         return _loc3_ + this.newname_4136__END.encode(param1,_loc4_.dependentCooldownEnabled);
      }
   }
}

