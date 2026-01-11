package scpacker.networking.protocol.packets.battle
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class newname_3685__END extends AbstractPacket
   {
      public var newname_7931__END:int;
      
      public function newname_3685__END(param1:int = 0)
      {
         super();
         this.newname_7931__END = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.newname_7931__END = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new newname_3685__END();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 36;
      }
      
      override public function getId() : int
      {
         return 201628290;
      }
   }
}

