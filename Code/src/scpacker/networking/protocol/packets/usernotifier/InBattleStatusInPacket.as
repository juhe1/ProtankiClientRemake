package scpacker.networking.protocol.packets.usernotifier
{
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class InBattleStatusInPacket extends AbstractPacket
   {
      public static const id:int = -1895446889;
      
      public var userInfo:BattleNotifierData;
      
      public function InBattleStatusInPacket(param1:BattleNotifierData = null)
      {
         super();
         this.userInfo = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.Codecc1aih0g");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userInfo = param1 as BattleNotifierData;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new InBattleStatusInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 18;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
