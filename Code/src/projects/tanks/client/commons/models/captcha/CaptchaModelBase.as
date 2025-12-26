package projects.tanks.client.commons.models.captcha
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.EnumCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   import scpacker.networking.Network;
   
   public class CaptchaModelBase extends Model
   {
      protected var server:CaptchaModelServer = new CaptchaModelServer(this);
      
      private var client:ICaptchaModelBase = ICaptchaModelBase(this);
      
      static public var modelId:Long = Long.getLong(490831193,1530810385);
      
      public function CaptchaModelBase()
      {
         super();
      }

      protected function getInitParam() : CaptchaCC
      {
         return CaptchaCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

