package scpacker.networking.protocol.packets.battle
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class newname_3687__END extends AbstractPacket
   {
      public var newname_758__END:Vector.<int>;
      
      public function newname_3687__END(param1:Vector.<int> = null)
      {
         super();
         this.newname_758__END = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.complex.VectorCodecInt");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.newname_758__END = param1 as Vector.<int>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new newname_3687__END();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 36;
      }
      
      override public function getId() : int
      {
         return -745598420;
      }
   }
}

