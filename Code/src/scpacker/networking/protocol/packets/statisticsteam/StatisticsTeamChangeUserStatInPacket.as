package scpacker.networking.protocol.packets.statisticsteam
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.statistics.UserStat;
   
   public class StatisticsTeamChangeUserStatInPacket extends AbstractPacket
   {
      public static const id:int = -497293992;

      public var userStats:UserStat;
      
      public var team:BattleTeam;
      
      public function StatisticsTeamChangeUserStatInPacket(param1:UserStat = null, param2:BattleTeam = null)
      {
         super();
         this.userStats = param1;
         this.team = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecUserStat");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userStats = param1 as UserStat;
               break;
            case 1:
               this.team = param1 as BattleTeam;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new StatisticsTeamChangeUserStatInPacket();
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

