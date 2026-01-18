package scpacker.networking.protocol.packets.capturetheflag
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class FlagDeliveredInPacket extends AbstractPacket
   {
      public static const id:int = -1870108387;
      
      public var winnerTeam:BattleTeam;
      
      public var delivererTankId:String;
      
      public function FlagDeliveredInPacket(param1:BattleTeam = null, param2:String = "")
      {
         super();
         this.winnerTeam = param1;
         this.delivererTankId = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.winnerTeam = param1 as BattleTeam;
               break;
            case 1:
               this.delivererTankId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new FlagDeliveredInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 42;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

