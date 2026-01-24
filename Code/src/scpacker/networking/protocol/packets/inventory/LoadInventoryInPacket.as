package scpacker.networking.protocol.packets.inventory
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadInventoryInPacket extends AbstractPacket
   {
      public static const id:int = -137249251;

      public var battlesJson:String;
      
      public function LoadInventoryInPacket(param1:String = "")
      {
         super();
         this.battlesJson = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battlesJson = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadInventoryInPacket();
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

