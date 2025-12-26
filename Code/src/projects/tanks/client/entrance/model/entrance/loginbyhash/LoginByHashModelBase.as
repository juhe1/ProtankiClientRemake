package projects.tanks.client.entrance.model.entrance.loginbyhash
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class LoginByHashModelBase extends Model
   {
      protected var server:LoginByHashModelServer;
      
      private var client:ILoginByHashModelBase = ILoginByHashModelBase(this);
      
      static public var modelId:Long = Long.getLong(1662174151,-1895153624);
      
      public function LoginByHashModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new LoginByHashModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

