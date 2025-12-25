package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import projects.tanks.client.panel.model.weeklyquest.showing.WeeklyQuestRewardItem;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecWeeklyQuestRewardItem implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = WeeklyQuestRewardItem;
      
      private var newname_4364__END:ICodec;
      
      private var newname_4438__END:ICodec;
      
      public function CodecWeeklyQuestRewardItem(param1:ProtocolInitializer)
      {
         super();
         this.newname_4364__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4438__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:WeeklyQuestRewardItem = new WeeklyQuestRewardItem();
         _loc2_.count = this.newname_4364__END.decode(param1) as int;
         _loc2_.itemImage = this.newname_4438__END.decode(param1) as ImageResource;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:WeeklyQuestRewardItem = WeeklyQuestRewardItem(param2);
         this.newname_4364__END.encode(param1,_loc3_.count);
         this.newname_4438__END.encode(param1,_loc3_.itemImage);
         return 4;
      }
   }
}

