package scpacker.networking.protocol.packets.statisticsteam
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.tanks.models.statistics.team.StatisticsTeamModel;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.models.statistics.IClientUserInfo;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.statistics.team.StatisticsTeamModelBase;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.networking.protocol.packets.battle.BattlePacketHandler;
   
   public class StatisticsTeamPacketHandler extends AbstractPacketHandler
   {
      private var statisticsTeamModel:StatisticsTeamModel;
      
      public function StatisticsTeamPacketHandler()
      {
         super();
         this.id = 44;
         this.statisticsTeamModel = StatisticsTeamModel(modelRegistry.getModel(StatisticsTeamModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case StatisticsTeamChangeTeamScoreInPacket.id:
               this.changeTeamScore(param1 as StatisticsTeamChangeTeamScoreInPacket);
               break;
            case StatisticsTeamChangeUserStatInPacket.id:
               this.changeUserStat(param1 as StatisticsTeamChangeUserStatInPacket);
               break;
            case InitStatisticsTeamModelInPacket.id:
               this.loadStatisticsTeamModel(param1 as InitStatisticsTeamModelInPacket);
               break;
            case StatisticsTeamSwapTeamInPacket.id:
               this.swapTeam(param1 as StatisticsTeamSwapTeamInPacket);
               break;
            case StatisticsTeamUserConnectInPacket.id:
               this.userConnect(param1 as StatisticsTeamUserConnectInPacket);
               break;
            case StatisticsTeamUserLeftInPacket.id:
               this.userDisconnect(param1 as StatisticsTeamUserLeftInPacket);
         }
      }
      
      private function loadStatisticsTeamModel(param1:InitStatisticsTeamModelInPacket) : void
      {
         //OSGi.getInstance().registerService(IClientUserInfo,this.statisticsTeamModel);
         BattlePacketHandler.battlefieldGameObject.gameClass.models.push(StatisticsTeamModelBase.modelId);
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsTeamModel.putInitParams(param1.statisticsTeamCC);
         this.statisticsTeamModel.objectLoaded();
         this.statisticsTeamModel.objectLoadedPost();
         Model.popObject()
      }
      
      private function changeUserStat(param1:StatisticsTeamChangeUserStatInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsTeamModel.changeUserStat(param1.userStats,param1.team);
         Model.popObject();
      }
      
      private function changeTeamScore(param1:StatisticsTeamChangeTeamScoreInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsTeamModel.changeTeamScore(param1.team,param1.score);
         Model.popObject();
      }
      
      private function swapTeam(param1:StatisticsTeamSwapTeamInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsTeamModel.swapTeam(param1.teamAUserStats,param1.teamBUserStats);
         Model.popObject();
      }
      
      private function userConnect(param1:StatisticsTeamUserConnectInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsTeamModel.userConnect(param1.userId,param1.userInfos,param1.team);
         Model.popObject();
      }
      
      private function userDisconnect(param1:StatisticsTeamUserLeftInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsTeamModel.userDisconnect(param1.userId);
         Model.popObject();
      }
   }
}

