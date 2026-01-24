package projects.tanks.client.chat.models.chat.chat
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.chat.SendMessageOutPacket;

   public class ChatModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function ChatModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function changeChannel(param1:String) : void
      {
      }

      public function sendMessage(param1:String, param2:ChatAddressMode, param3:String, param4:String) : void
      {
         this.network.send(new SendMessageOutPacket(param1,param4));
      }
   }
}
