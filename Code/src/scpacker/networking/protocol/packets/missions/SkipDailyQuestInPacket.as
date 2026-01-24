package scpacker.networking.protocol.packets.missions
{
   import projects.tanks.client.panel.model.dailyquest.showing.DailyQuestInfo;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SkipDailyQuestInPacket extends AbstractPacket
   {
      public static const id:int = -1266665816;
      
      public var missionId:int;
      
      public var mission:DailyQuestInfo;
      
      public function SkipDailyQuestInPacket(param1:int = 0, param2:DailyQuestInfo = null)
      {
         super();
         this.missionId = param1;
         this.mission = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecDailyQuestInfo");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.missionId = param1 as int;
               break;
            case 1:
               this.mission = param1 as DailyQuestInfo;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SkipDailyQuestInPacket();
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

