package projects.tanks.client.battlefield.models.battle.gui.chat
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.battlechat.SendBattleChatOutPacket;

   public class BattleChatModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function BattleChatModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function sendMessage(param1:String, param2:Boolean) : void
      {
         network.send(new SendBattleChatOutPacket(param1,param2));
      }
   }
}
