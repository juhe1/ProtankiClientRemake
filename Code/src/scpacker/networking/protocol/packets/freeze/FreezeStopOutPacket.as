package scpacker.networking.protocol.packets.freeze
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class FreezeStopOutPacket extends AbstractPacket
   {
      public static const id:int = -1654947652;
      
      public var clientTime:int;
      
      public function FreezeStopOutPacket(param1:int = 0)
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
         return new FreezeStopOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 56;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

