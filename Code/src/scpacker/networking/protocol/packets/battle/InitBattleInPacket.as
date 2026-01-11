package scpacker.networking.protocol.packets.battle
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class InitBattleInPacket extends AbstractPacket
   {
      public static const id:int = -152638117;
      
      public var json:String;
      
      public function InitBattleInPacket(param1:String = "")
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
         return new InitBattleInPacket();
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

