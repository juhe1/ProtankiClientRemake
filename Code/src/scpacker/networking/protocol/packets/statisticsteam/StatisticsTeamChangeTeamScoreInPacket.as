package scpacker.networking.protocol.packets.statisticsteam
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class StatisticsTeamChangeTeamScoreInPacket extends AbstractPacket
   {
      public static const id:int = 561771020;

      public var team:BattleTeam;
      
      public var score:int;
      
      public function StatisticsTeamChangeTeamScoreInPacket(param1:BattleTeam = null, param2:int = 0)
      {
         super();
         this.team = param1;
         this.score = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.team = param1 as BattleTeam;
               break;
            case 1:
               this.score = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new StatisticsTeamChangeTeamScoreInPacket();
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

