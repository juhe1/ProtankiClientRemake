package scpacker.networking.protocol.packets.ricochet
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RicochetHitTargetOutPacket extends AbstractPacket
   {
      public static const id:int = 1229701582;
      
      public var time:int;
      
      public var target:String;
      
      public var shotId:int;
      
      public var targetPosition:Vector3d;
      
      public var impactPoints:Vector.<Vector3d>;
      
      public function RicochetHitTargetOutPacket(param1:int = 0, param2:String = "", param3:int = 0, param4:Vector3d = null, param5:Vector.<Vector3d> = null)
      {
         super();
         this.time = param1;
         this.target = param2;
         this.shotId = param3;
         this.targetPosition = param4;
         this.impactPoints = param5;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param5);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecVector3d");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.time = param1 as int;
               break;
            case 1:
               this.target = param1 as String;
               break;
            case 2:
               this.shotId = param1 as int;
               break;
            case 3:
               this.targetPosition = param1 as Vector3d;
               break;
            case 4:
               this.impactPoints = param1 as Vector.<Vector3d>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RicochetHitTargetOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 53;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

