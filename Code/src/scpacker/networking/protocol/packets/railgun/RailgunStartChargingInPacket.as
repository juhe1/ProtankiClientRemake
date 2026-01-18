package scpacker.networking.protocol.packets.railgun
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RailgunStartChargingInPacket extends AbstractPacket
   {
      public static const id:int = 346830254;
      
      public var shooter:String;
      
      public function RailgunStartChargingInPacket(param1:String = "")
      {
         super();
         this.shooter = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooter = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RailgunStartChargingInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 54;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

