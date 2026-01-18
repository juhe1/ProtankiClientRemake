package scpacker.networking.protocol.packets.flamethrower
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class FlamethrowerStopOutPacket extends AbstractPacket
   {
      public static const id:int = -1300958299;
      
      public var clientTime:int;
      
      public function FlamethrowerStopOutPacket(param1:int = 0)
      {
         super();
         this.clientTime = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.clientTime = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new FlamethrowerStopOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 57;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
