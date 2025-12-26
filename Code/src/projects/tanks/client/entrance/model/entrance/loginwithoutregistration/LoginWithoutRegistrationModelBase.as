package projects.tanks.client.entrance.model.entrance.loginwithoutregistration
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class LoginWithoutRegistrationModelBase extends Model
   {
      protected var server:LoginWithoutRegistrationModelServer;
      
      private var client:ILoginWithoutRegistrationModelBase = ILoginWithoutRegistrationModelBase(this);
      
      static public var modelId:Long = Long.getLong(692477936,347605992);
      
      public function LoginWithoutRegistrationModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new LoginWithoutRegistrationModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

