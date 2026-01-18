package scpacker.networking.protocol.packets.tank
{
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RotateTurretInPacket extends AbstractPacket
   {
      public static const id:int = 1927704181;

      public var tankId:String;
      
      public var turretRotation:RotateTurretCommand;
      
      public function RotateTurretInPacket(param1:String = "", param2:RotateTurretCommand = null)
      {
         super();
         this.tankId = param1;
         this.turretRotation = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecRotateTurretCommand");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tankId = param1 as String;
               break;
            case 1:
               this.turretRotation = param1 as RotateTurretCommand;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RotateTurretInPacket();
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

