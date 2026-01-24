package projects.tanks.client.panel.model.dailyquest.showing
{
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.missions.OpenQuestWindowOutPacket;

   public class QuestShowingModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function QuestShowingModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function openQuestWindow() : void
      {
         this.network.send(new OpenQuestWindowOutPacket());
      }
   }
}
