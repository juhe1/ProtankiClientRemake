package scpacker.networking.protocol.packets.shaft
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShaftLaserHideOutPacket extends AbstractPacket
   {
      public static const id:int = 843751647;
      
      public function ShaftLaserHideOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShaftLaserHideOutPacket();
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

