package scpacker.networking.protocol.packets.battlecreate
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetFilteredBattleNameInPacket extends AbstractPacket
   {
      public static const id:int = 120401338;
      
      public var battleName:String;
      
      public function SetFilteredBattleNameInPacket(param1:String = "")
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
         return new SetFilteredBattleNameInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 30;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

