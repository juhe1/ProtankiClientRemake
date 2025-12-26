package projects.tanks.client.entrance.model.entrance.login
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class LoginModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _loginId:Long = Long.getLong(25286687,-1924305606);
      
      private var _login_uidOrEmailCodec:ICodec;
      
      private var _login_passwordCodec:ICodec;
      
      private var _login_rememberCodec:ICodec;
      
      private var model:IModel;
      
      public function LoginModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function login(param1:String, param2:String, param3:Boolean) : void
      {
      }
   }
}

