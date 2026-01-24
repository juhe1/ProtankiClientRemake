package scpacker.networking.protocol.packets.usercountry
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ChangeLocationOutPacket extends AbstractPacket
   {
      public static const id:int = 921004371;
      
      public var locationAbbreviation:String;
      
      public function ChangeLocationOutPacket(param1:String = "")
      {
         super();
         this.locationAbbreviation = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.locationAbbreviation = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ChangeLocationOutPacket();
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

