package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battleservice.model.statistics.team.StatisticsTeamCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   
   public class CodecStatisticsTeamCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = StatisticsTeamCC;
      
      private var newname_4410__END:ICodec;
      
      private var newname_4411__END:ICodec;
      
      private var newname_4412__END:ICodec;
      
      private var newname_4413__END:ICodec;
      
      public function CodecStatisticsTeamCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4410__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4411__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4412__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecUserInfo");
         this.newname_4413__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecUserInfo");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:StatisticsTeamCC = new StatisticsTeamCC();
         _loc2_.blueScore = this.newname_4410__END.decode(param1) as int;
         _loc2_.redScore = this.newname_4411__END.decode(param1) as int;
         _loc2_.usersInfoBlue = this.newname_4412__END.decode(param1) as Vector.<UserInfo>;
         _loc2_.usersInfoRed = this.newname_4413__END.decode(param1) as Vector.<UserInfo>;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:StatisticsTeamCC = StatisticsTeamCC(param2);
         this.newname_4410__END.encode(param1,_loc3_.blueScore);
         this.newname_4411__END.encode(param1,_loc3_.redScore);
         this.newname_4412__END.encode(param1,_loc3_.usersInfoBlue);
         this.newname_4413__END.encode(param1,_loc3_.usersInfoRed);
         return 4;
      }
   }
}

