package scpacker.networking.protocol.packets.thunder
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ThunderShootStaticInPacket extends AbstractPacket
   {
      public static const id:int = 1690491826;
      
      public var shooter:String;
      
      public var hitPoint:Vector3d;
      
      public function ThunderShootStaticInPacket(param1:String = "", param2:Vector3d = null)
      {
         super();
         this.shooter = param1;
         this.hitPoint = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
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
               this.hitPoint = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ThunderShootStaticInPacket();
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

