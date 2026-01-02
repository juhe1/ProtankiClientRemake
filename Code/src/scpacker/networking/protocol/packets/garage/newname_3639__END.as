package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class newname_3639__END extends AbstractPacket
   {
      public var newname_6509__END:int;
      
      public function newname_3639__END(param1:int = 0)
      {
         super();
         this.newname_6509__END = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.newname_6509__END = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new newname_3639__END();
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

