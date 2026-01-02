package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadOwnedGarageItemsInPacket extends AbstractPacket
   {
      public static const id:int = -255516505;
      
      public var battlesJson:String;
      
      public function LoadOwnedGarageItemsInPacket(param1:String = "")
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
         return new LoadOwnedGarageItemsInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
