package scpacker.networking.protocol.packets.battleInfo
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   
   public class JoinedDmBattleInPacket extends AbstractPacket
   {
      public static const id:int = -911626491;
      
      public var battleId:String;
      
      public var userInfo:BattleInfoUser;
      
      public function JoinedDmBattleInPacket(param1:String = "", param2:BattleInfoUser = null)
      {
         super();
         this.battleId = param1;
         this.userInfo = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleInfoUser");
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
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new JoinedDmBattleInPacket();
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
