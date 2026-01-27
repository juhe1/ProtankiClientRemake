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
   import projects.tanks.client.panel.model.profile.useremailpassword.UserEmailCC;
   import projects.tanks.client.panel.model.dailyquest.DailyQuestModelBase;
   import projects.tanks.client.panel.model.quest.daily.DailyQuestShowingModelBase;
   import projects.tanks.client.panel.model.dailyquest.quest.bonus.BonusCatchDailyQuestModelBase;
   import projects.tanks.client.panel.model.quest.daily.type.goal.CaptureGoalDailyQuestModelBase;
   import projects.tanks.client.panel.model.dailyquest.quest.map.ScoreCollectOnMapDailyQuestModelBase;
   import projects.tanks.client.panel.model.dailyquest.quest.mode.DailyQuestWithModeModelBase;
   import projects.tanks.client.panel.model.dailyquest.showing.QuestShowingModelBase;
   import alternativa.tanks.model.dailyquest.QuestShowingModel;
   import alternativa.tanks.models.performance.PerformanceModel;
   import projects.tanks.client.battleservice.model.performance.PerformanceModelBase;
   import projects.tanks.client.battleservice.model.performance.PerformanceCC;
   
   public class PanelPacketHandler extends AbstractPacketHandler
   {
      private var panelModel:PanelModel;
      private var userPropertiesModel:UserPropertiesModel;
      //private var questShowingModel:QuestShowingModel;
      private var settingsModel:SettingsModel;
      private var serverCaptcha:ServerCaptchaModel;
      private var userEmailAndPasswordModel:UserEmailAndPasswordModel;
      private var performanceModel:PerformanceModel;
      
      private var panelView:IPanelView;
      public static var panelSpace:Space;
      public static var settingsGameObject:IGameObject;
      public static var dailyQuestGameObject:IGameObject;
      
      public function PanelPacketHandler()
      {
         super();
         this.id = 10;
         this.panelModel = PanelModel(modelRegistry.getModel(PanelModelBase.modelId));
         this.userPropertiesModel = UserPropertiesModel(modelRegistry.getModel(UserPropertiesModelBase.modelId));
         //this.questShowingModel = QuestShowingModel(modelRegistry.getModel(Long.getLong(1726782619,1524609945)));
         this.settingsModel = SettingsModel(modelRegistry.getModel(SettingsModelBase.modelId));
         this.serverCaptcha = ServerCaptchaModel(modelRegistry.getModel(CaptchaModelBase.modelId));
         this.userEmailAndPasswordModel = UserEmailAndPasswordModel(modelRegistry.getModel(UserEmailAndPasswordModelBase.modelId));
         this.performanceModel = PerformanceModel(modelRegistry.getModel(PerformanceModelBase.modelId));

         this.panelView = IPanelView(OSGi.getInstance().getService(IPanelView));
         panelSpace = new Space(Long.getLong(10566210,44467896),null,null,false);
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

         // performance
         var performanceCC:PerformanceCC = new PerformanceCC();
         performanceCC.alertFPSRatioThreshold = 0.9;
         performanceCC.alertFPSThreshold = 10000;
         performanceCC.alertMinTestTime = 10000;
         performanceCC.alertPingRatioThreshold = 0.9;
         performanceCC.alertPingThreshold = 900;

         performanceCC.indicatorHighFPS = 50;
         performanceCC.indicatorHighFPSColor = "0x00ff00";
         performanceCC.indicatorHighPing = 200;
         performanceCC.indicatorHighPingColor = "0xaaaa00";
         performanceCC.indicatorLowFPS = 30;
         performanceCC.indicatorLowFPSColor = "0xaaaa00";
         performanceCC.indicatorLowPing = 50;
         performanceCC.indicatorLowPingColor = "0x00ff00";
         performanceCC.indicatorVeryHighPing = 900;
         performanceCC.indicatorVeryHighPingColor = "0xff0000";
         performanceCC.indicatorVeryLowFPS = 10;
         performanceCC.indicatorVeryLowFPSColor = "0xff0000";

         performanceCC.qualityFPSThreshold = 40;
         performanceCC.qualityIdleTime = 1000;
         performanceCC.qualityMaxAttempts = 10;
         performanceCC.qualityRatioThreshold = 0.5;
         performanceCC.qualityTestTime = 1000;
         performanceCC.qualityVisualizationSpeed = 1000;
         
         this.performanceModel.putInitParams(performanceCC);
         this.performanceModel.objectLoaded();

         // settings
         var modelVector:Vector.<Long> = new Vector.<Long>();
         modelVector.push(this.settingsModel.id);
         modelVector.push(this.serverCaptcha.id);
         modelVector.push(this.userEmailAndPasswordModel.id);
         var settingGameClass:IGameClass = this.gameTypeRegistry.createClass(Long.getLong(12545678,87654321), modelVector);
         settingsGameObject = panelSpace.createObject(Long.getLong(12545678,87654321), settingGameClass, "Setting game object");

         Model.object = settingsGameObject;

         this.settingsModel.objectLoadedPost();

         this.userEmailAndPasswordModel.putInitParams(new UserEmailCC("notImplemented@bullshitmail.com", false));
         this.userEmailAndPasswordModel.objectLoaded();

         Model.popObject();

         // daily quest
         var modelVector:Vector.<Long> = new Vector.<Long>();
         modelVector.push(DailyQuestModelBase.modelId);
         modelVector.push(QuestShowingModelBase.modelId);
         modelVector.push(BonusCatchDailyQuestModelBase.modelId);
         modelVector.push(CaptureGoalDailyQuestModelBase.modelId);
         modelVector.push(ScoreCollectOnMapDailyQuestModelBase.modelId);
         modelVector.push(DailyQuestWithModeModelBase.modelId);
         var dailyQuestGameClass:IGameClass = this.gameTypeRegistry.createClass(Long.getLong(12545678,87654321), modelVector);
         dailyQuestGameObject = panelSpace.createObject(Long.getLong(12546678,87655471), dailyQuestGameClass, "Daily quest game object");
         var questShowingModel:QuestShowingModel = QuestShowingModel(modelRegistry.getModel(QuestShowingModelBase.modelId));

         Model.object = dailyQuestGameObject;
         questShowingModel.objectLoadedPost();
         Model.popObject();
      }
      
      private function handleSetDoubleCrystalState(param1:SetDoubleCrystalStateInPacket) : void
      {
         //this.panelView.getPanel().newname_4517__END = param1.enabled;
      }
   }
}

