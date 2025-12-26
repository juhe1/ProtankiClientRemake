package platform.client.core.general.socialnetwork.models.socialnetworkparameters
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   
   public class SocialNetworkParametersModelBase extends Model
   {
      private var client:ISocialNetworkParametersModelBase = ISocialNetworkParametersModelBase(this);
      
      static public var modelId:Long = Long.getLong(1480731399,760833293);
      
      public function SocialNetworkParametersModelBase()
      {
         super();
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

