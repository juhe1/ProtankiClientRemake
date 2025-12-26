package projects.tanks.client.entrance.model.entrance.externalentrance
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   
   public class ExternalEntranceModelBase extends Model
   {
      protected var server:ExternalEntranceModelServer;
      
      private var client:IExternalEntranceModelBase = IExternalEntranceModelBase(this);
      
      static public var modelId:Long = Long.getLong(108568170,1674173608);
      
      public function ExternalEntranceModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new ExternalEntranceModelServer(IModel(this));
      }
      
      protected function getInitParam() : ExternalEntranceCC
      {
         return ExternalEntranceCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

