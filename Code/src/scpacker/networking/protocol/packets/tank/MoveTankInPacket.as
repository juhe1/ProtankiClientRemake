package scpacker.networking.protocol.packets.tank
{
   import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class MoveTankInPacket extends AbstractPacket
   {
      public static const id:int = -64696933;

      public var tankId:String;
      
      public var movement:MoveCommand;
      
      public function MoveTankInPacket(param1:String = "", param2:MoveCommand = null)
      {
         super();
         this.tankId = param1;
         this.movement = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecMoveCommand");
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
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new MoveTankInPacket();
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

