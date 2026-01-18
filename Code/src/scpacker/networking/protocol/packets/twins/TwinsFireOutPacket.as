package scpacker.networking.protocol.packets.twins
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TwinsFireOutPacket extends AbstractPacket
   {
      public var Time:int;
      
      public var Barrel:int;
      
      public var ShotId:int;
      
      public var ShotDirection:Vector3d;
      
      public function TwinsFireOutPacket(param1:int = 0, param2:int = 0, param3:int = 0, param4:Vector3d = null)
      {
         super();
         this.Time = param1;
         this.Barrel = param2;
         this.ShotId = param3;
         this.ShotDirection = param4;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.Time = param1 as int;
               break;
            case 1:
               this.Barrel = param1 as int;
               break;
            case 2:
               this.ShotId = param1 as int;
               break;
            case 3:
               this.ShotDirection = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new TwinsFireOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 51;
      }
      
      override public function getId() : int
      {
         return -159686980;
      }
   }
}

