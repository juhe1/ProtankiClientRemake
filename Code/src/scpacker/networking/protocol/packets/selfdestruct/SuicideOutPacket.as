package scpacker.networking.protocol.packets.selfdestruct
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SuicideOutPacket extends AbstractPacket
   {
      public static const id:int = 988664577;
      
      public function SuicideOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SuicideOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 40;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

