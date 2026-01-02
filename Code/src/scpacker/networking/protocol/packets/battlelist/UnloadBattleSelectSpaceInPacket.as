package scpacker.networking.protocol.packets.battlelist
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UnloadBattleSelectSpaceInPacket extends AbstractPacket
   {
      public static const id:int = -324155151;
      
      public function UnloadBattleSelectSpaceInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UnloadBattleSelectSpaceInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 31;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
