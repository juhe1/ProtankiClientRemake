package scpacker.networking.protocol.packets.userproperties
{
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UpdateScoreInPacket extends AbstractPacket
   {
      public static const id:int = 2116086491;
      
      public var score:int;
      
      public function UpdateScoreInPacket(_score:int = 0)
      {
         super();
         this.score = _score;
         registerProperty(_score);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.score = param1 as int;
               break;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UpdateScoreInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 29;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}