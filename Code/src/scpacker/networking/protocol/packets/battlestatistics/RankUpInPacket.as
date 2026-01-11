package scpacker.networking.protocol.packets.battlestatistics
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RankUpInPacket extends AbstractPacket
   {
      public static const id:int = 1262947513;
      
      public var userId:String;
      
      public var rank:int;
      
      public function RankUpInPacket(param1:String = "", param2:int = 0)
      {
         super();
         this.userId = param1;
         this.rank = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userId = param1 as String;
               break;
            case 1:
               this.rank = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RankUpInPacket();
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

