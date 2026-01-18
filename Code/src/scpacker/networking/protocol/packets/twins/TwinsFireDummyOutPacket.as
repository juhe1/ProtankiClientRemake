package scpacker.networking.protocol.packets.twins
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TwinsFireDummyOutPacket extends AbstractPacket
   {
      public var Time:int;
      
      public var Barrel:int;
      
      public function TwinsFireDummyOutPacket(param1:int = 0, param2:int = 0)
      {
         super();
         this.Time = param1;
         this.Barrel = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.Time = param1 as int;
               break;
            case 1:
               this.Barrel = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new TwinsFireDummyOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 51;
      }
      
      override public function getId() : int
      {
         return -1805942142;
      }
   }
}

