package scpacker.networking.protocol.packets.battlestatistics
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.statistics.StatisticsModelCC;
   
   public class InitStatisticsInPacket extends AbstractPacket
   {
      public static const id:int = 522993449;
      
      public var statisticsModelCC:StatisticsModelCC;
      
      public function InitStatisticsInPacket(param1:StatisticsModelCC = null)
      {
         super();
         this.statisticsModelCC = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecStatisticsModelCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.statisticsModelCC = param1 as StatisticsModelCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new InitStatisticsInPacket();
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

