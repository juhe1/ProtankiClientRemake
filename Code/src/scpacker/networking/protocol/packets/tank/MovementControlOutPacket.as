package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class MovementControlOutPacket extends AbstractPacket
   {
      public static const id:int = -1749108178;

      public var time:int;
      public var specificationId:int;
      public var control:int;
      
      public function MovementControlOutPacket(param1:int = 0, param2:int = 0, param3:int = 0)
      {
         super();
         this.time = param1;
         this.specificationId = param2;
         this.control = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
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
               this.control = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new MovementControlOutPacket();
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
