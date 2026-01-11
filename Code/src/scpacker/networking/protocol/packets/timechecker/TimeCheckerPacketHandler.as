package scpacker.networking.protocol.packets.timechecker
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.models.timechecker.TimeCheckerModel;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TimeCheckerPacketHandler extends AbstractPacketHandler
   {
      private var timeCheckerModel:TimeCheckerModel;
      
      public function TimeCheckerPacketHandler()
      {
         super();
         this.timeCheckerModel = TimeCheckerModel(modelRegistry.getModel(Long.getLong(747925004,799189270)));
         this.id = 46;
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case TimeCheckerPingInPacket.id:
               this.ping(param1 as TimeCheckerPingInPacket);
         }
      }
      
      private function ping(param1:TimeCheckerPingInPacket) : void
      {
         this.timeCheckerModel.ping(param1.serverSessionTime,param1.clientPing);
      }
   }
}

