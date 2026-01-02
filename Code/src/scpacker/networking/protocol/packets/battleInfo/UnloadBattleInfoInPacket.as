package scpacker.networking.protocol.packets.battleInfo
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UnloadBattleInfoInPacket extends AbstractPacket
   {
      public static const id:int = -602527073;
      
      public var battleId:String;
      
      public function UnloadBattleInfoInPacket(param1:String = "")
      {
         super();
         this.battleId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battleId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UnloadBattleInfoInPacket();
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
