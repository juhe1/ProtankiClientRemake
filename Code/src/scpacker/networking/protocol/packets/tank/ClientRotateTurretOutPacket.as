package scpacker.networking.protocol.packets.tank
{
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ClientRotateTurretOutPacket extends AbstractPacket
   {
      public static const id:int = -114968993;

      public var time:int;
      
      public var turretRotation:RotateTurretCommand;
      
      public var incarnationId:int;
      
      public function ClientRotateTurretOutPacket(param1:int = 0, param2:RotateTurretCommand = null, param3:int = 0)
      {
         super();
         this.time = param1;
         this.turretRotation = param2;
         this.incarnationId = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecRotateTurretCommand");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.time = param1 as int;
               break;
            case 1:
               this.turretRotation = param1 as RotateTurretCommand;
               break;
            case 2:
               this.incarnationId = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ClientRotateTurretOutPacket();
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
