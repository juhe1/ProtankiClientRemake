package scpacker.networking.protocol.packets.missions
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.service.dailyquest.DailyQuestNotifierModel;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.model.dailyquest.QuestShowingModel;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.networking.protocol.packets.panel.PanelPacketHandler;
   import projects.tanks.client.panel.model.dailyquest.showing.QuestShowingModelBase;
   import projects.tanks.client.panel.model.dailyquest.notifier.DailyQuestNotifierModelBase;
   
   public class MissionPacketHandler extends AbstractPacketHandler
   {
      private var questShowingModel:QuestShowingModel;
      
      private var dailyQuestNotifierModel:DailyQuestNotifierModel;
      
      public function MissionPacketHandler()
      {
         super();
         this.id = 19;
         this.questShowingModel = QuestShowingModel(modelRegistry.getModel(QuestShowingModelBase.modelId));
         this.dailyQuestNotifierModel = DailyQuestNotifierModel(modelRegistry.getModel(DailyQuestNotifierModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ShowQuestWindowInPacket.id:
               this.showQuestWindow(param1 as ShowQuestWindowInPacket);
               break;
            case ShowQuestWindowWithoutDailyQuestsInPacket.id:
               this.showQuestWindowWithoutDailyQuests(param1 as ShowQuestWindowWithoutDailyQuestsInPacket);
               break;
            case SkipDailyQuestInPacket.id:
               this.skipDailyQuest(param1 as SkipDailyQuestInPacket);
               break;
            case TakeDailyQuestPrizeInPacket.id:
               this.takeDailyQuestPrize(param1 as TakeDailyQuestPrizeInPacket);
               break;
            case NotifyDailyQuestCompletedInPacket.id:
               this.notifyDailyQuestCompleted();
               break;
            case NotifyDailyQuestGeneratedInPacket.id:
               this.notifyDailyQuestGenerated();
         }
      }
      
      private function showQuestWindow(param1:ShowQuestWindowInPacket) : void
      {
         Model.object = PanelPacketHandler.dailyQuestGameObject;
         this.questShowingModel.showQuestWindow(param1.missions,param1.weeklyStreakInfo);
         Model.popObject();
      }
      
      private function skipDailyQuest(param1:SkipDailyQuestInPacket) : void
      {
         Model.object = PanelPacketHandler.dailyQuestGameObject;
         this.questShowingModel.skipDailyQuest(Long.getLong(0,param1.missionId),param1.mission);
         Model.popObject();
      }
      
      private function showQuestWindowWithoutDailyQuests(param1:ShowQuestWindowWithoutDailyQuestsInPacket) : void
      {
         Model.object = PanelPacketHandler.dailyQuestGameObject;
         this.questShowingModel.showQuestWindowWithoutDailyQuests(param1.weeklyStreakInfo);
         Model.popObject();
      }
      
      private function takeDailyQuestPrize(param1:TakeDailyQuestPrizeInPacket) : void
      {
         Model.object = PanelPacketHandler.dailyQuestGameObject;
         this.questShowingModel.takeDailyQuestPrize(Long.getLong(0,param1.missionId));
         Model.popObject();
      }
      
      private function notifyDailyQuestCompleted() : void
      {
         Model.object = PanelPacketHandler.dailyQuestGameObject;
         this.dailyQuestNotifierModel.notifyDailyQuestCompleted();
         Model.popObject();
      }
      
      private function notifyDailyQuestGenerated() : void
      {
         Model.object = PanelPacketHandler.dailyQuestGameObject;
         this.dailyQuestNotifierModel.notifyDailyQuestGenerated();
         Model.popObject();
      }
   }
}

