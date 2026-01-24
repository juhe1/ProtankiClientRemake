package scpacker.networking.protocol.packets.missions
{
   import projects.tanks.client.panel.model.weeklyquest.profile.WeeklyQuestDescription;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShowQuestWindowWithoutDailyQuestsInPacket extends AbstractPacket
   {
      public static const id:int = 885055495;
      
      public var weeklyStreakInfo:WeeklyQuestDescription;
      
      public function ShowQuestWindowWithoutDailyQuestsInPacket(param1:WeeklyQuestDescription = null)
      {
         super();
         this.weeklyStreakInfo = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecWeeklyQuestDescription");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.weeklyStreakInfo = param1 as WeeklyQuestDescription;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShowQuestWindowWithoutDailyQuestsInPacket();
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

