package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetSpecificationInPacket extends AbstractPacket
   {
      public static const id:int = -1672577397;

      public var tankId:String;
      
      public var maxSpeed:Number;
      
      public var maxTurnSpeed:Number;
      
      public var maxTurretRotationSpeed:Number;
      
      public var acceleration:Number;
      
      public var specificationId:int;
      
      public function SetSpecificationInPacket(param1:String = "", param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:int = 0)
      {
         super();
         this.tankId = param1;
         this.maxSpeed = param2;
         this.maxTurnSpeed = param3;
         this.maxTurretRotationSpeed = param4;
         this.acceleration = param5;
         this.specificationId = param6;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         registerProperty(param5);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         registerProperty(param6);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tankId = param1 as String;
               break;
            case 1:
               this.maxSpeed = param1 as Number;
               break;
            case 2:
               this.maxTurnSpeed = param1 as Number;
               break;
            case 3:
               this.maxTurretRotationSpeed = param1 as Number;
               break;
            case 4:
               this.acceleration = param1 as Number;
               break;
            case 5:
               this.specificationId = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SetSpecificationInPacket();
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

