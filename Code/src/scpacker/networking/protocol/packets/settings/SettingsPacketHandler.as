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
   
   public class SettingsPacketHandler extends AbstractPacketHandler
   {
      private var newname_7849__END:SettingsModel;
      
      private var newname_10351__END:NotificationEnabledModel;
      
      private var newname_10352__END:UserEmailAndPasswordModel;
      
      public function SettingsPacketHandler()
      {
         super();
         this.id = 23;
         this.newname_7849__END = SettingsModel(modelRegistry.getModel(Long.getLong(1428989873,1951780812)));
         this.newname_10351__END = NotificationEnabledModel(modelRegistry.getModel(Long.getLong(1190039526,-1224288945)));
         this.newname_10352__END = UserEmailAndPasswordModel(modelRegistry.getModel(Long.getLong(740369199,944909632)));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case 1447082276:
               this.openSettings(param1 as SettingsNotification);
               break;
            case -1302674105:
               this.newname_10354__END(param1 as newname_3872__END);
         }
      }
      
      private function openSettings(param1:SettingsNotification) : void
      {
         this.newname_10351__END.putInitParams(new NotificationEnabledCC(param1.NotificationEnabled));
         this.newname_10351__END.objectLoaded();
         this.newname_7849__END.openSettings(PersonalMessageReceiveMode.newname_7952__END);
      }
      
      private function newname_10354__END(param1:newname_3872__END) : void
      {
         this.newname_7849__END.onSettingsClose();
      }
   }
}

