package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class BuyMultipleItemsOutPacket extends AbstractPacket
   {
      public var itemId:String;
      
      public var count:int;
      
      public var cost:int;
      
      public function BuyMultipleItemsOutPacket(param1:String = "", param2:int = 0, param3:int = 0)
      {
         super();
         this.itemId = param1;
         this.count = param2;
         this.cost = param3;
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
               this.itemId = param1 as String;
               break;
            case 1:
               this.count = param1 as int;
               break;
            case 2:
               this.cost = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BuyMultipleItemsOutPacket();
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

