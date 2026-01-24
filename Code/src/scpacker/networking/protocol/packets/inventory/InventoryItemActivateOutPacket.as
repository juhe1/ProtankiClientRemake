package scpacker.networking.protocol.packets.inventory
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class InventoryItemActivateOutPacket extends AbstractPacket
   {
      public static const id:int = -2102525054;

      public var itemId:String;
      
      public function InventoryItemActivateOutPacket(param1:String = "")
      {
         super();
         this.itemId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.itemId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new InventoryItemActivateOutPacket();
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

