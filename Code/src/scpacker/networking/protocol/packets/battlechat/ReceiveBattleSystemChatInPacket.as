package scpacker.networking.protocol.packets.battlechat
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ReceiveBattleSystemChatInPacket extends AbstractPacket
   {
      public static const id:int = 606668848;
      
      public var message:String;
      
      public function ReceiveBattleSystemChatInPacket(param1:String = "")
      {
         super();
         this.message = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.message = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ReceiveBattleSystemChatInPacket();
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
