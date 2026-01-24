package scpacker.networking.protocol.packets.missions
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class NotifyDailyQuestChangesViewedOutPacket extends AbstractPacket
   {
      public static const id:int = 1417347634;
      
      public function NotifyDailyQuestChangesViewedOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new NotifyDailyQuestChangesViewedOutPacket();
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

