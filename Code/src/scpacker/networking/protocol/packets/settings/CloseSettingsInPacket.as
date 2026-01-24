package scpacker.networking.protocol.packets.settings
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CloseSettingsInPacket extends AbstractPacket
   {
      public static const id:int = -1302674105;
      
      public function CloseSettingsInPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CloseSettingsInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 23;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

