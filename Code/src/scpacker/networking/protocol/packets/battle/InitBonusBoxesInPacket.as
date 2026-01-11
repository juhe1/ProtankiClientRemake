package scpacker.networking.protocol.packets.battle
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class InitBonusBoxesInPacket extends AbstractPacket
   {
      public static const id:int = 228171466;
      
      public var json:String;
      
      public function InitBonusBoxesInPacket(param1:String = "")
      {
         super();
         this.json = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.json = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new InitBonusBoxesInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 36;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

