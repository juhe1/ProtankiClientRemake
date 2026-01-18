package scpacker.networking.protocol.packets.statisticsteam
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class StatisticsTeamUserLeftInPacket extends AbstractPacket
   {
      public static const id:int = 1411656080;

      public var userId:String;
      
      public function StatisticsTeamUserLeftInPacket(param1:String = "")
      {
         super();
         this.userId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new StatisticsTeamUserLeftInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 44;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

