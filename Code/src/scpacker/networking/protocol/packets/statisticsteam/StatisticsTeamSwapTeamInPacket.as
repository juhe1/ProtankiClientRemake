package scpacker.networking.protocol.packets.statisticsteam
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.statistics.UserStat;
   
   public class StatisticsTeamSwapTeamInPacket extends AbstractPacket
   {
      public static const id:int = -1668779175;

      public var teamAUserStats:Vector.<UserStat>;
      
      public var teamBUserStats:Vector.<UserStat>;
      
      public function StatisticsTeamSwapTeamInPacket(param1:Vector.<UserStat> = null, param2:Vector.<UserStat> = null)
      {
         super();
         this.teamAUserStats = param1;
         this.teamBUserStats = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecUserStat");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecUserStat");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.teamAUserStats = param1 as Vector.<UserStat>;
               break;
            case 1:
               this.teamBUserStats = param1 as Vector.<UserStat>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new StatisticsTeamSwapTeamInPacket();
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

