package scpacker.networking.protocol.packets.timechecker
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TimeCheckerPongOutPacket extends AbstractPacket
   {
      public static const id:int = 2074243318;
      
      public var time:int;
      
      public var serverSessionTime:int;
      
      public function TimeCheckerPongOutPacket(param1:int = 0, param2:int = 0)
      {
         super();
         this.time = param1;
         this.serverSessionTime = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.time = param1 as int;
               break;
            case 1:
               this.serverSessionTime = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new TimeCheckerPongOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 46;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

