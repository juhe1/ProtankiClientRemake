package projects.tanks.client.battleservice.model.latency
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class LatencyModelBase extends Model
   {
      protected var server:LatencyModelServer;
      
      private var client:ILatencyModelBase = ILatencyModelBase(this);
      
      static public var modelId:Long = Long.getLong(121770418,618912707);
      
      public function LatencyModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new LatencyModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

