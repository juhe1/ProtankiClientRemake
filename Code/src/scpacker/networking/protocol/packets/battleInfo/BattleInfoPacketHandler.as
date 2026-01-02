package scpacker.networking.protocol.packets.battleInfo
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import projects.tanks.client.battleselect.model.battle.team.TeamBattleInfoCC;
   import alternativa.types.Long;
   import alternativa.tanks.model.info.BattleInfoModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.createparams.BattleLimits;
   import platform.client.fp10.core.model.impl.*;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.IGameClass;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   import projects.tanks.client.battleselect.model.battle.dm.BattleDMInfoCC;
   import platform.client.fp10.core.type.ISpace;
   import scpacker.SpaceAndGameObjectIds;
   import projects.tanks.client.battleselect.model.battle.BattleInfoModelBase;
   import alternativa.tanks.model.info.dm.BattleDmInfoModel;
   import alternativa.tanks.model.info.team.BattleTeamInfoModel;
   import projects.tanks.client.battleselect.model.battle.dm.BattleDMInfoModelBase;
   import alternativa.tanks.model.info.team.BattleTeamInfo;
   import projects.tanks.client.battleselect.model.battle.team.TeamBattleInfoModelBase;
   import projects.tanks.client.battleservice.model.statistics.StatisticsModelCC;
   import alternativa.tanks.model.info.param.BattleParamInfoModel;
   import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoModelBase;
   import alternativa.tanks.model.battle.BattleEntrance;
   import alternativa.tanks.model.battle.BattleEntranceModel;
   import projects.tanks.client.battleselect.model.battle.entrance.BattleEntranceModelBase;
   import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;
   import projects.tanks.client.battleservice.BattleCreateParameters;
   import scpacker.utils.EnumUtils;
   import projects.tanks.client.battleservice.Range;
   import projects.tanks.client.battleselect.model.battle.BattleInfoCC;
   import alternativa.tanks.model.info.ShowInfo;
   import scpacker.utils.IdTool;
   import scpacker.networking.protocol.packets.battlelist.BattleListPacketHandler;
   import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
   
   public class BattleInfoPacketHandler extends AbstractPacketHandler
   {
      private var battleInfoModel:BattleInfoModel;
      private var battleDmInfoModel:BattleDmInfoModel;
      private var teamBattleInfoModel:BattleTeamInfoModel;
      private var battleEntranceModel:BattleEntranceModel;
      private var battleParamInfoModel:BattleParamInfoModel;
      
      private var battleSelectSpace:ISpace;
      private var selectedBattleId:String = "";
      
      public function BattleInfoPacketHandler()
      {
         super();
         this.id = 33;
         this.battleInfoModel = BattleInfoModel(modelRegistry.getModel(BattleInfoModelBase.modelId));
         this.battleDmInfoModel = BattleDmInfoModel(modelRegistry.getModel(BattleDMInfoModelBase.modelId));
         this.teamBattleInfoModel = BattleTeamInfoModel(modelRegistry.getModel(TeamBattleInfoModelBase.modelId));
         this.battleEntranceModel = BattleEntranceModel(modelRegistry.getModel(BattleEntranceModelBase.modelId));
         this.battleParamInfoModel = BattleParamInfoModel(modelRegistry.getModel(BattleParamInfoModelBase.modelId));
         this.battleSelectSpace = ISpace(spaceRegistry.getSpace(SpaceAndGameObjectIds.BATTLE_SELECT_SPACE_ID));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case JoinedDmBattleInPacket.id:
               this.addUserDm(param1 as JoinedDmBattleInPacket);
               break;
            case JoinedTeamBattleInPacket.id:
               this.addUserTeam(param1 as JoinedTeamBattleInPacket);
               break;
            case BattleStoppedInPacket.id:
               this.battleStop(param1 as BattleStoppedInPacket);
               break;
            case EquipmentNotMatchConstraintsInPacket.id:
               this.equipmentNotMatchConstraintsDm(param1 as EquipmentNotMatchConstraintsInPacket);
               break;
            case EquipmentNotMatchTeamConstraintsInPacket.id:
               this.equipmentNotMatchConstraintsTeam(param1 as EquipmentNotMatchTeamConstraintsInPacket);
               break;
            case FightFailedServerHaltingInPacket.id:
               this.fightFailedServerIsHalting(param1 as FightFailedServerHaltingInPacket);
               break;
            case UnloadBattleInfoInPacket.id:
               this.unload(param1 as UnloadBattleInfoInPacket);
               break;
            case LeftPacketInPacket.id:
               this.removeUser(param1 as LeftPacketInPacket);
               break;
            case RoundFinishedInPacket.id:
               this.roundFinish(param1 as RoundFinishedInPacket);
               break;
            case RoundStartedInPacket.id:
               this.roundStart(param1 as RoundStartedInPacket);
               break;
            case LoadBattleInfoInPacket.id:
               this.loadBattleInfo(param1 as LoadBattleInfoInPacket);
               break;
            case SwapTeamsInPacket.id:
               this.swapTeams(param1 as SwapTeamsInPacket);
               break;
            case UpdateBattleNameInPacket.id:
               this.updateName(param1 as UpdateBattleNameInPacket);
               break;
            case UpdateTeamScoreInPacket.id:
               this.updateTeamScore(param1 as UpdateTeamScoreInPacket);
               break;
            case UpdatePlayerDmKillsInPacket.id:
               this.updateUserKills(param1 as UpdatePlayerDmKillsInPacket);
               break;
            case UpdatePlayerTeamScoreInPacket.id:
               this.updateUserScore(param1 as UpdatePlayerTeamScoreInPacket);
               break;
            case UpdatePlayerSuspiciousStateInPacket.id:
               this.updateUserSuspiciousState(param1 as UpdatePlayerSuspiciousStateInPacket);
         }
      }
      
      private function battleStop(param1:BattleStoppedInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.battleInfoModel.roundFinished();
         Model.popObject();
      }
      
      private function fightFailedServerIsHalting(param1:FightFailedServerHaltingInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         //this.battleInfoModel.fightFailedServerIsHalting();
         Model.popObject();
      }
      
      private function removeUser(param1:LeftPacketInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         if(_loc2_.hasModel(BattleDmInfoModel))
         {
            this.battleDmInfoModel.removeUser(param1.userId);
         } else
         {
            this.teamBattleInfoModel.removeUser(param1.userId);
         }
         Model.popObject();
      }
      
      private function roundFinish(param1:RoundFinishedInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.battleInfoModel.roundFinished();
         Model.popObject();
      }
      
      private function roundStart(param1:RoundStartedInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.battleInfoModel.roundStarted(5); // 5 is placeholder time
         Model.popObject();
      }
      
      private function updateName(param1:UpdateBattleNameInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.battleInfoModel.setBattleName(param1.battleName);
         Model.popObject();
      }
      
      private function updateUserSuspiciousState(param1:UpdatePlayerSuspiciousStateInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.battleInfoModel.updateUserSuspiciousState(param1.userId,param1.suspicious);
         Model.popObject();
      }
      
      private function updateUserKills(param1:UpdatePlayerDmKillsInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.battleDmInfoModel.updateUserScore(param1.userId,param1.kills);
         Model.popObject();
      }
      
      private function updateUserScore(param1:UpdatePlayerTeamScoreInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.teamBattleInfoModel.updateUserScore(param1.userId,param1.score);
         Model.popObject();
      }
      
      private function updateTeamScore(param1:UpdateTeamScoreInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.teamBattleInfoModel.updateTeamScore(param1.team,param1.score);
         Model.popObject();
      }
      
      private function addUserDm(param1:JoinedDmBattleInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.battleDmInfoModel.addUser(param1.userInfo);
         Model.popObject();
      }
      
      private function addUserTeam(param1:JoinedTeamBattleInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.teamBattleInfoModel.addUser(param1.userInfo,param1.team);
         Model.popObject();
      }
      
      private function swapTeams(param1:SwapTeamsInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.teamBattleInfoModel.swapTeams();
         Model.popObject();
      }
      
      private function equipmentNotMatchConstraintsDm(param1:EquipmentNotMatchConstraintsInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.battleEntranceModel.equipmentNotMatchConstraints();
         Model.popObject();
      }
      
      private function equipmentNotMatchConstraintsTeam(param1:EquipmentNotMatchTeamConstraintsInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         Model.object = _loc2_;
         this.battleEntranceModel.equipmentNotMatchConstraints();
         Model.popObject();
      }
      
      private function loadBattleInfo(param1:LoadBattleInfoInPacket) : void
      {
         var battleData:Object = JSON.parse(param1.battlesJson);
         selectedBattleId = battleData.itemId;

         var battleGameObject:IGameObject = this.battleSelectSpace.getObjectByName(battleData.itemId);

         var battleParamInfoCC:BattleParamInfoCC = new BattleParamInfoCC();
         battleParamInfoCC.map = this.battleSelectSpace.getObject(Long.getLong(battleData.preview * 1000, battleData.preview * 1000));
         battleParamInfoCC.params = new BattleCreateParameters();
         battleParamInfoCC.params.battleId = battleData.itemId;
         battleParamInfoCC.params.autoBalance = battleData.autoBalance;
         battleParamInfoCC.params.battleMode = EnumUtils.stringToBattleMode(battleData.battleMode);
         battleParamInfoCC.params.equipmentConstraintsMode = EnumUtils.stringToEquipmentConstraintsMode(battleData.equipmentConstraintsMode);
         battleParamInfoCC.params.friendlyFire = battleData.friendlyFire;
         battleParamInfoCC.params.limits = new BattleLimits();
         battleParamInfoCC.params.limits.scoreLimit = battleData.scoreLimit;
         battleParamInfoCC.params.limits.timeLimitInSec = battleData.timeLimitInSec;
         //battleParamInfoCC.params.mapId = ;
         battleParamInfoCC.params.maxPeopleCount = battleData.maxPeopleCount;
         battleParamInfoCC.params.name = battleData.name;
         battleParamInfoCC.params.parkourMode = battleData.parkourMode;
         battleParamInfoCC.params.privateBattle = false; // not provided in payload
         battleParamInfoCC.params.proBattle = battleData.proBattle;
         battleParamInfoCC.params.rankRange = new Range(battleData.maxRank, battleData.minRank);
         battleParamInfoCC.params.reArmorEnabled = battleData.reArmorEnabled;
         //battleParamInfoCC.params.theme = null; // no theme info in payload
         battleParamInfoCC.params.withoutBonuses = battleData.withoutBonuses;
         battleParamInfoCC.params.withoutCrystals = battleData.withoutCrystals;
         battleParamInfoCC.params.withoutDrones = true; // not provided
         battleParamInfoCC.params.withoutSupplies = battleData.withoutSupplies;
         battleParamInfoCC.params.withoutUpgrades = battleData.withoutUpgrades != null ? battleData.withoutUpgrades : false;
         battleParamInfoCC.params.reducedResistances = battleData.reducedResistance;
         battleParamInfoCC.params.esportDropTiming = battleData.esportDropTiming;
         battleParamInfoCC.params.withoutGoldBoxes = battleData.withoutGoldBoxes;
         battleParamInfoCC.params.withoutGoldSiren = battleData.withoutGoldSiren;
         battleParamInfoCC.params.withoutGoldZone = battleData.withoutGoldZone;
         battleParamInfoCC.params.randomGold = battleData.randomGold;
         battleParamInfoCC.params.withoutMedkit = battleData.withoutMedkit;
         battleParamInfoCC.params.withoutMines = battleData.withoutMines;
         battleParamInfoCC.params.dependentCooldownEnabled = battleData.dependentCooldownEnabled;

         // Load BattleParamInfoModel again
         Model.object = battleGameObject;
         this.battleParamInfoModel.putInitParams(battleParamInfoCC);
         Model.popObject();

         var battleInfoCC:BattleInfoCC = new BattleInfoCC();
         battleInfoCC.roundStarted = battleData.roundStarted;
         battleInfoCC.suspicionLevel = BattleSuspicionLevel.NONE;
         battleInfoCC.timeLeftInSec = battleData.timeLeftInSec;

         // Load BattleParamInfoModel again
         Model.object = battleGameObject;
         this.battleInfoModel.putInitParams(battleInfoCC);
         Model.popObject();

         if (battleData.battleMode == "DM")
         {
            var battleDMInfoCC:BattleDMInfoCC = new BattleDMInfoCC();
            battleDMInfoCC.users = new Vector.<BattleInfoUser>();

            for each (var dmUser:Object in battleData.users)
            {
               battleDMInfoCC.users.push(this.buildBattleInfoUser(dmUser));
            }

            // Load BattleDMInfoModel again
            Model.object = battleGameObject;
            this.battleDmInfoModel.putInitParams(battleDMInfoCC);
            this.battleDmInfoModel.reloadCC();
            Model.popObject();
         }
         else
         {
            var teamBattleInfoCC:TeamBattleInfoCC = new TeamBattleInfoCC();
            teamBattleInfoCC.usersBlue = new Vector.<BattleInfoUser>();
            teamBattleInfoCC.usersRed = new Vector.<BattleInfoUser>();

            for each (var blueUser:Object in battleData.usersBlue)
            {
               teamBattleInfoCC.usersBlue.push(this.buildBattleInfoUser(blueUser));
            }

            for each (var redUser:Object in battleData.usersRed)
            {
               teamBattleInfoCC.usersRed.push(this.buildBattleInfoUser(redUser));
            }

            // Load TeamBattleInfoModel again
            Model.object = battleGameObject;
            this.teamBattleInfoModel.putInitParams(teamBattleInfoCC);
            this.teamBattleInfoModel.reloadCC();
            Model.popObject();
         }
         ShowInfo(battleGameObject.adapt(ShowInfo)).showInfo();
      }

      private function buildBattleInfoUser(param1:Object) : BattleInfoUser
      {
         var _loc2_:BattleInfoUser = new BattleInfoUser();
         _loc2_.user = param1.user;
         _loc2_.score = Math.max(param1.kills, param1.score); // Protanki server has kills and score, but in tanki 2019 client there is only score field. So we use the one that is not 0.
         _loc2_.suspicious = param1.suspicious;
         return _loc2_;
      }
      
      private function unload(param1:UnloadBattleInfoInPacket) : void
      {
         // We don't want to unload, because in 2019 client battle info model is used also in battle list.
         // In protanki there is item model for battle list.

         //var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(selectedBattleId);
         //if(_loc2_ != null)
         //{
         //   Model.object = _loc2_;
         //   this.battleSelectSpace.destroyObject(_loc2_.id);
         //   Model.popObject();
         //}
      }
   }
}

