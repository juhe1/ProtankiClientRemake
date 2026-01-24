package projects.tanks.client.panel.model.profile.usersettings
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.chat.models.chat.users.personalmessagereceiver.PersonalMessageReceiveMode;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.settings.LoadSettingsOutPacket;

   public class SettingsModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function SettingsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function setReceivePersonalMessages(param1:PersonalMessageReceiveMode) : void
      {
      }

      public function showSettings() : void
      {
         this.network.send(new LoadSettingsOutPacket());
      }

      public function uploadClientSettings(param1:ClientStoredSettings) : void
      {
      }
   }
}
