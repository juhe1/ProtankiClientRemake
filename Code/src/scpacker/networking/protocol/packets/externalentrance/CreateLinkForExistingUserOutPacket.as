package scpacker.networking.protocol.packets.externalentrance
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CreateLinkForExistingUserOutPacket extends AbstractPacket
   {
      public var username:String;
      
      public var password:String;
      
      public function CreateLinkForExistingUserOutPacket(param1:String = "", param2:String = "")
      {
         super();
         this.username = param1;
         this.password = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.username = param1 as String;
               break;
            case 1:
               this.password = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CreateLinkForExistingUserOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 3;
      }
      
      override public function getId() : int
      {
         return -87665118;
      }
   }
}

