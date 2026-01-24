package scpacker.networking.protocol.packets.settings
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CloseSettingsOutPacket extends AbstractPacket
   {
      public static const id:int = -731115522;
      
      public var closeState:Boolean;
      
      public function CloseSettingsOutPacket(param1:Boolean = false)
      {
         super();
         this.closeState = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.closeState = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CloseSettingsOutPacket();
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

