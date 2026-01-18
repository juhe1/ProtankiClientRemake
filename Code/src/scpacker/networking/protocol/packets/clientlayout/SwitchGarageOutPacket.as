package scpacker.networking.protocol.packets.clientlayout
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SwitchGarageOutPacket extends AbstractPacket
   {
      public function SwitchGarageOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SwitchGarageOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 17;
      }
      
      override public function getId() : int
      {
         return -479046431;
      }
   }
}

