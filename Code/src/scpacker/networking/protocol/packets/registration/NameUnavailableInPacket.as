package scpacker.networking.protocol.packets.registration
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class NameUnavailableInPacket extends AbstractPacket
   {
      public static const id:int = 442888643;
      
      public var usernames:Vector.<String>;
      
      public function NameUnavailableInPacket(param1:Vector.<String> = null)
      {
         super();
         this.usernames = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.complex.VectorCodecString");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.usernames = param1 as Vector.<String>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new NameUnavailableInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 8;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

