package scpacker.networking.protocol.packets.chat
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SendMessageOutPacket extends AbstractPacket
   {
      public static const id:int = 705454610;
      
      public var username:String;
      
      public var message:String;
      
      public function SendMessageOutPacket(param1:String = "", param2:String = "")
      {
         super();
         this.username = param1;
         this.message = param2;
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
               this.message = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SendMessageOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 28;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

