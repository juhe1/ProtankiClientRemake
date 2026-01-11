package scpacker.networking.protocol.packets.dm
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadDmModelPostInPacket extends AbstractPacket
   {
      public static const id:int = 930618015;

      public function LoadDmModelPostInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadDmModelPostInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 63;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

