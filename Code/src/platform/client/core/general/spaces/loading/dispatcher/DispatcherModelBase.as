package platform.client.core.general.spaces.loading.dispatcher
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsData;
   import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsDependencies;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class DispatcherModelBase extends Model
   {  
      protected var server:DispatcherModelServer = new DispatcherModelServer(IModel(this));
      
      private var client:IDispatcherModelBase = IDispatcherModelBase(this);
      
      private var modelId:Long = Long.getLong(191355032,163351191);
      
      
      public function DispatcherModelBase()
      {
         super();
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

