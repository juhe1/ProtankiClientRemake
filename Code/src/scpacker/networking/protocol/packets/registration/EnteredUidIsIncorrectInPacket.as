package scpacker.networking.protocol.packets.registration
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class EnteredUidIsIncorrectInPacket extends AbstractPacket
   {
      public static const id:int = 1480924803;
      
      public function EnteredUidIsIncorrectInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new EnteredUidIsIncorrectInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 8;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

