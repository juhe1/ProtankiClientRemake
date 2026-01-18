package scpacker.networking.protocol.packets.controlpoints
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TankEnteredPointZoneInPacket extends AbstractPacket
   {
      public static const id:int = -456245145;
      
      public var pointId:int;
      
      public var tankId:String;
      
      public function TankEnteredPointZoneInPacket(param1:int = 0, param2:String = "")
      {
         super();
         this.pointId = param1;
         this.tankId = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.pointId = param1 as int;
               break;
            case 1:
               this.tankId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new TankEnteredPointZoneInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 60;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

