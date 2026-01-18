package scpacker.networking.protocol.packets.twins
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TwinsHitTargetOutPacket extends AbstractPacket
   {
      public var Time:int;
      
      public var ShotId:int;
      
      public var Target:String;
      
      public var TargetPosition:Vector3d;
      
      public var HitPointWorld:Vector3d;
      
      public function TwinsHitTargetOutPacket(param1:int = 0, param2:int = 0, param3:String = "", param4:Vector3d = null, param5:Vector3d = null)
      {
         super();
         this.Time = param1;
         this.ShotId = param2;
         this.Target = param3;
         this.TargetPosition = param4;
         this.HitPointWorld = param5;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param5);
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
               this.ShotId = param1 as int;
               break;
            case 2:
               this.Target = param1 as String;
               break;
            case 3:
               this.TargetPosition = param1 as Vector3d;
               break;
            case 4:
               this.HitPointWorld = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new TwinsHitTargetOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 51;
      }
      
      override public function getId() : int
      {
         return -1723353904;
      }
   }
}

