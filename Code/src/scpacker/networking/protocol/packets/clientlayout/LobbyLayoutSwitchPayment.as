package scpacker.networking.protocol.packets.clientlayout
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LobbyLayoutSwitchPayment extends AbstractPacket
   {
      public function LobbyLayoutSwitchPayment()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LobbyLayoutSwitchPayment();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 17;
      }
      
      override public function getId() : int
      {
         return 1153801756;
      }
   }
}

