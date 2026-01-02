package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class BuyMultipleItems extends AbstractPacket
   {
      public var BattleID:String;
      
      public var Count:int;
      
      public var Base_cost:int;
      
      public function BuyMultipleItems(param1:String = "", param2:int = 0, param3:int = 0)
      {
         super();
         this.BattleID = param1;
         this.Count = param2;
         this.Base_cost = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param3);
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
               this.Count = param1 as int;
               break;
            case 2:
               this.Base_cost = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BuyMultipleItems();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return -1961983005;
      }
   }
}

