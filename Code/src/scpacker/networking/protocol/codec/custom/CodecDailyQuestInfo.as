package scpacker.networking.protocol.codec.custom
{
   import alternativa.types.Long;
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import scpacker.networking.protocol.codec.ICodec;
   import projects.tanks.client.panel.model.dailyquest.DailyQuestPrizeInfo;
   
   public class CodecDailyQuestInfo implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = DailyQuestInfo;
      
      private var newname_4444__END:ICodec;
      
      private var newname_4445__END:ICodec;
      
      private var newname_4446__END:ICodec;
      
      private var newname_4447__END:ICodec;
      
      private var newname_4448__END:ICodec;
      
      private var newname_4449__END:ICodec;
      
      private var newname_4450__END:ICodec;
      
      private var newname_4451__END:ICodec;
      
      public function CodecDailyQuestInfo(param1:ProtocolInitializer)
      {
         super();
         this.newname_4444__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4445__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4446__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4447__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4448__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecDailyQuestPrizeInfo");
         this.newname_4449__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4450__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4451__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:DailyQuestInfo = new DailyQuestInfo();
         _loc2_.canSkipForFree = this.newname_4444__END.decode(param1) as Boolean;
         _loc2_.description = this.newname_4445__END.decode(param1) as String;
         _loc2_.finishCriteria = this.newname_4446__END.decode(param1) as int;
         _loc2_.image = this.newname_4447__END.decode(param1) as ImageResource;
         _loc2_.prizes = this.newname_4448__END.decode(param1) as Vector.<DailyQuestPrizeInfo>;
         _loc2_.progress = this.newname_4449__END.decode(param1) as int;
         _loc2_.questId = Long.getLong(0,this.newname_4450__END.decode(param1) as int);
         _loc2_.skipCost = this.newname_4451__END.decode(param1) as int;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:DailyQuestInfo = DailyQuestInfo(param2);
         this.newname_4444__END.encode(param1,_loc3_.canSkipForFree);
         this.newname_4445__END.encode(param1,_loc3_.description);
         this.newname_4446__END.encode(param1,_loc3_.finishCriteria);
         this.newname_4447__END.encode(param1,_loc3_.image);
         this.newname_4448__END.encode(param1,_loc3_.prizes);
         this.newname_4449__END.encode(param1,_loc3_.progress);
         var _loc4_:*;
         this.newname_4450__END.encode(param1,(_loc4_ = _loc3_.questId)._low);
         this.newname_4451__END.encode(param1,_loc3_.skipCost);
         return 4;
      }
   }
}

