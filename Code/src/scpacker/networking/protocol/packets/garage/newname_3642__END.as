package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class newname_3642__END extends AbstractPacket
   {
      public var newname_6510__END:String;
      
      public function newname_3642__END(param1:String = "")
      {
         super();
         this.newname_6510__END = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.newname_6510__END = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new newname_3642__END();
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

