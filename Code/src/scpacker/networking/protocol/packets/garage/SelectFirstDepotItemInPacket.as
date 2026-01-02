package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SelectFirstDepotItemInPacket extends AbstractPacket
   {
      public static const id:int = -1763914667;
      
      public function SelectFirstDepotItemInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SelectFirstDepotItemInPacket();
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
