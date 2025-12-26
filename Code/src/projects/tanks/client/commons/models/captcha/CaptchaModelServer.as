package projects.tanks.client.commons.models.captcha
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.EnumCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class CaptchaModelServer
   {  
      private var model:IModel;
      
      public function CaptchaModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function checkCaptcha(param1:CaptchaLocation, param2:String) : void
      {
      }
      
      public function getNewCaptcha(param1:CaptchaLocation) : void
      {
      }
   }
}

