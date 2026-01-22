package scpacker.networking.protocol.packets.friends
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class BattleKickReasonInPacket extends AbstractPacket
   {
      public static const id:int = 1441234714;
      
      public function BattleKickReasonInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BattleKickReasonInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 13;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
