package scpacker.networking.protocol.packets.railgun
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RailgunShootTargetInPacket extends AbstractPacket
   {
      public static const id:int = -369590613;
      
      public var shooter:String;
      
      public var staticHitPoint:Vector3d;
      
      public var targets:Vector.<String>;
      
      public var targetHitPoints:Vector.<Vector3d>;
      
      public function RailgunShootTargetInPacket(param1:String = "", param2:Vector3d = null, param3:Vector.<String> = null, param4:Vector.<Vector3d> = null)
      {
         super();
         this.shooter = param1;
         this.staticHitPoint = param2;
         this.targets = param3;
         this.targetHitPoints = param4;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.complex.VectorCodecString");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecVector3d");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooter = param1 as String;
               break;
            case 1:
               this.staticHitPoint = param1 as Vector3d;
               break;
            case 2:
               this.targets = param1 as Vector.<String>;
               break;
            case 3:
               this.targetHitPoints = param1 as Vector.<Vector3d>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RailgunShootTargetInPacket();
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

