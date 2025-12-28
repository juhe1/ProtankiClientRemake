package scpacker.networking.protocol.packets.externalentrance
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LinkAlreadyExistsInPacket extends AbstractPacket
   {
      public static var id = 1243673979;

      public function LinkAlreadyExistsInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LinkAlreadyExistsInPacket();
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

