package scpacker.networking.protocol.packets.shotgun
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShotgunShotOutPacket extends AbstractPacket
   {
      public static const id:int = -541655881;
      
      public var time:int;
      
      public var shootDirection:Vector3d;
      
      public var targets:Vector.<TargetPosition>;
      
      public function ShotgunShotOutPacket(param1:int = 0, param2:Vector3d = null, param3:Vector.<TargetPosition> = null)
      {
         super();
         this.time = param1;
         this.shootDirection = param2;
         this.targets = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecTargetPosition");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.time = param1 as int;
               break;
            case 1:
               this.shootDirection = param1 as Vector3d;
               break;
            case 2:
               this.targets = param1 as Vector.<TargetPosition>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShotgunShotOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 70;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

