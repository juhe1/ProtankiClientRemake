package scpacker.networking.protocol.packets.twins
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TwinsShootTargetIn extends AbstractPacket
   {
      public static const id:int = -44282936;
      
      public var shooter:String;
      
      public var barrel:int;
      
      public var shotDirection:Vector3d;
      
      public function TwinsShootTargetIn(param1:String = "", param2:int = 0, param3:Vector3d = null)
      {
         super();
         this.shooter = param1;
         this.barrel = param2;
         this.shotDirection = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooter = param1 as String;
               break;
            case 1:
               this.barrel = param1 as int;
               break;
            case 2:
               this.shotDirection = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new TwinsShootTargetIn();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 51;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

