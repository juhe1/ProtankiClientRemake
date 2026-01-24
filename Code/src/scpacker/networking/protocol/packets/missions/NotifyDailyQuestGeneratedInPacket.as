package scpacker.networking.protocol.packets.missions
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class NotifyDailyQuestGeneratedInPacket extends AbstractPacket
   {
      public static const id:int = 956252237;
      
      public function NotifyDailyQuestGeneratedInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new NotifyDailyQuestGeneratedInPacket();
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

