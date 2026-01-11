package scpacker.networking.protocol.packets.battle
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UnloadBattleSpaceInPacket extends AbstractPacket
   {
      public static const id:int = -985579124;
      
      public function UnloadBattleSpaceInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UnloadBattleSpaceInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 36;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

