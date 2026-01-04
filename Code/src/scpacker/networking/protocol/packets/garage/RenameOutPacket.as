package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RenameOutPacket extends AbstractPacket
   {
      public var newName:String;
      
      public function RenameOutPacket(param1:String = "")
      {
         super();
         this.newName = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.newName = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RenameOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return -161726525;
      }
   }
}

