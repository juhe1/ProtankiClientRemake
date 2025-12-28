package scpacker.networking.protocol.packets.registration
{
   import scpacker.networking.protocol.AbstractPacket;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class InitializeRegistrationInPacket extends AbstractPacket
   {
      public static const id:int = -1277343167;
      
      public var bgResourceID:ImageResource;
      
      public var requireEmail:Boolean;
      
      public var maxPWLen:int;
      
      public var minPWLen:int;
      
      public function InitializeRegistrationInPacket(param1:ImageResource = null, param2:Boolean = false, param3:int = 0, param4:int = 0)
      {
         super();
         this.bgResourceID = param1;
         this.requireEmail = param2;
         this.maxPWLen = param3;
         this.minPWLen = param4;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.bgResourceID = param1 as ImageResource;
               break;
            case 1:
               this.requireEmail = param1 as Boolean;
               break;
            case 2:
               this.maxPWLen = param1 as int;
               break;
            case 3:
               this.minPWLen = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new InitializeRegistrationInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 8;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

