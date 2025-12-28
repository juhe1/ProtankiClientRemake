package scpacker.networking.protocol.packets.externalentrance
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ValidationFailedInPacket extends AbstractPacket
   {
      public static const id:int = -570114058;
      
      public function ValidationFailedInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ValidationFailedInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 3;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

