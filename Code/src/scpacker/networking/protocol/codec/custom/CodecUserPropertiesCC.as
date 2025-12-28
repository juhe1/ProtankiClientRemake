package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.panel.model.profile.userproperties.UserPropertiesCC;
   import projects.tanks.client.users.model.userbattlestatistics.rank.RankBounds;
   
   public class CodecUserPropertiesCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = UserPropertiesCC;
      
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
      
      public function CodecUserPropertiesCC(param1:ProtocolInitializer)
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
         var _loc2_:UserPropertiesCC = new UserPropertiesCC();
         _loc2_.crystals = this.newname_4503__END.decode(param1) as int;
         var rankBoundMin = this.newname_4504__END.decode(param1) as int;

         //_loc2_.durationCrystalAbonement = this.newname_4507__END.decode(param1) as int;
         this.newname_4507__END.decode(param1);

         //_loc2_.hasDoubleCrystal = this.newname_4509__END.decode(param1) as Boolean;
         this.newname_4509__END.decode(param1);

         var rankBoundMax = this.newname_4510__END.decode(param1) as int;

         //_loc2_.place = this.newname_4511__END.decode(param1) as int;
         this.newname_4511__END.decode(param1);

         _loc2_.rank = this.newname_4172__END.decode(param1) as int;
         _loc2_.userRating = this.newname_4512__END.decode(param1) as Number;
         _loc2_.score = this.newname_4242__END.decode(param1) as int;

         //_loc2_.serverNumber = this.newname_4228__END.decode(param1) as int;
         this.newname_4228__END.decode(param1)

         _loc2_.rankBounds = new RankBounds(rankBoundMin,rankBoundMax);

         var _loc3_:* = this.newname_4321__END.decode(param1) as String;
         _loc2_.id = _loc3_;
         _loc2_.uid = _loc3_;
         _loc2_.userProfileUrl = this.newname_4514__END.decode(param1) as String;
         //_loc2_.place += 1;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         throw new Error("Not implemented");
         return 4;
      }
   }
}

