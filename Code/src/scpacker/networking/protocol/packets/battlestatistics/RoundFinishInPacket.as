package scpacker.networking.protocol.packets.battlestatistics
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.statistics.UserReward;
   
   public class RoundFinishInPacket extends AbstractPacket
   {
      public static const id:int = 560336625;
      
      public var reward:Vector.<UserReward>;
      
      public var timeToRestart:int;
      
      public function RoundFinishInPacket(param1:Vector.<UserReward> = null, param2:int = 0)
      {
         super();
         this.reward = param1;
         this.timeToRestart = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecUserReward");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.reward = param1 as Vector.<UserReward>;
               break;
            case 1:
               this.timeToRestart = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RoundFinishInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 37;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

