package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.panel.model.dailyquest.DailyQuestPrizeInfo;
   
   public class CodecDailyQuestPrizeInfo implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = DailyQuestPrizeInfo;
      
      private var newname_4364__END:ICodec;
      
      private var newname_4117__END:ICodec;
      
      public function CodecDailyQuestPrizeInfo(param1:ProtocolInitializer)
      {
         super();
         this.newname_4364__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4117__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:DailyQuestPrizeInfo = new DailyQuestPrizeInfo();
         _loc2_.count = this.newname_4364__END.decode(param1) as int;
         _loc2_.name = this.newname_4117__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:DailyQuestPrizeInfo = DailyQuestPrizeInfo(param2);
         this.newname_4364__END.encode(param1,_loc3_.count);
         this.newname_4117__END.encode(param1,_loc3_.name);
         return 4;
      }
   }
}

