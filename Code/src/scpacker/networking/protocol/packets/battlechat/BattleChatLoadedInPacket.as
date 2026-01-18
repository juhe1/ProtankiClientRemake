package scpacker.networking.protocol.packets.battlechat
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class BattleChatLoadedInPacket extends AbstractPacket
   {
      public static const id:int = -643105296;
      
      public function BattleChatLoadedInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BattleChatLoadedInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 61;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

