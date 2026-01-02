package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SelectItemInPacket extends AbstractPacket
   {
      public static const id:int = -803365239;
      
      public var itemId:String;
      
      public function SelectItemInPacket(param1:String = "")
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
         return new SelectItemInPacket();
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
