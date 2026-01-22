package scpacker.networking.protocol.packets.shotgun
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShotgunTryDummyShootOutPacket extends AbstractPacket
   {
      public static const id:int = 2128281231;
      
      public var time:int;
      
      public var shootDirection:Vector3d;
      
      public function ShotgunTryDummyShootOutPacket(param1:int = 0, param2:Vector3d = null)
      {
         super();
         this.time = param1;
         this.shootDirection = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
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
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShotgunTryDummyShootOutPacket();
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

