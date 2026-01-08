package projects.tanks.client.commons.models.captcha
{
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.captcha.RequestCaptchaOutPacket;
   import scpacker.networking.protocol.packets.captcha.AnswerCaptchaOutPacket;
   
   public class CaptchaModelServer
   {  
      private var model:IModel;

      private var network:Network = Network(OSGi.getInstance().getService(Network));
      
      public function CaptchaModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function checkCaptcha(param1:CaptchaLocation, param2:String) : void
      {
         network.send(new AnswerCaptchaOutPacket(param1, param2));
      }
      
      public function getNewCaptcha(param1:CaptchaLocation) : void
      {
         network.send(new RequestCaptchaOutPacket(param1));
      }
   }
}