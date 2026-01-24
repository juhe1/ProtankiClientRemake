package scpacker.networking.protocol.packets.usercountry
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RequestUserCountryInPacket extends AbstractPacket
   {
      public static const id:int = 1961542160;
      
      public var country:String;
      
      public function RequestUserCountryInPacket(param1:String = "")
      {
         super();
         this.country = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.country = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RequestUserCountryInPacket();
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

