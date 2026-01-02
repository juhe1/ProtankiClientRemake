package scpacker.networking.protocol.packets.battleInfo
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SpectateBattle extends AbstractPacket
   {
      public function SpectateBattle()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SpectateBattle();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 33;
      }
      
      override public function getId() : int
      {
         return -1315002220;
      }
   }
}

