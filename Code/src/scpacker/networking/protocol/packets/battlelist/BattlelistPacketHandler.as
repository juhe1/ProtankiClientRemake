package scpacker.networking.protocol.packets.battlelist
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import projects.tanks.client.battleservice.Range;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.model.battleselect.BattleSelectModel;
   import alternativa.tanks.service.achievement.IAchievementService;
   import scpacker.networking.protocol.AbstractPacket;
   import platform.client.fp10.core.model.impl.*;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.IGameClass;
   import projects.tanks.client.battleselect.model.item.BattleSuspicionLevel;
   import projects.tanks.client.battleselect.model.battle.dm.BattleDMInfoCC;
   import projects.tanks.client.battleselect.model.battle.dm.BattleDMInfoModelBase;
   import alternativa.tanks.model.info.dm.BattleDmInfoModel;
   import alternativa.tanks.model.info.BattleInfoModel;
   import alternativa.tanks.model.info.team.BattleTeamInfoModel;
   import alternativa.tanks.model.info.param.BattleParamInfoModel;
   import projects.tanks.client.battleselect.model.battle.BattleInfoModelBase;
   import projects.tanks.client.battleselect.model.battle.team.TeamBattleInfoModelBase;
   import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoModelBase;
   import platform.client.fp10.core.type.ISpace;
   import scpacker.utils.IdTool;
   import projects.tanks.client.battleselect.model.battle.BattleInfoCC;
   import projects.tanks.client.battleselect.model.battle.team.TeamBattleInfoCC;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;
   import projects.tanks.client.battleservice.BattleCreateParameters;
   import scpacker.utils.EnumUtils;
   import projects.tanks.client.battleselect.model.battleselect.BattleSelectModelBase;
   import scpacker.SpaceAndGameObjectIds;
   import projects.tanks.client.battleservice.model.createparams.BattleLimits;
   import projects.tanks.client.battleselect.model.battle.entrance.BattleEntranceModelBase;
   
   public class BattleListPacketHandler extends AbstractPacketHandler
   {
      private var battleSelectModel:BattleSelectModel;
      private var achievementService:IAchievementService;
      private var battleSelectSpace:ISpace;

      private var battleInfoModel:BattleInfoModel;
      private var battleInfoDmModel:BattleDmInfoModel;
      private var battleTeamInfoModel:BattleTeamInfoModel;
      private var battleParamsInfoModel:BattleParamInfoModel;

      public static var dmBattleInfoGameClass:IGameClass;
      public static var teamBattleInfoGameClass:IGameClass;
      
      private var battleSelectObject:IGameObject;
      
      public function BattleListPacketHandler()
      {
         super();
         this.id = 31;

         this.battleSelectModel = BattleSelectModel(modelRegistry.getModel(BattleSelectModelBase.modelId));
         this.battleInfoModel = BattleInfoModel(modelRegistry.getModel(BattleInfoModelBase.modelId));
         this.battleInfoDmModel = BattleDmInfoModel(modelRegistry.getModel(BattleDMInfoModelBase.modelId));
         this.battleTeamInfoModel = BattleTeamInfoModel(modelRegistry.getModel(TeamBattleInfoModelBase.modelId));
         this.battleParamsInfoModel = BattleParamInfoModel(modelRegistry.getModel(BattleParamInfoModelBase.modelId));
         
         var modelVector:Vector.<Long> = new Vector.<Long>();
         modelVector.push(BattleInfoModelBase.modelId);
         modelVector.push(BattleDMInfoModelBase.modelId);
         modelVector.push(BattleParamInfoModelBase.modelId);
         modelVector.push(BattleEntranceModelBase.modelId);
         dmBattleInfoGameClass = gameTypeRegistry.createClass(Long.getLong(5823623,5812059),modelVector);

         modelVector = new Vector.<Long>();
         modelVector.push(BattleInfoModelBase.modelId);
         modelVector.push(TeamBattleInfoModelBase.modelId);
         modelVector.push(BattleParamInfoModelBase.modelId);
         modelVector.push(BattleEntranceModelBase.modelId);
         teamBattleInfoGameClass = gameTypeRegistry.createClass(Long.getLong(5823622,5812058),modelVector);

         this.battleSelectSpace = spaceRegistry.getSpace(SpaceAndGameObjectIds.BATTLE_SELECT_SPACE_ID);
         this.achievementService = IAchievementService(OSGi.getInstance().getService(IAchievementService));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case BattleCreatedInPacket.id:
               this.createBattle(param1 as BattleCreatedInPacket);
               break;
            case LoadAllBattlesInPacket.id:
               this.loadAllBattles(param1 as LoadAllBattlesInPacket);
               break;
            case RemoveBattleInPacket.id:
               this.removeBattle(param1 as RemoveBattleInPacket);
               break;
            case SelectBattleInOutPacket.id:
               this.selectBattle(param1 as SelectBattleInOutPacket);
               break;
            case UnloadBattleSelectSpaceInPacket.id:
               this.unloadAllBattles();
         }
      }
      
      private function loadAllBattles(param1:LoadAllBattlesInPacket) : void
      {
         // Creating object for BattleSelectModel so that getFunctionWrapper works correctly
         var spaceInstance:ISpace = spaceRegistry.getSpace(SpaceAndGameObjectIds.BATTLE_SELECT_SPACE_ID);
         this.battleSelectObject = spaceInstance.getObject(SpaceAndGameObjectIds.BATTLE_SELECT_OBJECT_ID);

         if (this.battleSelectObject == null)
         {
            throw new Error("BattleSelectObject is null in BattleListPacketHandler.loadAllBattles");
         }

         Model.object = this.battleSelectObject;
         
         var _loc3_:Object = JSON.parse(param1.battlesJson);
         this.battleSelectModel.objectLoadedPost();
         for each(var _loc2_ in _loc3_.battles)
         {
            this.addBattle(_loc2_);
         }
         this.battleSelectModel.battleItemsPacketJoinSuccess();
         
         Model.popObject();
         //this.achievementService.setPanelPartition(2);
      }
      
      private function selectBattle(param1:SelectBattleInOutPacket) : void
      {
         var battleGameObject:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if (battleGameObject == null)
         {
            throw new Error("Battle object not found in BattleListPacketHandler.selectBattle: " + param1.battleId);
         }

         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName("BattleSelectObject");
         Model.object = _loc2_;
         this.battleSelectModel.select(battleGameObject);
         Model.popObject();
      }
      
      private function createBattle(param1:BattleCreatedInPacket) : void
      {
         this.addBattle(JSON.parse(param1.battlesJson));
      }
      
      private function removeBattle(param1:RemoveBattleInPacket) : void
      {
         var _loc2_:IGameObject = this.battleSelectSpace.getObjectByName(param1.battleId);
         if(_loc2_ != null)
         {
            platform.client.fp10.core.model.impl.Model.object = _loc2_;
            this.battleSelectSpace.destroyObject(_loc2_.id);
            Model.popObject();
         }
      }

      private function addBattle(battleData:Object) : void
      {
         var battleInfoGameClass:IGameClass = dmBattleInfoGameClass;
         if(battleData.battleMode != "DM")
         {
            battleInfoGameClass = teamBattleInfoGameClass;
         }

         if(this.battleSelectSpace.getObjectByName(battleData.battleId) != null)
         {
            this.battleSelectSpace.destroyObject(this.battleSelectSpace.getObjectByName(battleData.battleId).id);
         }

         var battleGameObject:IGameObject = this.battleSelectSpace.createObject(IdTool.getNextId(), battleInfoGameClass, battleData.battleId);
         
         var battleParamInfoCC:BattleParamInfoCC = new BattleParamInfoCC();
         battleParamInfoCC.map = this.battleSelectSpace.getObject(Long.getLong(battleData.preview * 1000, battleData.preview * 1000));
         battleParamInfoCC.params = new BattleCreateParameters();
         battleParamInfoCC.params.battleId = battleData.battleId;
         battleParamInfoCC.params.battleMode = EnumUtils.stringToBattleMode(battleData.battleMode);
         battleParamInfoCC.params.maxPeopleCount = battleData.maxPeople;
         battleParamInfoCC.params.name = battleData.name;
         battleParamInfoCC.params.privateBattle = battleData.privateBattle;
         battleParamInfoCC.params.proBattle = battleData.proBattle;
         battleParamInfoCC.params.rankRange = new Range(battleData.maxRank,battleData.minRank);
         battleParamInfoCC.params.equipmentConstraintsMode = EnumUtils.stringToEquipmentConstraintsMode(battleData.equipmentConstraintsMode);
         battleParamInfoCC.params.parkourMode = battleData.parkourMode;
         battleParamInfoCC.params.limits = new BattleLimits();

         // Load BattleParamInfoModel
         Model.object = battleGameObject;
         this.battleParamsInfoModel.putInitParams(battleParamInfoCC);
         Model.popObject();

         var battleInfoCC:BattleInfoCC = new BattleInfoCC();
         battleInfoCC.roundStarted = true;
         battleInfoCC.suspicionLevel = EnumUtils.stringToBattleSuspicionLevel(battleData.suspicionLevel);
         battleInfoCC.timeLeftInSec = 0;

         // Load BattleInfoModel
         Model.object = battleGameObject;
         this.battleInfoModel.putInitParams(battleInfoCC);
         Model.popObject();

         if (battleData.battleMode == "DM")
         {
            var battleDMInfoCC:BattleDMInfoCC = new BattleDMInfoCC();
            battleDMInfoCC.users = new Vector.<BattleInfoUser>();

            for each (var userName:String in battleData.users)
            {
               var user:BattleInfoUser = new BattleInfoUser();
               user.user = userName;
               battleDMInfoCC.users.push(user);
            }

            // Load BattleDMInfoModel
            Model.object = battleGameObject;
            this.battleInfoDmModel.putInitParams(battleDMInfoCC);
            this.battleInfoDmModel.objectLoaded();
            Model.popObject();
         } else 
         {
            var teamBattleInfoCC:TeamBattleInfoCC = new TeamBattleInfoCC();
            teamBattleInfoCC.usersBlue = new Vector.<BattleInfoUser>();
            teamBattleInfoCC.usersRed = new Vector.<BattleInfoUser>();

            for each (userName in battleData.usersBlue)
            {
               user = new BattleInfoUser();
               user.user = userName;
               teamBattleInfoCC.usersBlue.push(user);
            }

            for each (userName in battleData.usersRed)
            {
               user = new BattleInfoUser();
               user.user = userName;
               teamBattleInfoCC.usersRed.push(user);
            }

            // Load TeamBattleInfoModel
            Model.object = battleGameObject;
            this.battleTeamInfoModel.putInitParams(teamBattleInfoCC);
            this.battleTeamInfoModel.objectLoaded();
            Model.popObject();
         }
      }
      
      private function unloadAllBattles() : void
      {
         var _loc1_:Vector.<IGameObject> = new Vector.<IGameObject>();
         for each(var _loc3_ in this.battleSelectSpace.objects)
         {
            _loc1_.push(_loc3_);
         }
         _loc1_.reverse();
         for each(_loc3_ in _loc1_)
         {
            this.battleSelectSpace.destroyObject(_loc3_.id);
         }
      }
   }
}

