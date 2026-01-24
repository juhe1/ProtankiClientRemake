package scpacker.networking.protocol.packets.settings
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.battleinvite.NotificationEnabledModel;
   import alternativa.tanks.model.settings.SettingsModel;
   import projects.tanks.client.chat.models.chat.users.personalmessagereceiver.PersonalMessageReceiveMode;
   import alternativa.types.Long;
   import projects.tanks.client.users.model.switchbattleinvite.NotificationEnabledCC;
   import alternativa.tanks.model.useremailandpassword.UserEmailAndPasswordModel;
   import scpacker.networking.protocol.AbstractPacket;
   import scpacker.networking.protocol.packets.panel.PanelPacketHandler;
   import platform.client.fp10.core.model.impl.Model;
   
   public class SettingsPacketHandler extends AbstractPacketHandler
   {
      private var settingsModel:SettingsModel;
      
      private var notificationEnabledModel:NotificationEnabledModel;
      
      private var userEmailAndPasswordModel:UserEmailAndPasswordModel;
      
      public function SettingsPacketHandler()
      {
         super();
         this.id = 23;
         this.settingsModel = SettingsModel(modelRegistry.getModel(Long.getLong(1428989873,1951780812)));
         this.notificationEnabledModel = NotificationEnabledModel(modelRegistry.getModel(Long.getLong(1190039526,-1224288945)));
         this.userEmailAndPasswordModel = UserEmailAndPasswordModel(modelRegistry.getModel(Long.getLong(740369199,944909632)));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case OpenSettingsInPacket.id:
               this.openSettings(param1 as OpenSettingsInPacket);
               break;
            case CloseSettingsInPacket.id:
               this.closeSettings(param1 as CloseSettingsInPacket);
         }
      }
      
      private function openSettings(param1:OpenSettingsInPacket) : void
      {
         //this.notificationEnabledModel.putInitParams(new NotificationEnabledCC(param1.NotificationEnabled));
         //this.notificationEnabledModel.objectLoaded();
         Model.object = PanelPacketHandler.settingsGameObject;
         this.settingsModel.openSettings(PersonalMessageReceiveMode.ALL);
         Model.popObject();
      }
      
      private function closeSettings(param1:CloseSettingsInPacket) : void
      {
         //Model.object = PanelPacketHandler.settingsGameObject;
         //this.newname_7849__END.onSettingsClose();
         //Model.popObject();
      }
   }
}

