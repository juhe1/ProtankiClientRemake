package scpacker.networking.protocol.packets.twins
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class TwinsFireDummyIn extends AbstractPacket
   {
      public static const id:int = -328554480;
      
      public var shooter:String;
      
      public var barrel:int;
      
      public function TwinsFireDummyIn(param1:String = "", param2:int = 0)
      {
         super();
         this.shooter = param1;
         this.barrel = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooter = param1 as String;
               break;
            case 1:
               this.barrel = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new TwinsFireDummyIn();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 51;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

