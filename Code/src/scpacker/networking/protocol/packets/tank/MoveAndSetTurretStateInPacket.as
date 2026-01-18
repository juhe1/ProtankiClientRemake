package scpacker.networking.protocol.packets.tank
{
   import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class MoveAndSetTurretStateInPacket extends AbstractPacket
   {
      public static const id:int = 1516578027;

      public var tankId:String;
      
      public var movement:MoveCommand;
      
      public var turretDirection:Number;
      
      public function MoveAndSetTurretStateInPacket(param1:String = "", param2:MoveCommand = null, param3:Number = 0)
      {
         super();
         this.tankId = param1;
         this.movement = param2;
         this.turretDirection = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecMoveCommand");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tankId = param1 as String;
               break;
            case 1:
               this.movement = param1 as MoveCommand;
               break;
            case 2:
               this.turretDirection = param1 as Number;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new MoveAndSetTurretStateInPacket();
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

