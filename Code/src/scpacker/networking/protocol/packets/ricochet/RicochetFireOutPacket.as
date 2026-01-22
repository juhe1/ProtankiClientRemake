package scpacker.networking.protocol.packets.ricochet
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RicochetFireOutPacket extends AbstractPacket
   {
      public static const id:int = -1907971330;
      
      public var time:int;
      
      public var shotId:int;
      
      public var shotDirectionX:int;
      
      public var shotDirectionY:int;
      
      public var shotDirectionZ:int;
      
      public function RicochetFireOutPacket(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0)
      {
         super();
         this.time = param1;
         this.shotId = param2;
         this.shotDirectionX = param3;
         this.shotDirectionY = param4;
         this.shotDirectionZ = param5;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         registerProperty(param5);
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
               this.shotId = param1 as int;
               break;
            case 2:
               this.shotDirectionX = param1 as int;
               break;
            case 3:
               this.shotDirectionY = param1 as int;
               break;
            case 4:
               this.shotDirectionZ = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RicochetFireOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 53;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

