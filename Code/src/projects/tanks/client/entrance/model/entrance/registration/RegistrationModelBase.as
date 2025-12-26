package projects.tanks.client.entrance.model.entrance.registration
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   
   public class RegistrationModelBase extends Model
   {
      protected var server:RegistrationModelServer = new RegistrationModelServer(this);
      
      private var client:IRegistrationModelBase = IRegistrationModelBase(this);
      
      static public var modelId:Long = Long.getLong(576129845,453074872);

      public function RegistrationModelBase()
      {
         super();
      }
      
      protected function getInitParam() : RegistrationModelCC
      {
         return RegistrationModelCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

