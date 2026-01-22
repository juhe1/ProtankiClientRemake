package scpacker.networking.protocol.packets.shaft
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShaftLaserUpdateDirectionInPacket extends AbstractPacket
   {
      public static const id:int = -534192254;
      
      public var shooterId:String;
      
      public var projectionOnVerticalAxis:Number;
      
      public function ShaftLaserUpdateDirectionInPacket(param1:String = "", param2:Number = 0)
      {
         super();
         this.shooterId = param1;
         this.projectionOnVerticalAxis = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooterId = param1 as String;
               break;
            case 1:
               this.projectionOnVerticalAxis = param1 as Number;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShaftLaserUpdateDirectionInPacket();
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

