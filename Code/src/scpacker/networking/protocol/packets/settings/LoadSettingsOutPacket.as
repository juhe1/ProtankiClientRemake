package scpacker.networking.protocol.packets.settings
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadSettingsOutPacket extends AbstractPacket
   {
      public static const id:int = 850220815;
      
      public function LoadSettingsOutPacket()
      {
         super();
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadSettingsOutPacket();
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

