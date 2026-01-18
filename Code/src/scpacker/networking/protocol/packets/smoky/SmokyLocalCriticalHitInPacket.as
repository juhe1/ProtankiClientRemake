package scpacker.networking.protocol.packets.smoky
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SmokyLocalCriticalHitInPacket extends AbstractPacket
   {
      public static const id:int = -671618989;
      
      public var target:String;
      
      public function SmokyLocalCriticalHitInPacket(param1:String = "")
      {
         super();
         this.target = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.target = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SmokyLocalCriticalHitInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 49;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

