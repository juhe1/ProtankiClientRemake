package scpacker.networking.protocol.packets.machinegun
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class MachineGunUpdateDirectionOutPacket extends AbstractPacket
   {
      public static const id:int = 299028276;
      
      public var time:int;
      
      public var shootDirection:Vector3d;
      
      public function MachineGunUpdateDirectionOutPacket(param1:int = 0, param2:Vector3d = null)
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
         return new MachineGunUpdateDirectionOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 74;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

