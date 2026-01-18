package scpacker.networking.protocol.packets.tank
{
   import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ClientMoveOutPacket extends AbstractPacket
   {
      public static const id:int = 329279865;

      public var time:int;
      
      public var specificationId:int;
      
      public var movement:MoveCommand;
      
      public function ClientMoveOutPacket(param1:int = 0, param2:int = 0, param3:MoveCommand = null)
      {
         super();
         this.time = param1;
         this.specificationId = param2;
         this.movement = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecMoveCommand");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.time = param1 as int;
               break;
            case 1:
               this.specificationId = param1 as int;
               break;
            case 2:
               this.movement = param1 as MoveCommand;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ClientMoveOutPacket();
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
