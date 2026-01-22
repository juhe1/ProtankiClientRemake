package scpacker.networking.protocol.packets.thunder
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ThunderShootTargetInPacket extends AbstractPacket
   {
      public static const id:int = -190359403;
      
      public var shooter:String;
      
      public var target:String;
      
      public var relativeHitPoint:Vector3d;
      
      public function ThunderShootTargetInPacket(param1:String = "", param2:String = "", param3:Vector3d = null)
      {
         super();
         this.shooter = param1;
         this.target = param2;
         this.relativeHitPoint = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
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
               this.target = param1 as String;
               break;
            case 2:
               this.relativeHitPoint = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ThunderShootTargetInPacket();
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

