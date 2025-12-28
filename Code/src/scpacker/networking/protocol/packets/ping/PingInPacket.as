package scpacker.networking.protocol.packets.ping
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class PingInPacket extends AbstractPacket
   {
      public static const id:int = -555602629;
      
      public function PingInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new PingInPacket();
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

