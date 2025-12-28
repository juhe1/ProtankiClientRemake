package scpacker.networking.protocol.packets.battlelist
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CheckBattleNameOutPacket extends AbstractPacket
   {
      public var battleName:String;
      
      public function CheckBattleNameOutPacket(param1:String = "")
      {
         super();
         this.battleName = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battleName = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CheckBattleNameOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 30;
      }
      
      override public function getId() : int
      {
         return 566652736;
      }
   }
}

