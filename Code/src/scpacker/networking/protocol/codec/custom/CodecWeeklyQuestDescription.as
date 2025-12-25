package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.weeklyquest.profile.WeeklyQuestDescription;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecWeeklyQuestDescription implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = WeeklyQuestDescription;
      
      private var newname_4279__END:ICodec;
      
      private var newname_4280__END:ICodec;
      
      private var newname_4281__END:ICodec;
      
      private var newname_4282__END:ICodec;
      
      private var newname_4283__END:ICodec;
      
      public function CodecWeeklyQuestDescription(param1:ProtocolInitializer)
      {
         super();
         this.newname_4279__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4280__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4281__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4282__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4283__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:WeeklyQuestDescription = new WeeklyQuestDescription();
         _loc2_.currentQuestLevel = this.newname_4279__END.decode(param1) as int;
         _loc2_.currentQuestStreak = this.newname_4280__END.decode(param1) as int;
         _loc2_.doneForToday = this.newname_4281__END.decode(param1) as Boolean;
         _loc2_.questImage = this.newname_4282__END.decode(param1) as ImageResource;
         _loc2_.rewardImage = this.newname_4283__END.decode(param1) as ImageResource;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:WeeklyQuestDescription = WeeklyQuestDescription(param2);
         this.newname_4279__END.encode(param1,_loc3_.currentQuestLevel);
         this.newname_4280__END.encode(param1,_loc3_.currentQuestStreak);
         this.newname_4281__END.encode(param1,_loc3_.doneForToday);
         this.newname_4282__END.encode(param1,_loc3_.questImage);
         this.newname_4283__END.encode(param1,_loc3_.rewardImage);
         return 4;
      }
   }
}

