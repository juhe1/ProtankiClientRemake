package scpacker.networking.protocol.packets.capturetheflag
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class FlagTakenInPacket extends AbstractPacket
   {
      public static const id:int = -1282406496;
      
      public var tankId:String;
      
      public var flagTeam:BattleTeam;
      
      public function FlagTakenInPacket(param1:String = "", param2:BattleTeam = null)
      {
         super();
         this.tankId = param1;
         this.flagTeam = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleTeam");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tankId = param1 as String;
               break;
            case 1:
               this.flagTeam = param1 as BattleTeam;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new FlagTakenInPacket();
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

