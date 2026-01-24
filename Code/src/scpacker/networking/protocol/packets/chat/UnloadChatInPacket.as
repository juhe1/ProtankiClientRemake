package scpacker.networking.protocol.packets.chat
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UnloadChatInPacket extends AbstractPacket
   {
      public static const id:int = -920985123;
      
      public function UnloadChatInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UnloadChatInPacket();
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

