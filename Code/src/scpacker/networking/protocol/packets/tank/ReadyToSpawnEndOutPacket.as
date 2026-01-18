package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ReadyToSpawnEndOutPacket extends AbstractPacket
   {
      public static const id:int = 268832557;

      public function ReadyToSpawnEndOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ReadyToSpawnEndOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 39;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
