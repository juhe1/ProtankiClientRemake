package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RenameFailedInPacket extends AbstractPacket
   {
      public static const id:int = -471022967;
      
      public function RenameFailedInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RenameFailedInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
