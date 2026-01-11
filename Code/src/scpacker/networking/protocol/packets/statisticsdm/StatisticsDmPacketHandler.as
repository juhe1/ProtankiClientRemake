package scpacker.networking.protocol.packets.statisticsdm
{
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.tanks.models.statistics.dm.StatisticsDmModel;
   import projects.tanks.client.battleservice.model.statistics.dm.StatisticsDMModelBase;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.networking.protocol.packets.battle.BattlePacketHandler;
   
   public class StatisticsDmPacketHandler extends AbstractPacketHandler
   {
      private var statisticsDMModel:StatisticsDmModel;
      
      public function StatisticsDmPacketHandler()
      {
         super();
         this.id = 48;
         this.statisticsDMModel = StatisticsDmModel(modelRegistry.getModel(StatisticsDMModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ChangeUserStatInPacket.id:
               this.changeUserStat(param1 as ChangeUserStatInPacket);
               break;
            case InitDMStatisticsInPacket.id:
               this.initDmStatistics(param1 as InitDMStatisticsInPacket);
               break;
            case RefreshUsersStatInPacket.id:
               this.refreshUsersStat(param1 as RefreshUsersStatInPacket);
               break;
            case DmStatisticsUserConnectInPacket.id:
               this.userConnect(param1 as DmStatisticsUserConnectInPacket);
               break;
            case DmStatisticsUserDisconnectInPacket.id:
               this.userDisconnect(param1 as DmStatisticsUserDisconnectInPacket);
         }
      }
      
      private function changeUserStat(param1:ChangeUserStatInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsDMModel.changeUserStat(param1.userStats);
         Model.popObject();
      }
      
      private function initDmStatistics(param1:InitDMStatisticsInPacket) : void
      {
         //OSGi.getInstance().registerService(IClientUserInfo,this.statisticsDMModel);
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsDMModel.putInitParams(param1.statisticsDmCC);
         this.statisticsDMModel.objectLoaded();
         this.statisticsDMModel.objectLoadedPost();
         Model.popObject();
      }
      
      private function refreshUsersStat(param1:RefreshUsersStatInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsDMModel.refreshUsersStat(param1.userStats);
         Model.popObject();
      }
      
      private function userConnect(param1:DmStatisticsUserConnectInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsDMModel.userConnect(param1.userId,param1.userInfos);
         Model.popObject();
      }
      
      private function userDisconnect(param1:DmStatisticsUserDisconnectInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsDMModel.userDisconnect(param1.userId);
         Model.popObject();
      }
   }
}

