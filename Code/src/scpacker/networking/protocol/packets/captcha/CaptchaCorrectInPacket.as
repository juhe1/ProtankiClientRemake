package scpacker.networking.protocol.packets.captcha
{
   import projects.tanks.client.commons.models.captcha.CaptchaLocation;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class CaptchaCorrectInPacket extends AbstractPacket
   {
      public static const id:int = -819536476;
      
      public var location:CaptchaLocation;
      
      public function CaptchaCorrectInPacket(param1:CaptchaLocation = null)
      {
         super();
         this.location = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CaptchaLocationCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.location = param1 as CaptchaLocation;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new CaptchaCorrectInPacket();
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

