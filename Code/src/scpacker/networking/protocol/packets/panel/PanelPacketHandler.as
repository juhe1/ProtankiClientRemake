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
   
   public class PanelPacketHandler extends AbstractPacketHandler
   {
      private var panelModel:PanelModel;
      
      private var userPropertiesModel:UserPropertiesModel;
      
      //private var questShowingModel:QuestShowingModel;
      //private var settingsModel:SettingsModel;
      
      private var panelView:IPanelView;
      
      public function PanelPacketHandler()
      {
         super();
         this.id = 10;
         this.panelModel = PanelModel(modelRegistry.getModel(PanelModelBase.modelId));
         this.userPropertiesModel = UserPropertiesModel(modelRegistry.getModel(UserPropertiesModelBase.modelId));
         //this.questShowingModel = QuestShowingModel(modelRegistry.getModel(Long.getLong(1726782619,1524609945)));
         //this.settingsModel = SettingsModel(modelRegistry.getModel(Long.getLong(1428989873,1951780812)));
         this.panelView = IPanelView(OSGi.getInstance().getService(IPanelView));
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
         //this.settingsModel.objectLoadedPost();
      }
      
      private function handleSetDoubleCrystalState(param1:SetDoubleCrystalStateInPacket) : void
      {
         //this.panelView.getPanel().newname_4517__END = param1.enabled;
      }
   }
}

