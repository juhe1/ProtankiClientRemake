package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ActivateTankOutPacket extends AbstractPacket
   {
      public static const id:int = 1178028365;

      public function ActivateTankOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ActivateTankOutPacket();
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
