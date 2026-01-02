package scpacker.networking.protocol.packets.battleInfo
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class JoinBattleOutPacket extends AbstractPacket
   {
      public var team:BattleTeam;
      
      public function JoinBattleOutPacket(param1:BattleTeam = null)
      {
         super();
         this.team = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.team = param1 as BattleTeam;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new JoinBattleOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 33;
      }
      
      override public function getId() : int
      {
         return -1284211503;
      }
   }
}

