package scpacker.networking.protocol.packets.thunder
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ThunderShootTargetOutPacket extends AbstractPacket
   {
      public static const id:int = 259979915;
      
      public var time:int;
      
      public var relativeHitPoint:Vector3d;
      
      public var target:String;
      
      public var incarnation:int;
      
      public var targetPosition:Vector3d;
      
      public var hitPointWorld:Vector3d;
      
      public function ThunderShootTargetOutPacket(param1:int = 0, param2:Vector3d = null, param3:String = "", param4:int = 0, param5:Vector3d = null, param6:Vector3d = null)
      {
         super();
         this.time = param1;
         this.relativeHitPoint = param2;
         this.target = param3;
         this.incarnation = param4;
         this.targetPosition = param5;
         this.hitPointWorld = param6;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         registerProperty(param5);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param6);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.time = param1 as int;
               break;
            case 1:
               this.relativeHitPoint = param1 as Vector3d;
               break;
            case 2:
               this.target = param1 as String;
               break;
            case 3:
               this.incarnation = param1 as int;
               break;
            case 4:
               this.targetPosition = param1 as Vector3d;
               break;
            case 5:
               this.hitPointWorld = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ThunderShootTargetOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 52;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

