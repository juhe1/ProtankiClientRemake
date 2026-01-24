package scpacker.networking.protocol.packets.usercountry
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShowPaymentWindowInPacket extends AbstractPacket
   {
      public static const id:int = 1870342869;
      
      public function ShowPaymentWindowInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShowPaymentWindowInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 75;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

