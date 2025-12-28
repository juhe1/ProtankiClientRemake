package scpacker.networking.protocol.packets.captcha
{
   import projects.tanks.client.commons.models.captcha.CaptchaLocation;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CaptchaFailedInPacket extends AbstractPacket
   {
      public static const id:int = -373510957;
      
      public var location:CaptchaLocation;
      
      public var imageData:Vector.<int>;
      
      public function CaptchaFailedInPacket(param1:CaptchaLocation = null, param2:Vector.<int> = null)
      {
         super();
         this.location = param1;
         this.imageData = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CaptchaLocationCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecByte");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.location = param1 as CaptchaLocation;
               break;
            case 1:
               this.imageData = param1 as Vector.<int>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CaptchaFailedInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 6;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

