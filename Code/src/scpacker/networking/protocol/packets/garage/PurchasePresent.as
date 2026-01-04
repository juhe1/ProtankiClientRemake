package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class PurchasePresent extends AbstractPacket
   {
      public var uid:String;
      
      public var presentName:String;
      
      public var text:String;
      
      public var cost:int;
      
      public function PurchasePresent(param1:String = "", param2:String = "", param3:String = "", param4:int = 0)
      {
         super();
         this.uid = param1;
         this.presentName = param2;
         this.text = param3;
         this.cost = param4;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.uid = param1 as String;
               break;
            case 1:
               this.presentName = param1 as String;
               break;
            case 2:
               this.text = param1 as String;
               break;
            case 3:
               this.cost = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new PurchasePresent();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return -1518850075;
      }
   }
}

