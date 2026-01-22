package scpacker.networking.protocol.packets.ricochet
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class RicochetShootTargetInPacket extends AbstractPacket
   {
      public static const id:int = -118119523;
      
      public var shooter:String;
      
      public var shotDirectionX:int;
      
      public var shotDirectionY:int;
      
      public var shotDirectionZ:int;
      
      public function RicochetShootTargetInPacket(param1:String = "", param2:int = 0, param3:int = 0, param4:int = 0)
      {
         super();
         this.shooter = param1;
         this.shotDirectionX = param2;
         this.shotDirectionY = param3;
         this.shotDirectionZ = param4;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ShortCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooter = param1 as String;
               break;
            case 1:
               this.shotDirectionX = param1 as int;
               break;
            case 2:
               this.shotDirectionY = param1 as int;
               break;
            case 3:
               this.shotDirectionZ = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new RicochetShootTargetInPacket();
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

