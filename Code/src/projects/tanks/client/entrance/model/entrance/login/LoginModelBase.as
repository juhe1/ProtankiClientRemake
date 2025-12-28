package projects.tanks.client.entrance.model.entrance.login
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class LoginModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:LoginModelServer;
      
      private var client:ILoginModelBase = ILoginModelBase(this);
      
      public static var modelId:Long = Long.getLong(1719449474,-786961358);
      
      public function LoginModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new LoginModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

