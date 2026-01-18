package scpacker.networking.protocol.packets.flamethrower
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class FlamethrowerHitOutPacket extends AbstractPacket
   {
      public static const id:int = 1395251766;
      
      public var clientTime:int;
      
      public var targets:Vector.<String>;
      
      public var incarnationIDs:Vector.<int>;
      
      public var targetBodyPositions:Vector.<Vector3d>;
      
      public var targetHitPointsGlobal:Vector.<Vector3d>;
      
      public function FlamethrowerHitOutPacket(param1:int = 0, param2:Vector.<String> = null, param3:Vector.<int> = null, param4:Vector.<Vector3d> = null, param5:Vector.<Vector3d> = null)
      {
         super();
         this.clientTime = param1;
         this.targets = param2;
         this.incarnationIDs = param3;
         this.targetBodyPositions = param4;
         this.targetHitPointsGlobal = param5;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.complex.VectorCodecString");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecShort");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecVector3d");
         registerProperty(param5);
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
               this.targets = param1 as Vector.<String>;
               break;
            case 2:
               this.incarnationIDs = param1 as Vector.<int>;
               break;
            case 3:
               this.targetBodyPositions = param1 as Vector.<Vector3d>;
               break;
            case 4:
               this.targetHitPointsGlobal = param1 as Vector.<Vector3d>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new FlamethrowerHitOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 57;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
