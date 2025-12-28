package scpacker.networking.protocol.packets.captcha
{
   import projects.tanks.client.commons.models.captcha.CaptchaLocation;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class AnswerCaptchaOutPacket extends AbstractPacket
   {
      public static const id:int = 1271163230;
      
      public var location:CaptchaLocation;
      
      public var text:String;
      
      public function AnswerCaptchaOutPacket(param1:CaptchaLocation = null, param2:String = "")
      {
         super();
         this.location = param1;
         this.text = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CaptchaLocationCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.location = param1 as CaptchaLocation;
               break;
            case 1:
               this.text = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new AnswerCaptchaOutPacket();
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

