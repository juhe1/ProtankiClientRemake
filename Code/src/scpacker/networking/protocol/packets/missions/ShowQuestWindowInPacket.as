package scpacker.networking.protocol.packets.missions
{
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   import projects.tanks.client.panel.model.weeklyquest.profile.WeeklyQuestDescription;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShowQuestWindowInPacket extends AbstractPacket
   {
      public static const id:int = 809822533;
      
      public var missions:Vector.<DailyQuestInfo>;
      
      public var weeklyStreakInfo:WeeklyQuestDescription;
      
      public function ShowQuestWindowInPacket(param1:Vector.<DailyQuestInfo> = null, param2:WeeklyQuestDescription = null)
      {
         super();
         this.missions = param1;
         this.weeklyStreakInfo = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecDailyQuestInfo");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecWeeklyQuestDescription");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.missions = param1 as Vector.<DailyQuestInfo>;
               break;
            case 1:
               this.weeklyStreakInfo = param1 as WeeklyQuestDescription;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShowQuestWindowInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 19;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

