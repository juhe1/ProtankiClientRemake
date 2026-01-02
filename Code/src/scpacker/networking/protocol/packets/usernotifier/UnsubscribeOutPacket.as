package scpacker.networking.protocol.packets.usernotifier
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UnsubscribeOutPacket extends AbstractPacket
   {
      public var newname_8536__END:Vector.<String>;
      
      public function UnsubscribeOutPacket(param1:Vector.<String> = null)
      {
         super();
         this.newname_8536__END = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.complex.VectorCodecString");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.newname_8536__END = param1 as Vector.<String>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UnsubscribeOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 18;
      }
      
      override public function getId() : int
      {
         return -2040152224;
      }
   }
}

