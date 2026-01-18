package scpacker.networking.protocol.packets.isida
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class IsidaTickOutPacket extends AbstractPacket
   {
      public var ClientTime:int;
      
      public var Incarnation:int;
      
      public var TargetPosition:Vector3d;
      
      public var LocalHitPoint:Vector3d;
      
      public function IsidaTickOutPacket(param1:int = 0, param2:int = 0, param3:Vector3d = null, param4:Vector3d = null)
      {
         super();
         this.ClientTime = param1;
         this.Incarnation = param2;
         this.TargetPosition = param3;
         this.LocalHitPoint = param4;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.ClientTime = param1 as int;
               break;
            case 1:
               this.Incarnation = param1 as int;
               break;
            case 2:
               this.TargetPosition = param1 as Vector3d;
               break;
            case 3:
               this.LocalHitPoint = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new IsidaTickOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 55;
      }
      
      override public function getId() : int
      {
         return 244072998;
      }
   }
}

