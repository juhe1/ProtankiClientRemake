package scpacker.networking.protocol.packets.userproperties
{
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UpdateRankInPacket extends AbstractPacket
   {
      public static const id:int = 1989173907;
      
      public var rank:int;

      public var score:int;
      
      public var currentRankScore:int;
      
      public var nextScore:int;
      
      public var crystalGift:int;
      
      public function UpdateRankInPacket(_rank:int = 0, _score:int = 0, _currentRankScore:int = 0, _nextScore:int = 0, _crystalGift:int = 0)
      {
         super();
         this.rank = _rank;
         this.score = _score;
         this.currentRankScore = _currentRankScore;
         this.nextScore = _nextScore;
         this.crystalGift = _crystalGift;
         registerProperty(_rank);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(_score);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(_currentRankScore);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(_nextScore);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(_crystalGift);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.rank = param1 as int;
               break;
            case 1:
               this.score = param1 as int;
               break;
            case 2:
               this.currentRankScore = param1 as int;
               break;
            case 3:
               this.nextScore = param1 as int;
               break;
            case 4:
               this.crystalGift = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UpdateRankInPacket();
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
