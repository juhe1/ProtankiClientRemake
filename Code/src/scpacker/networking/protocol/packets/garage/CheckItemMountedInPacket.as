package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CheckItemMountedInPacket extends AbstractPacket
   {
      public static const id:int = 2062201643;
      
      public var itemId:String;
      
      public var mounted:Boolean;
      
      public function CheckItemMountedInPacket(param1:String = "", param2:Boolean = false)
      {
         super();
         this.itemId = param1;
         this.mounted = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
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
               this.mounted = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CheckItemMountedInPacket();
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
