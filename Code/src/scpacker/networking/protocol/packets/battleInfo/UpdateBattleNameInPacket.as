package scpacker.networking.protocol.packets.battleInfo
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UpdateBattleNameInPacket extends AbstractPacket
   {
      public static const id:int = 1561014187;
      
      public var battleId:String;
      
      public var battleName:String;
      
      public function UpdateBattleNameInPacket(param1:String = "", param2:String = "")
      {
         super();
         this.battleId = param1;
         this.battleName = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battleId = param1 as String;
               break;
            case 1:
               this.battleName = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UpdateBattleNameInPacket();
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
