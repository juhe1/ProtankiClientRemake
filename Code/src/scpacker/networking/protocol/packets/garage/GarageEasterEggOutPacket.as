package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class GarageEasterEggOutPacket extends AbstractPacket
   {
      public var decorName:String;
      
      public function GarageEasterEggOutPacket(param1:String = "")
      {
         super();
         this.decorName = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.decorName = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new GarageEasterEggOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 34;
      }
      
      override public function getId() : int
      {
         return -163691268;
      }
   }
}

