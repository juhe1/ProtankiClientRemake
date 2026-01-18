package scpacker.networking.protocol.packets.battlestatistics
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.tanks.models.battle.battlefield.BattlefieldModel;
   import alternativa.tanks.models.statistics.StatisticsModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.statistics.StatisticsModelBase;
   import projects.tanks.client.battlefield.models.battle.battlefield.BattlefieldModelBase;
   import scpacker.networking.protocol.packets.battle.BattlePacketHandler;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.battleservice.model.statistics.dm.StatisticsDMModelBase;
   
   public class BattleStatisticsPacketHandler extends AbstractPacketHandler
   {
      private var statisticsModel:StatisticsModel;
      private var battlefieldModel:BattlefieldModel;
      
      public function BattleStatisticsPacketHandler()
      {
         super();
         this.id = 37;
         this.statisticsModel = StatisticsModel(modelRegistry.getModel(StatisticsModelBase.modelId));
         this.battlefieldModel = BattlefieldModel(modelRegistry.getModel(BattlefieldModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case BattleFundInPacket.id:
               this.fundChange(param1 as BattleFundInPacket);
               break;
            case InitStatisticsInPacket.id:
               this.initStatisticsModel(param1 as InitStatisticsInPacket);
               break;
            case StatisticsModelLoadedPostInPacket.id:
               this.statisticsModelLoadedPost();
               break;
            case ComplaintConfirmedInPacket.id:
               this.complaintConfirmed();
               break;
            case RankUpInPacket.id:
               this.rankChanged(param1 as RankUpInPacket);
               break;
            case RoundFinishInPacket.id:
               this.roundFinish(param1 as RoundFinishInPacket);
               break;
            case RoundStartInPacket.id:
               this.roundStart(param1 as RoundStartInPacket);
               break;
            case StatusProbablyCheaterChangedInPacket.id:
               this.statusProbablyCheaterChanged(param1 as StatusProbablyCheaterChangedInPacket);
         }
      }
      
      private function initStatisticsModel(param1:InitStatisticsInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         param1.statisticsModelCC.valuableRound = true;
         param1.statisticsModelCC.matchBattle = false;
         this.statisticsModel.putInitParams(param1.statisticsModelCC);
         this.statisticsModel.objectLoaded();
         Model.popObject();
      }
      
      private function statisticsModelLoadedPost() : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsModel.objectLoadedPost();
         Model.popObject();
      }
      
      private function fundChange(param1:BattleFundInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsModel.fundChange(param1.fund);
         Model.popObject();
      }
      
      private function complaintConfirmed() : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsModel.onComplaintConfirmed();
         Model.popObject();
      }
      
      private function rankChanged(param1:RankUpInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsModel.onRankChanged(param1.userId,param1.rank, false);
         Model.popObject();
      }
      
      private function roundFinish(param1:RoundFinishInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsModel.roundFinish(true,param1.reward,param1.timeToRestart);
         this.battlefieldModel.battleFinish();
         Model.popObject();
      }
      
      private function roundStart(param1:RoundStartInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsModel.roundStart(param1.timeLimitInSec,true);
         this.battlefieldModel.battleRestart();
         Model.popObject();
      }
      
      private function statusProbablyCheaterChanged(param1:StatusProbablyCheaterChangedInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.statisticsModel.statusProbablyCheaterChanged(param1.userId,param1.suspicious);
         Model.popObject();
      }
   }
}

