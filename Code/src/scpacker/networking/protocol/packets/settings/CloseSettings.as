package scpacker.networking.protocol.packets.settings
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CloseSettings extends AbstractPacket
   {
      public var Close_state:Boolean;
      
      public function CloseSettings(param1:Boolean = false)
      {
         super();
         this.Close_state = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.Close_state = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CloseSettings();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 23;
      }
      
      override public function getId() : int
      {
         return -731115522;
      }
   }
}

