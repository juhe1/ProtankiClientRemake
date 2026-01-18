package scpacker.networking.protocol.packets.tdm
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadTdmPostInPacket extends AbstractPacket
   {
      public static const id:int = 183561709;

      public function LoadTdmPostInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadTdmPostInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 64;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

