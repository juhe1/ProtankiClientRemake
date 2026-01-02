package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class MountItem extends AbstractPacket
   {
      public var itemId:String;
      
      public function MountItem(param1:String = "")
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
         return new MountItem();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return -1505530736;
      }
   }
}

