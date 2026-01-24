package scpacker.networking.protocol.packets.settings
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class OpenSettingsInPacket extends AbstractPacket
   {
      public static const id:int = 1447082276;
      
      public var notificationEnabled:Boolean;
      
      public function OpenSettingsInPacket(param1:Boolean = false)
      {
         super();
         this.notificationEnabled = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.notificationEnabled = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new OpenSettingsInPacket();
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

