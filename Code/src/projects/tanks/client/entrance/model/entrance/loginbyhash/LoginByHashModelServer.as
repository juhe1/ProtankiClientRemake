package projects.tanks.client.entrance.model.entrance.loginbyhash
{
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.loginbyhash.LoginByHashOutPacket;
   
   public class LoginByHashModelServer
   {      
      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;
      
      public function LoginByHashModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function loginByHash(param1:String) : void
      {
         network.send(new LoginByHashOutPacket(param1));
      }
      
      public function loginBySingleUseHash(param1:String) : void
      {
      }
   }
}

