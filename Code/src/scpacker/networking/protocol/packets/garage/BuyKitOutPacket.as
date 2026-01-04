package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class BuyKitOutPacket extends AbstractPacket
   {
      public var itemId:String;
      
      public var cost:int;
      
      public function BuyKitOutPacket(param1:String = "", param2:int = 0)
      {
         super();
         this.itemId = param1;
         this.cost = param2;
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
               this.itemId = param1 as String;
               break;
            case 1:
               this.cost = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new BuyKitOutPacket();
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

