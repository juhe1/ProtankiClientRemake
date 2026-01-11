package scpacker.networking.protocol.packets.statisticsdm
{
   import projects.tanks.client.battleservice.model.statistics.dm.StatisticsDMCC;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class InitDMStatisticsInPacket extends AbstractPacket
   {
      public static const id:int = -1959138292;

      public var statisticsDmCC:StatisticsDMCC;
      
      public function InitDMStatisticsInPacket(param1:StatisticsDMCC = null)
      {
         super();
         this.statisticsDmCC = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecStatisticsDMCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.statisticsDmCC = param1 as StatisticsDMCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new InitDMStatisticsInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 48;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

