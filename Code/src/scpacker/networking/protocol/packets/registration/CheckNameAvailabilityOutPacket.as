package scpacker.networking.protocol.packets.registration
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CheckNameAvailabilityOutPacket extends AbstractPacket
   {
      public static const id:int = 1083705823;
      
      public var username:String;
      
      public function CheckNameAvailabilityOutPacket(param1:String = "")
      {
         super();
         this.username = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.username = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CheckNameAvailabilityOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 8;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

