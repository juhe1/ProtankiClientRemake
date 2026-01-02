package scpacker.networking.protocol.packets.battleitem
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class JoinedTeamBattleInPacket extends AbstractPacket
   {
      public static const id:int = -169305322;
      
      public var battleId:String;
      
      public var userId:String;
      
      public var team:BattleTeam;
      
      public function JoinedTeamBattleInPacket(param1:String = "", param2:String = "", param3:BattleTeam = null)
      {
         super();
         this.battleId = param1;
         this.userId = param2;
         this.team = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
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
               this.userId = param1 as String;
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
         return 32;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
