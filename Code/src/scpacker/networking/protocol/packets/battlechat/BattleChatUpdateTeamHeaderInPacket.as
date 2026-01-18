package scpacker.networking.protocol.packets.battlechat
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class BattleChatUpdateTeamHeaderInPacket extends AbstractPacket
   {
      public static const id:int = -1331361684;
      
      public var header:String;
      
      public function BattleChatUpdateTeamHeaderInPacket(param1:String = "")
      {
         super();
         this.header = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.header = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BattleChatUpdateTeamHeaderInPacket();
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

