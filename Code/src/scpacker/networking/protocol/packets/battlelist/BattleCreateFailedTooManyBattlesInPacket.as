package scpacker.networking.protocol.packets.battlelist
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class BattleCreateFailedTooManyBattlesInPacket extends AbstractPacket
   {
      public static const id:int = -614313838;
      
      public function BattleCreateFailedTooManyBattlesInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BattleCreateFailedTooManyBattlesInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 30;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

