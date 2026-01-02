package scpacker.networking.protocol.packets.battleInfo
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   
   public class JoinedTeamBattleInPacket extends AbstractPacket
   {
      public static const id:int = 118447426;
      
      public var battleId:String;
      
      public var userInfo:BattleInfoUser;
      
      public var team:BattleTeam;
      
      public function JoinedTeamBattleInPacket(param1:String = "", param2:BattleInfoUser = null, param3:BattleTeam = null)
      {
         super();
         this.battleId = param1;
         this.userInfo = param2;
         this.team = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleInfoUser");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battleId = param1 as String;
               break;
            case 1:
               this.userInfo = param1 as BattleInfoUser;
               break;
            case 2:
               this.team = param1 as BattleTeam;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new JoinedTeamBattleInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 33;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
