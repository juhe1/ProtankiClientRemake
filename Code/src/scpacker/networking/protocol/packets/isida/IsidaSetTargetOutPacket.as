package scpacker.networking.protocol.packets.isida
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class IsidaSetTargetOutPacket extends AbstractPacket
   {
      public var ClientTime:int;
      
      public var Target:String;
      
      public var Incarnation:int;
      
      public var LocalHitPoint:Vector3d;
      
      public function IsidaSetTargetOutPacket(param1:int = 0, param2:String = "", param3:int = 0, param4:Vector3d = null)
      {
         super();
         this.ClientTime = param1;
         this.Target = param2;
         this.Incarnation = param3;
         this.LocalHitPoint = param4;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
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
               this.Target = param1 as String;
               break;
            case 2:
               this.Incarnation = param1 as int;
               break;
            case 3:
               this.LocalHitPoint = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new IsidaSetTargetOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 55;
      }
      
      override public function getId() : int
      {
         return 381067984;
      }
   }
}

