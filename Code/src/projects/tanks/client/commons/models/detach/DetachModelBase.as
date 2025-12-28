package projects.tanks.client.commons.models.detach
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class DetachModelBase extends Model
   {
      protected var server:DetachModelServer;
      
      private var client:IDetachModelBase = IDetachModelBase(this);
      
      static public var modelId:Long = Long.getLong(1666840941,1681304473);
      
      public function DetachModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new DetachModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

