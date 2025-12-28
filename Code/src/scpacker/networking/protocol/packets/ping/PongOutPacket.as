package scpacker.networking.protocol.packets.ping
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class PongOutPacket extends AbstractPacket
   {
      public static const id:int = 1484572481;
      
      public function PongOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new PongOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 45;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

