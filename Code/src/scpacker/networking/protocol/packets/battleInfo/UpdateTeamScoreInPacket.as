package scpacker.networking.protocol.packets.battleInfo
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UpdateTeamScoreInPacket extends AbstractPacket
   {
      public static const id:int = 1428217189;
      
      public var battleId:String;
      
      public var team:BattleTeam;
      
      public var score:int;
      
      public function UpdateTeamScoreInPacket(param1:String = "", param2:BattleTeam = null, param3:int = 0)
      {
         super();
         this.battleId = param1;
         this.team = param2;
         this.score = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battleId = param1 as String;
               break;
            case 1:
               this.team = param1 as BattleTeam;
               break;
            case 2:
               this.score = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UpdateTeamScoreInPacket();
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
