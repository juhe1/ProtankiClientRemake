package scpacker.networking.protocol.packets.ping
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class Ping extends AbstractPacket
   {
      public function Ping()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new Ping();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 45;
      }
      
      override public function getId() : int
      {
         return -555602629;
      }
   }
}

