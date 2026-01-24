package scpacker.networking.protocol.packets.chat
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UpdateTypingAntifloodParamsInPacket extends AbstractPacket
   {
      public static const id:int = 744948472;
      
      public var symbolCost:int;
      
      public var messageCost:int;
      
      public function UpdateTypingAntifloodParamsInPacket(param1:int = 0, param2:int = 0)
      {
         super();
         this.symbolCost = param1;
         this.messageCost = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.symbolCost = param1 as int;
               break;
            case 1:
               this.messageCost = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UpdateTypingAntifloodParamsInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 28;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

