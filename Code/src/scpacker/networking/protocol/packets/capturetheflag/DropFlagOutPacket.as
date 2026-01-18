package scpacker.networking.protocol.packets.capturetheflag
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class DropFlagOutPacket extends AbstractPacket
   {
      public static const id:int = -1832611824;
      
      public function DropFlagOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new DropFlagOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 42;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
