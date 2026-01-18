package scpacker.networking.protocol.packets.isida
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class IsidaStopOutPacket extends AbstractPacket
   {
      public var ClientTime:int;
      
      public function IsidaStopOutPacket(param1:int = 0)
      {
         super();
         this.ClientTime = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.ClientTime = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new IsidaStopOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 55;
      }
      
      override public function getId() : int
      {
         return -1051248475;
      }
   }
}

