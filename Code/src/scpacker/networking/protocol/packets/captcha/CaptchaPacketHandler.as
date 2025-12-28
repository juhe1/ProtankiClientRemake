package scpacker.networking.protocol.packets.captcha
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import projects.tanks.client.commons.models.captcha.CaptchaCC;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.clients.flash.commons.models.captcha.ServerCaptchaModel;
   import projects.tanks.client.commons.models.captcha.CaptchaModelBase;
   
   public class CaptchaPacketHandler extends AbstractPacketHandler
   {
      private var serverCaptchaModel:ServerCaptchaModel;
      
      public function CaptchaPacketHandler()
      {
         super();
         this.id = 6;
         this.serverCaptchaModel = ServerCaptchaModel(modelRegistry.getModel(CaptchaModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ReceiveCaptchaInPacket.id:
               this.receiveCaptcha(param1 as ReceiveCaptchaInPacket);
               break;
            case CaptchaFailedInPacket.id:
               this.captchaFailed(param1 as CaptchaFailedInPacket);
               break;
            case CaptchaCorrectInPacket.id:
               this.captchaCorrect(param1 as CaptchaCorrectInPacket);
               break;
            case SetCaptchaKeysInPacket.id:
               this.init(param1 as SetCaptchaKeysInPacket);
         }
      }
      
      private function init(param1:SetCaptchaKeysInPacket) : void
      {
         this.serverCaptchaModel.putInitParams(new CaptchaCC(param1.keys));
         this.serverCaptchaModel.objectLoaded();
      }
      
      private function receiveCaptcha(param1:ReceiveCaptchaInPacket) : void
      {
         this.serverCaptchaModel.showCaptcha(param1.location,param1.imageData);
      }
      
      private function captchaFailed(param1:CaptchaFailedInPacket) : void
      {
         this.serverCaptchaModel.captchaFailed(param1.location,param1.imageData);
      }
      
      private function captchaCorrect(param1:CaptchaCorrectInPacket) : void
      {
         this.serverCaptchaModel.captchaCorrect(param1.location);
      }
   }
}

