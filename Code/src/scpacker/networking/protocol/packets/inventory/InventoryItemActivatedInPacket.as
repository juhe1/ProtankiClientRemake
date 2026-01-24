package scpacker.networking.protocol.packets.inventory
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class InventoryItemActivatedInPacket extends AbstractPacket
   {
      public static const id:int = 2032104949;

      public var itemId:String;
      
      public var clientTime:int;
      
      public var decrease:Boolean;
      
      public function InventoryItemActivatedInPacket(param1:String = "", param2:int = 0, param3:Boolean = false)
      {
         super();
         this.itemId = param1;
         this.clientTime = param2;
         this.decrease = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.itemId = param1 as String;
               break;
            case 1:
               this.clientTime = param1 as int;
               break;
            case 2:
               this.decrease = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new InventoryItemActivatedInPacket();
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

