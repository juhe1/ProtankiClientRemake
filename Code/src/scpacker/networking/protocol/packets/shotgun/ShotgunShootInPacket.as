package scpacker.networking.protocol.packets.shotgun
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShotgunShootInPacket extends AbstractPacket
   {
      public static const id:int = 471157826;
      
      public var shooter:String;
      
      public var shootDirection:Vector3d;
      
      public var targets:Vector.<TargetHit>;
      
      public function ShotgunShootInPacket(param1:String = "", param2:Vector3d = null, param3:Vector.<TargetHit> = null)
      {
         super();
         this.shooter = param1;
         this.shootDirection = param2;
         this.targets = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecTargetHit");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooter = param1 as String;
               break;
            case 1:
               this.shootDirection = param1 as Vector3d;
               break;
            case 2:
               this.targets = param1 as Vector.<TargetHit>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShotgunShootInPacket();
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

