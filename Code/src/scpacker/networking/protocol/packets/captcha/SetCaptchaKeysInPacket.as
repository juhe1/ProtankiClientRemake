package scpacker.networking.protocol.packets.captcha
{
   import projects.tanks.client.commons.models.captcha.CaptchaLocation;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetCaptchaKeysInPacket extends AbstractPacket
   {
      public static const id:int = 321971701;
      
      public var keys:Vector.<CaptchaLocation>;
      
      public function SetCaptchaKeysInPacket(param1:Vector.<CaptchaLocation> = null)
      {
         super();
         this.keys = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecCaptchaLocation");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.keys = param1 as Vector.<CaptchaLocation>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SetCaptchaKeysInPacket();
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

