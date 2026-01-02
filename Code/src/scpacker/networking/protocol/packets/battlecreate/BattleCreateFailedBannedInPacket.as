package scpacker.networking.protocol.packets.battlecreate
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class BattleCreateFailedBannedInPacket extends AbstractPacket
   {
      public static const id:int = -1491503394;
      
      public function BattleCreateFailedBannedInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BattleCreateFailedBannedInPacket();
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

