package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.profile.userproperty.UserPropertyCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecUserPropertyCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = UserPropertyCC;
      
      private var newname_4503__END:ICodec;
      
      private var newname_4504__END:ICodec;
      
      private var newname_4505__END:ICodec;
      
      private var newname_4506__END:ICodec;
      
      private var newname_4507__END:ICodec;
      
      private var newname_4508__END:ICodec;
      
      private var newname_4509__END:ICodec;
      
      private var newname_4240__END:ICodec;
      
      private var newname_4510__END:ICodec;
      
      private var newname_4511__END:ICodec;
      
      private var newname_4172__END:ICodec;
      
      private var newname_4512__END:ICodec;
      
      private var newname_4242__END:ICodec;
      
      private var newname_4228__END:ICodec;
      
      private var newname_4513__END:ICodec;
      
      private var newname_4321__END:ICodec;
      
      private var newname_4514__END:ICodec;
      
      public function CodecUserPropertyCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4503__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4504__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4507__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4509__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4240__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4510__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4511__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4172__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
         this.newname_4512__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4242__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4228__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4321__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4514__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:UserPropertyCC = new UserPropertyCC();
         _loc2_.crystals = this.newname_4503__END.decode(param1) as int;
         _loc2_.currentRankScore = this.newname_4504__END.decode(param1) as int;
         _loc2_.durationCrystalAbonement = this.newname_4507__END.decode(param1) as int;
         _loc2_.hasDoubleCrystal = this.newname_4509__END.decode(param1) as Boolean;
         _loc2_.nextRankScore = this.newname_4510__END.decode(param1) as int;
         _loc2_.place = this.newname_4511__END.decode(param1) as int;
         _loc2_.rank = this.newname_4172__END.decode(param1) as int;
         _loc2_.rating = this.newname_4512__END.decode(param1) as Number;
         _loc2_.score = this.newname_4242__END.decode(param1) as int;
         _loc2_.serverNumber = this.newname_4228__END.decode(param1) as int;
         var _loc3_:* = this.newname_4321__END.decode(param1) as String;
         _loc2_.id = _loc3_;
         _loc2_.uid = _loc3_;
         _loc2_.userProfileUrl = this.newname_4514__END.decode(param1) as String;
         _loc2_.place += 1;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:UserPropertyCC = UserPropertyCC(param2);
         this.newname_4503__END.encode(param1,_loc3_.crystals);
         this.newname_4504__END.encode(param1,_loc3_.currentRankScore);
         this.newname_4505__END.encode(param1,_loc3_.daysFromLastVisit);
         this.newname_4506__END.encode(param1,_loc3_.daysFromRegistration);
         this.newname_4507__END.encode(param1,_loc3_.durationCrystalAbonement);
         this.newname_4508__END.encode(param1,_loc3_.gameHost);
         this.newname_4509__END.encode(param1,_loc3_.hasDoubleCrystal);
         this.newname_4510__END.encode(param1,_loc3_.nextRankScore);
         this.newname_4511__END.encode(param1,_loc3_.place);
         this.newname_4172__END.encode(param1,_loc3_.rank);
         this.newname_4512__END.encode(param1,_loc3_.rating);
         this.newname_4242__END.encode(param1,_loc3_.score);
         this.newname_4228__END.encode(param1,_loc3_.serverNumber);
         this.newname_4513__END.encode(param1,_loc3_.templateBattlePage);
         this.newname_4321__END.encode(param1,_loc3_.uid);
         this.newname_4514__END.encode(param1,_loc3_.userProfileUrl);
         return 4;
      }
   }
}

