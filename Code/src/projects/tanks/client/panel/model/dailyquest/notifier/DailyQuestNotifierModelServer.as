package projects.tanks.client.panel.model.dailyquest.notifier
{
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.missions.NotifyDailyQuestChangesViewedOutPacket;

   public class DailyQuestNotifierModelServer
   {
      private var model:IModel;
      private var network:Network = Network(OSGi.getInstance().getService(Network));

      public function DailyQuestNotifierModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function notifyDailyQuestChangesViewed() : void
      {
         network.send(new NotifyDailyQuestChangesViewedOutPacket());
      }
   }
}
