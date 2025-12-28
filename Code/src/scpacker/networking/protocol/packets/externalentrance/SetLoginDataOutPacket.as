package scpacker.networking.protocol.packets.externalentrance
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetLoginDataOutPacket extends AbstractPacket
   {
      public var rememberMe:Boolean;
      
      public function SetLoginDataOutPacket(param1:Boolean = false)
      {
         super();
         this.rememberMe = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.rememberMe = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SetLoginDataOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 3;
      }
      
      override public function getId() : int
      {
         return -1967950183;
      }
   }
}

