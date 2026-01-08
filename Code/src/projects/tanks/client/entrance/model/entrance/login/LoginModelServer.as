
package projects.tanks.client.entrance.model.entrance.login
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.login.LoginOutPacket;
   
   public class LoginModelServer
   {
      private var model:IModel;

      private var network:Network = Network(OSGi.getInstance().getService(Network));
      
      public function LoginModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function login(param1:String, param2:String, param3:Boolean) : void
      {
         network.send(new LoginOutPacket(param1,param2,param3));
      }
   }
}