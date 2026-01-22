package scpacker.networking.protocol.packets.ricochet
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RicochetHitStaticOutPacket extends AbstractPacket
   {
      public static const id:int = -1823935471;
      
      public var time:int;
      
      public var shotId:int;
      
      public var impactPoints:Vector.<Vector3d>;
      
      public function RicochetHitStaticOutPacket(param1:int = 0, param2:int = 0, param3:Vector.<Vector3d> = null)
      {
         super();
         this.time = param1;
         this.shotId = param2;
         this.impactPoints = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param3);
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
               this.shotId = param1 as int;
               break;
            case 2:
               this.impactPoints = param1 as Vector.<Vector3d>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RicochetHitStaticOutPacket();
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

