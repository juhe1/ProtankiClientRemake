package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RemovePresentOutPacket extends AbstractPacket
   {
      public var presentId:int;
      
      public function RemovePresentOutPacket(param1:int = 0)
      {
         super();
         this.presentId = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.presentId = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RemovePresentOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return -2001666558;
      }
   }
}

