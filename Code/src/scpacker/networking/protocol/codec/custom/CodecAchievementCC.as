package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.achievements.model.Achievement;
   import projects.tanks.client.achievements.model.panel.AchievementCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecAchievementCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = AchievementCC;
      
      private var newname_4462__END:ICodec;
      
      public function CodecAchievementCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4462__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecAchievement");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:AchievementCC = new AchievementCC();
         _loc2_.activeAchievements = this.newname_4462__END.decode(param1) as Vector.<Achievement>;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:AchievementCC = AchievementCC(param2);
         this.newname_4462__END.encode(param1,_loc3_.activeAchievements);
         return 4;
      }
   }
}

