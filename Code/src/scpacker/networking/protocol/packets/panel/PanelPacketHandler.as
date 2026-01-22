package scpacker.networking.protocol.packets.panel
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   //import alternativa.tanks.model.settings.SettingsModel;
   import alternativa.tanks.model.userproperties.UserPropertiesModel;
   import alternativa.types.Long;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.service.panel.IPanelView;
   import alternativa.tanks.model.panel.PanelModel;
   import scpacker.networking.protocol.AbstractPacket;
   //import alternativa.tanks.model.dailyquest.QuestShowingModel;
   import projects.tanks.client.panel.model.panel.PanelModelBase;
   import projects.tanks.client.panel.model.profile.userproperties.UserPropertiesModelBase;
   import alternativa.tanks.model.settings.SettingsModel;
   import projects.tanks.client.panel.model.profile.usersettings.SettingsModelBase;
   import platform.client.fp10.core.type.impl.Space;
   import projects.tanks.clients.flash.commons.models.captcha.ServerCaptchaModel;
   import projects.tanks.client.commons.models.captcha.CaptchaModelBase;
   import platform.client.fp10.core.type.IGameClass;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.model.impl.Model;
   import alternativa.tanks.model.useremailandpassword.UserEmailAndPasswordModel;
   import projects.tanks.client.panel.model.profile.useremailpassword.UserEmailAndPasswordModelBase;
   
   public class PanelPacketHandler extends AbstractPacketHandler
   {
      private var panelModel:PanelModel;
      private var userPropertiesModel:UserPropertiesModel;
      //private var questShowingModel:QuestShowingModel;
      private var settingsModel:SettingsModel;
      private var serverCaptcha:ServerCaptchaModel;
      
      private var panelView:IPanelView;
      private var panelSpace:Space;
      
      public function PanelPacketHandler()
      {
         super();
         this.id = 10;
         this.panelModel = PanelModel(modelRegistry.getModel(PanelModelBase.modelId));
         this.userPropertiesModel = UserPropertiesModel(modelRegistry.getModel(UserPropertiesModelBase.modelId));
         //this.questShowingModel = QuestShowingModel(modelRegistry.getModel(Long.getLong(1726782619,1524609945)));
         this.settingsModel = SettingsModel(modelRegistry.getModel(SettingsModelBase.modelId));
         this.serverCaptcha = ServerCaptchaModel(modelRegistry.getModel(CaptchaModelBase.modelId));

         this.panelView = IPanelView(OSGi.getInstance().getService(IPanelView));
         this.panelSpace = new Space(Long.getLong(10566210,44467896),null,null,false);
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case LoadAccountStatsInPacket.id:
               this.handleLoadAccountStats(param1 as LoadAccountStatsInPacket);
               break;
            case SetDoubleCrystalStateInPacket.id:
               this.handleSetDoubleCrystalState(param1 as SetDoubleCrystalStateInPacket);
         }
      }
      
      private function handleLoadAccountStats(param1:LoadAccountStatsInPacket) : void
      {
         this.userPropertiesModel.putInitParams(param1.userPropertyCC);
         this.userPropertiesModel.objectLoaded();
         this.userPropertiesModel.objectLoadedPost();
         this.panelModel.objectLoaded();
         this.panelModel.objectLoadedPost();
         //this.questShowingModel.objectLoadedPost();

         var modelVector:Vector.<Long> = new Vector.<Long>();
         modelVector.push(this.settingsModel.id);
         modelVector.push(this.serverCaptcha.id);
         modelVector.push(UserEmailAndPasswordModelBase.modelId);
         var settingGameClass:IGameClass = this.gameTypeRegistry.createClass(Long.getLong(12545678,87654321), modelVector);
         var settingsObject:IGameObject = this.panelSpace.createObject(Long.getLong(12545678,87654321), settingGameClass, "Setting game object");

         Model.object = settingsObject;
         this.settingsModel.objectLoadedPost();
         Model.popObject();

      }
      
      private function handleSetDoubleCrystalState(param1:SetDoubleCrystalStateInPacket) : void
      {
         //this.panelView.getPanel().newname_4517__END = param1.enabled;
      }
   }
}

