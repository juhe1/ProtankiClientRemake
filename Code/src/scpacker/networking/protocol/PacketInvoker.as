package scpacker.networking.protocol
{   
   public class PacketInvoker
   {
      private var packetHandlers:Vector.<AbstractPacketHandler> = new Vector.<AbstractPacketHandler>(95);
      
      public function PacketInvoker()
      {
         super();
      }
      
      public function registerPacketHandler(param1:AbstractPacketHandler) : void
      {
         packetHandlers[param1.id] = param1;
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         var _loc2_:Object = packetHandlers[param1.getPacketHandlerId()];
         _loc2_.invoke(param1);
      }
   }
}

