package scpacker.networking.protocol.packets.init
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ActivateProtectionInPacket extends AbstractPacket
   {
      public static const id:int = 2001736388;
      
      public var keys:Vector.<int>;
      
      public function ActivateProtectionInPacket(param1:Vector.<int> = null)
      {
         super();
         this.keys = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecByte");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.keys = param1 as Vector.<int>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ActivateProtectionInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 4;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
