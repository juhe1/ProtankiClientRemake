package scpacker.networking.protocol.packets.battlecreate
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class BattleCreateFailedServerHaltingInPacket extends AbstractPacket
   {
      public static const id:int = 566338297;
      
      public function BattleCreateFailedServerHaltingInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BattleCreateFailedServerHaltingInPacket();
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

