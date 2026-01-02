package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class newname_3648__END extends AbstractPacket
   {
      public function newname_3648__END()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new newname_3648__END();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return -1154479430;
      }
   }
}

