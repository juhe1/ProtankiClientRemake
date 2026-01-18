package scpacker.networking.protocol.packets.capturetheflag
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ReturnFlagToBaseInPacket extends AbstractPacket
   {
      public static const id:int = -1026428589;
      
      public var flagTeam:BattleTeam;
      
      public var tank:String;
      
      public function ReturnFlagToBaseInPacket(param1:BattleTeam = null, param2:String = "")
      {
         super();
         this.flagTeam = param1;
         this.tank = param2;
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
               this.flagTeam = param1 as BattleTeam;
               break;
            case 1:
               this.tank = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ReturnFlagToBaseInPacket();
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

