package scpacker.networking.protocol.packets.loginbyhash
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.servermodels.loginbyhash.LoginByHashModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.entrance.model.entrance.loginbyhash.LoginByHashModelBase;
   
   public class LoginByHashPacketHandler extends AbstractPacketHandler
   {
      private var loginByHashModel:LoginByHashModel;
      
      public function LoginByHashPacketHandler()
      {
         super();
         this.id = 1;
         this.loginByHashModel = LoginByHashModel(modelRegistry.getModel(LoginByHashModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case RememberUserHashInPakcet.id:
               this.rememberUsersHash(param1 as RememberUserHashInPakcet);
               break;
            case LoginByHashFailedInPacket.id:
               this.loginByHashFailed(param1 as LoginByHashFailedInPacket);
         }
      }
      
      private function rememberUsersHash(param1:RememberUserHashInPakcet) : void
      {
         this.loginByHashModel.rememberUsersHash(param1.userHash);
      }
      
      private function loginByHashFailed(param1:LoginByHashFailedInPacket) : void
      {
         this.loginByHashModel.loginByHashFailed();
      }
   }
}

