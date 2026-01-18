package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetTankTemperatureInPacket extends AbstractPacket
   {
      public static const id:int = 581377054;

      public var tankId:String;
      
      public var temperature:Number;
      
      public function SetTankTemperatureInPacket(param1:String = "", param2:Number = 0)
      {
         super();
         this.tankId = param1;
         this.temperature = param2;
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
               this.tankId = param1 as String;
               break;
            case 1:
               this.temperature = param1 as Number;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SetTankTemperatureInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 39;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

