package scpacker.networking.protocol.packets.chat
{
   import projects.tanks.client.chat.models.chat.chat.ChatCC;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadChatModelInPacket extends AbstractPacket
   {
      public static const id:int = 178154988;

      public var cc:ChatCC;
      
      public function LoadChatModelInPacket(param1:ChatCC = null)
      {
         super();
         this.cc = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecChatCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.cc = param1 as ChatCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadChatModelInPacket();
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

