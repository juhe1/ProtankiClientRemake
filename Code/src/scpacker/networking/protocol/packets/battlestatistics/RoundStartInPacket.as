package scpacker.networking.protocol.packets.battlestatistics
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RoundStartInPacket extends AbstractPacket
   {
      public static const id:int = 732434644;
      
      public var timeLimitInSec:int;
      
      public function RoundStartInPacket(param1:int = 0)
      {
         super();
         this.timeLimitInSec = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.timeLimitInSec = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RoundStartInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 37;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

