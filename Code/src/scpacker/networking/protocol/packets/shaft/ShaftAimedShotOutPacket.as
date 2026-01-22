package scpacker.networking.protocol.packets.shaft
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShaftAimedShotOutPacket extends AbstractPacket
   {
      public static const id:int = 1632423559;
      
      public var clientTime:int;
      
      public var staticHitPoint:Vector3d;
      
      public var targets:Vector.<String>;
      
      public var targetHitPoints:Vector.<Vector3d>;
      
      public var targetIncarnation:Vector.<int>;
      
      public var targetBodyPositions:Vector.<Vector3d>;
      
      public var targetHitPointsGlobal:Vector.<Vector3d>;
      
      public function ShaftAimedShotOutPacket(param1:int = 0, param2:Vector3d = null, param3:Vector.<String> = null, param4:Vector.<Vector3d> = null, param5:Vector.<int> = null, param6:Vector.<Vector3d> = null, param7:Vector.<Vector3d> = null)
      {
         super();
         this.clientTime = param1;
         this.staticHitPoint = param2;
         this.targets = param3;
         this.targetHitPoints = param4;
         this.targetIncarnation = param5;
         this.targetBodyPositions = param6;
         this.targetHitPointsGlobal = param7;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.complex.VectorCodecString");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecVector3d");
         registerProperty(param5);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecShort");
         registerProperty(param6);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecVector3d");
         registerProperty(param7);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecVector3d");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.clientTime = param1 as int;
               break;
            case 1:
               this.staticHitPoint = param1 as Vector3d;
               break;
            case 2:
               this.targets = param1 as Vector.<String>;
               break;
            case 3:
               this.targetHitPoints = param1 as Vector.<Vector3d>;
               break;
            case 4:
               this.targetIncarnation = param1 as Vector.<int>;
               break;
            case 5:
               this.targetBodyPositions = param1 as Vector.<Vector3d>;
               break;
            case 6:
               this.targetHitPointsGlobal = param1 as Vector.<Vector3d>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShaftAimedShotOutPacket();
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

