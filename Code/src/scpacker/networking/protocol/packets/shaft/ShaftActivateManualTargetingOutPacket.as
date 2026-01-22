package scpacker.networking.protocol.packets.shaft
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShaftActivateManualTargetingOutPacket extends AbstractPacket
   {
      public static const id:int = -1487306515;
      
      public function ShaftActivateManualTargetingOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShaftActivateManualTargetingOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 50;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

