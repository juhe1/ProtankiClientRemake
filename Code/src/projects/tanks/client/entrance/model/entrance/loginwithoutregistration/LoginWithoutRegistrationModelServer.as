package projects.tanks.client.entrance.model.entrance.loginwithoutregistration
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class LoginWithoutRegistrationModelServer
   {
      private var model:IModel;
      
      public function LoginWithoutRegistrationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function loginWithoutRegistration() : void
      {
         
      }
   }
}

