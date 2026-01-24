package scpacker.networking.protocol.packets.chat
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.chat.types.ChatMessage;
   
   public class ShowMessagesInPacket extends AbstractPacket
   {
      public static const id:int = -1263520410;
      
      public var messages:Vector.<ChatMessage>;
      
      public function ShowMessagesInPacket(param1:Vector.<ChatMessage> = null)
      {
         super();
         this.messages = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecChatMessage");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.messages = param1 as Vector.<ChatMessage>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShowMessagesInPacket();
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

