package scpacker.networking.protocol.packets.statisticsteam
{
   import projects.tanks.client.battleservice.model.statistics.team.StatisticsTeamCC;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class InitStatisticsTeamModelInPacket extends AbstractPacket
   {
      public static const id:int = -1233891872;

      public var statisticsTeamCC:StatisticsTeamCC;
      
      public function InitStatisticsTeamModelInPacket(param1:StatisticsTeamCC = null)
      {
         super();
         this.statisticsTeamCC = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecStatisticsTeamCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.statisticsTeamCC = param1 as StatisticsTeamCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new InitStatisticsTeamModelInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 44;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

