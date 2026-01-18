package scpacker.networking.protocol.packets.statisticsteam
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   
   public class StatisticsTeamUserConnectInPacket extends AbstractPacket
   {
      public static const id:int = 2040021062;

      public var userId:String;
      
      public var userInfos:Vector.<UserInfo>;
      
      public var team:BattleTeam;
      
      public function StatisticsTeamUserConnectInPacket(param1:String = "", param2:Vector.<UserInfo> = null, param3:BattleTeam = null)
      {
         super();
         this.userId = param1;
         this.userInfos = param2;
         this.team = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecUserInfo");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userId = param1 as String;
               break;
            case 1:
               this.userInfos = param1 as Vector.<UserInfo>;
               break;
            case 2:
               this.team = param1 as BattleTeam;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new StatisticsTeamUserConnectInPacket();
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

