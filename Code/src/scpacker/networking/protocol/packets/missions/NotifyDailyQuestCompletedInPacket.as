package scpacker.networking.protocol.packets.missions
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class NotifyDailyQuestCompletedInPacket extends AbstractPacket
   {
      public static const id:int = 1579425801;
      
      public function NotifyDailyQuestCompletedInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new NotifyDailyQuestCompletedInPacket();
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

