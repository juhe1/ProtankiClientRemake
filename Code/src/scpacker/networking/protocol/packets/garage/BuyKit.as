package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class BuyKit extends AbstractPacket
   {
      public var BattleID:String;
      
      public var Base_cost:int;
      
      public function BuyKit(param1:String = "", param2:int = 0)
      {
         super();
         this.BattleID = param1;
         this.Base_cost = param2;
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
               this.BattleID = param1 as String;
               break;
            case 1:
               this.Base_cost = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BuyKit();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return -523392052;
      }
   }
}

