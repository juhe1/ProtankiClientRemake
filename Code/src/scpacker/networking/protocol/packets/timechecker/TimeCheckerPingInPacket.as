package scpacker.networking.protocol.packets.timechecker
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TimeCheckerPingInPacket extends AbstractPacket
   {
      public static const id:int = 34068208;
      
      public var serverSessionTime:int;
      
      public var clientPing:int;
      
      public function TimeCheckerPingInPacket(param1:int = 0, param2:int = 0)
      {
         super();
         this.serverSessionTime = param1;
         this.clientPing = param2;
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
               this.serverSessionTime = param1 as int;
               break;
            case 1:
               this.clientPing = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new TimeCheckerPingInPacket();
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

