package projects.tanks.client.panel.model.profile.usersettings
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.chat.models.chat.users.personalmessagereceiver.PersonalMessageReceiveMode;

   public class SettingsModelServer
   {

      private var model:IModel;

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
      }

      public function uploadClientSettings(param1:ClientStoredSettings) : void
      {
      }
   }
}
