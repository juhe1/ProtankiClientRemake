package scpacker.networking.protocol.packets.tank
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class PrepareToSpawnInPacket extends AbstractPacket
   {
      public static const id:int = -157204477;

      public var position:Vector3d;
      
      public var orientation:Vector3d;
      
      public function PrepareToSpawnInPacket(param1:Vector3d = null, param2:Vector3d = null)
      {
         super();
         this.position = param1;
         this.orientation = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.position = param1 as Vector3d;
               break;
            case 1:
               this.orientation = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new PrepareToSpawnInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 39;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

