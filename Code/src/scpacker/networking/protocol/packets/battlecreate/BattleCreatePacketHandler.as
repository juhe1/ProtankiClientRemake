package scpacker.networking.protocol.packets.battlecreate
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import projects.tanks.client.battleselect.model.map.MapInfoCC;
   import alternativa.types.Long;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.Range;
   import alternativa.tanks.model.battleselect.create.BattleCreateModel;
   import alternativa.tanks.model.map.mapinfo.MapInfoModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.createparams.BattleLimits;
   import platform.client.fp10.core.model.impl.*;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.IGameClass;
   import projects.tanks.client.battleselect.model.battleselect.create.BattleCreateCC;
   import scpacker.networking.protocol.packets.battlecreate.BattleCreateFailedDisabledInPacket;
   import scpacker.networking.protocol.packets.battlecreate.BattleCreateFailedServerHaltingInPacket;
   import scpacker.networking.protocol.packets.battlecreate.BattleCreateFailedTooManyBattlesInPacket;
   import scpacker.networking.protocol.packets.battlecreate.BattleCreateFailedBannedInPacket;
   import scpacker.networking.protocol.packets.battlecreate.SetFilteredBattleNameInPacket;
   import platform.client.fp10.core.type.ISpace;
   import scpacker.utils.EnumUtils;
   import projects.tanks.client.battleselect.model.battleselect.BattleSelectModelBase;
   import projects.tanks.client.battleselect.model.battleselect.create.BattleCreateModelBase;
   import projects.tanks.client.battleselect.model.map.MapInfoModelBase;
   import scpacker.SpaceAndGameObjectIds;
   import projects.tanks.client.tanksservices.model.formatbattle.EquipmentConstraintsCC;
   import projects.tanks.client.tanksservices.model.formatbattle.EquipmentConstraintsNamingModelBase;
   import projects.tanks.client.tanksservices.model.formatbattle.EquipmentConstraintsModeInfo;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.formatbattle.EquipmentConstraintsNamingModel;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.UserProBattleService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.IUserProBattleService;
   import alternativa.osgi.OSGi;
   
   public class BattleCreatePacketHandler extends AbstractPacketHandler
   {
      private var battleCreateModel:BattleCreateModel;
      private var mapInfoModel:MapInfoModel;
      private var equipmentConstraintsNamingMode:EquipmentConstraintsNamingModel;
      
      //private var clanInfoModel:ClanInfoModel;
      
      private var battleSelectGameClass:IGameClass;
      private var battleSelectObject:IGameObject;
      private var mapGameClass:IGameClass;
      
      private var userProBattleService:IUserProBattleService;
      
      public function BattleCreatePacketHandler()
      {
         super();
         this.id = 30;
         this.battleCreateModel = BattleCreateModel(modelRegistry.getModel(BattleCreateModelBase.modelId));
         this.mapInfoModel = MapInfoModel(modelRegistry.getModel(MapInfoModelBase.modelId));
         this.equipmentConstraintsNamingMode = EquipmentConstraintsNamingModel(modelRegistry.getModel(EquipmentConstraintsNamingModelBase.modelId));
         this.userProBattleService = OSGi.getInstance().getService(IUserProBattleService) as IUserProBattleService;
         //this.clanInfoModel = ClanInfoModel(modelRegistry.getModel(Long.getLong(0,300090014)));

         var battleSelectModels:Vector.<Long> = new Vector.<Long>();
         battleSelectModels.push(BattleCreateModelBase.modelId);
         battleSelectModels.push(BattleSelectModelBase.modelId);
         battleSelectModels.push(EquipmentConstraintsNamingModelBase.modelId);

         var mapModels:Vector.<Long> = new Vector.<Long>();
         mapModels.push(MapInfoModelBase.modelId);
         //_loc2_.push(this.clanInfoModel.id);

         this.mapGameClass = gameTypeRegistry.createClass(Long.getLong(8238523,63486349),mapModels);
         this.battleSelectGameClass = gameTypeRegistry.createClass(Long.getLong(591359,5235923),battleSelectModels);
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case BattleCreateFailedDisabledInPacket.id:
               this.createFailedBattleCreateDisabled();
               break;
            case BattleCreateFailedServerHaltingInPacket.id:
               this.createFailedServerIsHalting();
               break;
            case BattleCreateFailedTooManyBattlesInPacket.id:
               this.createFailedTooManyBattlesFromYou();
               break;
            case BattleCreateFailedBannedInPacket.id:
               this.createFailedYouAreBanned();
               break;
            case InitBattleSelectInPacket.id:
               this.initBattleList(param1 as InitBattleSelectInPacket);
               break;
            case SetFilteredBattleNameInPacket.id:
               this.setFilteredBattleName(param1 as SetFilteredBattleNameInPacket);
         }
      }
      
      private function initBattleList(param1:InitBattleSelectInPacket) : void
      {
          var mapObjectInstance:IGameObject = null;
          var mapInfoInstance:MapInfoCC = null;
          //var clanInfoInstance:ClanInfoCC = null;
          var spaceInstance:ISpace = spaceRegistry.getSpace(SpaceAndGameObjectIds.BATTLE_SELECT_SPACE_ID);
          this.battleSelectObject = spaceInstance.createObject(SpaceAndGameObjectIds.BATTLE_SELECT_OBJECT_ID,this.battleSelectGameClass,"BattleSelectObject");
          
          var battlesData:Object = JSON.parse(param1.battlesJson);
          this.userProBattleService.setAbonementRemainingTimeSec(battlesData.proBattleTimeLeftInSec);
          for each(var mapData in battlesData.maps)
          {
            mapObjectInstance = spaceInstance.createObject(Long.getLong(mapData.preview * 1000,mapData.preview * 1000),this.mapGameClass,mapData.mapId + mapData.theme);
            mapInfoInstance = new MapInfoCC();
            mapInfoInstance.additionalCrystalsPercent = mapData.additionalCrystalsPercent;
            mapInfoInstance.enabled = mapData.enabled;
            mapInfoInstance.mapId = mapData.mapId;
            mapInfoInstance.mapName = mapData.mapName;
            mapInfoInstance.maxPeople = mapData.maxPeople;
            mapInfoInstance.preview = ImageResource(resourceRegistry.getResource(Long.getLong(0,mapData.preview)));
            mapInfoInstance.rankLimit = new Range(mapData.maxRank,mapData.minRank);
            mapInfoInstance.supportedModes = new Vector.<BattleMode>();
            for each(var mode in mapData.supportedModes)
            {
               mapInfoInstance.supportedModes.push(EnumUtils.stringToBattleMode(mode));
            }
            mapInfoInstance.theme = EnumUtils.stringToMapTheme(mapData.theme);
            //_loc2_ = new ClanInfoCC(mapData.clanLink,mapData.clanName);
            Model.object = mapObjectInstance;
            this.mapInfoModel.putInitParams(mapInfoInstance);
            this.mapInfoModel.objectLoaded();
            //this.clanInfoModel.putInitParams(clanInfoInstance);
            Model.popObject();
          }

         var equipmentConstraintsCC:EquipmentConstraintsCC = new EquipmentConstraintsCC();
         equipmentConstraintsCC.equipmentConstraintsModeInfos = new Vector.<EquipmentConstraintsModeInfo>();
         //equipmentConstraintsCC.equipmentConstraintsModeInfos.push(new EquipmentConstraintsModeInfo(0,"NONE","Default"));
         equipmentConstraintsCC.equipmentConstraintsModeInfos.push(new EquipmentConstraintsModeInfo(0,"HORNET_RAILGUN","Hornet & Railgun"));
         equipmentConstraintsCC.equipmentConstraintsModeInfos.push(new EquipmentConstraintsModeInfo(1,"WASP_RAILGUN","Wasp & Railgun"));
         equipmentConstraintsCC.equipmentConstraintsModeInfos.push(new EquipmentConstraintsModeInfo(2,"HORNET_WASP_RAILGUN","Hornet, Wasp & Railgun"));

         Model.object = this.battleSelectObject;
         this.equipmentConstraintsNamingMode.putInitParams(equipmentConstraintsCC);
         this.equipmentConstraintsNamingMode.objectLoaded();
         Model.popObject();

          Model.object = this.battleSelectObject;

          var battleCreateParams:BattleCreateCC = new BattleCreateCC();
          battleCreateParams.battleCreationDisabled = battlesData.battleCreationDisabled;
          battleCreateParams.battlesLimits = new Vector.<BattleLimits>();
   
          for each(var limit in battlesData.battleLimits)
          {
            battleCreateParams.battlesLimits.push(new BattleLimits(limit.scoreLimit,limit.timeLimitInSec));
          }

          battleCreateParams.maxRangeLength = battlesData.maxRangeLength;
          battleCreateParams.maxRange = new Range(mapData.maxRank,mapData.minRank);
          var defaultMaxRank:int = Math.min(mapData.minRank + battlesData.maxRangeLength - 1, mapData.maxRank);
          battleCreateParams.defaultRange = new Range(defaultMaxRank, mapData.minRank);
          //battleCreateParams.proBattleTimeLeftInSec = battlesData.proBattleTimeLeftInSec;
          this.battleCreateModel.putInitParams(battleCreateParams);
          this.battleCreateModel.objectLoaded();
          this.battleCreateModel.objectLoadedPost();
          Model.popObject();
      }
      
      private function createFailedBattleCreateDisabled() : void
      {
         this.battleCreateModel.createFailedBattleCreateDisabled();
      }
      
      private function createFailedServerIsHalting() : void
      {
         this.battleCreateModel.createFailedServerIsHalting();
      }
      
      private function createFailedTooManyBattlesFromYou() : void
      {
         this.battleCreateModel.createFailedTooManyBattlesFromYou();
      }
      
      private function createFailedYouAreBanned() : void
      {
         this.battleCreateModel.createFailedYouAreBanned();
      }
      
      private function setFilteredBattleName(param1:SetFilteredBattleNameInPacket) : void
      {
         var _loc2_:IGameObject = spaceRegistry.getSpace(SpaceAndGameObjectIds.BATTLE_SELECT_SPACE_ID).getObjectByName("BattleSelectObject");
         Model.object = _loc2_;
         this.battleCreateModel.setFilteredBattleName(param1.battleName);
         Model.popObject();
      }
   }
}

