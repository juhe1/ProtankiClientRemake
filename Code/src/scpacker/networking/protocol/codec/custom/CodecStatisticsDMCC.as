package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battleservice.model.statistics.dm.StatisticsDMCC;
   import flash.utils.ByteArray;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecStatisticsDMCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = StatisticsDMCC;
      
      private var newname_4105__END:ICodec;
      
      public function CodecStatisticsDMCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4105__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecUserInfo");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:StatisticsDMCC = new StatisticsDMCC();
         _loc2_.userInfos = this.newname_4105__END.decode(param1) as Vector.<UserInfo>;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:StatisticsDMCC = StatisticsDMCC(param2);
         this.newname_4105__END.encode(param1,_loc3_.userInfos);
         return 4;
      }
   }
}

