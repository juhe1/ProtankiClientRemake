package scpacker.networking.protocol.packets.usercountry
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CheckUserPaymentCountryOutPacket extends AbstractPacket
   {
      public static const id:int = -296048697;
      
      public function CheckUserPaymentCountryOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CheckUserPaymentCountryOutPacket();
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

