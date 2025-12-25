package scpacker.networking.protocol.packets.init
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class HideLoader extends AbstractPacket
   {
      public function HideLoader()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new HideLoader();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 4;
      }
      
      override public function getId() : int
      {
         return -1282173466;
      }
   }
}

