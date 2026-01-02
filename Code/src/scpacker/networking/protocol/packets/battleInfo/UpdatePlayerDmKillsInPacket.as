package scpacker.networking.protocol.packets.battleInfo
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UpdatePlayerDmKillsInPacket extends AbstractPacket
   {
      public static const id:int = -1263036614;
      
      public var battleId:String;
      
      public var userId:String;
      
      public var kills:int;
      
      public function UpdatePlayerDmKillsInPacket(param1:String = "", param2:String = "", param3:int = 0)
      {
         super();
         this.battleId = param1;
         this.userId = param2;
         this.kills = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battleId = param1 as String;
               break;
            case 1:
               this.userId = param1 as String;
               break;
            case 2:
               this.kills = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UpdatePlayerDmKillsInPacket();
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
