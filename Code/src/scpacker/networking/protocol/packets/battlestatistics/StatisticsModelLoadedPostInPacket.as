package scpacker.networking.protocol.packets.battlestatistics
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class StatisticsModelLoadedPostInPacket extends AbstractPacket
   {
      
      public static const id:int = 1953272681;
      
      public function StatisticsModelLoadedPostInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new StatisticsModelLoadedPostInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 37;
      }
      
      override public function getId() : int
      {
         return 1953272681;
      }
   }
}

