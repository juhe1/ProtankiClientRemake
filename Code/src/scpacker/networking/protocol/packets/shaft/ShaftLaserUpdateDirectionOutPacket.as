package scpacker.networking.protocol.packets.shaft
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShaftLaserUpdateDirectionOutPacket extends AbstractPacket
   {
      public static const id:int = 1224288585;
      
      public var projectionOnVerticalAxis:Number;
      
      public function ShaftLaserUpdateDirectionOutPacket(param1:Number = 0)
      {
         super();
         this.projectionOnVerticalAxis = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.projectionOnVerticalAxis = param1 as Number;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShaftLaserUpdateDirectionOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 50;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

