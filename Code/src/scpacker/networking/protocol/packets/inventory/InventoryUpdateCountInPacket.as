package scpacker.networking.protocol.packets.inventory
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class InventoryUpdateCountInPacket extends AbstractPacket
   {
      public static const id:int = -502907094;

      public var itemId:String;
      
      public var count:int;
      
      public function InventoryUpdateCountInPacket(param1:String = "", param2:int = 0)
      {
         super();
         this.itemId = param1;
         this.count = param2;
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
               this.count = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new InventoryUpdateCountInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 43;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

