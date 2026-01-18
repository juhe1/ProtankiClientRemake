package scpacker.networking.protocol.packets.battlechat
{
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ReceiveBattleChatInPacket extends AbstractPacket
   {
      public static const id:int = 1259981343;
      
      public var userId:String;
      
      public var message:String;
      
      public var team:BattleTeam;
      
      public function ReceiveBattleChatInPacket(param1:String = "", param2:String = "", param3:BattleTeam = null)
      {
         super();
         this.userId = param1;
         this.message = param2;
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
               this.userId = param1 as String;
               break;
            case 1:
               this.message = param1 as String;
               break;
            case 2:
               this.team = param1 as BattleTeam;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ReceiveBattleChatInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 61;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
