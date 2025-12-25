package scpacker.networking.protocol.packets.init
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ActivateProtection extends AbstractPacket
   {
      public var Keys:Vector.<int>;
      
      public function ActivateProtection(param1:Vector.<int> = null)
      {
         super();
         this.Keys = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecByte");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.Keys = param1 as Vector.<int>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ActivateProtection();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 4;
      }
      
      override public function getId() : int
      {
         return 2001736388;
      }
   }
}

