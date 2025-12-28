package scpacker.networking.protocol.packets.registration
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class NameAvailableInPacket extends AbstractPacket
   {
      public static const id:int = -706679202;
      
      public function NameAvailableInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new NameAvailableInPacket();
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

