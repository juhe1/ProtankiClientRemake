package scpacker.networking.protocol.packets.battle
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import projects.tanks.client.battlefield.types.Vector3d;
   import alternativa.tanks.models.battle.dm.BattleDMModel;
   import alternativa.tanks.models.tank.rankup.TankRankUpEffectModel;
   import alternativa.tanks.models.bonus.bonuslight.BonusLightModel;
   import alternativa.types.Long;
   import alternativa.tanks.models.map.BattleMapModel;
   import alternativa.tanks.models.bonus.region.BonusRegionsModel;
   import projects.tanks.client.battlefield.models.bonus.bonus.common.BonusCommonCC;
   import alternativa.tanks.models.tank.engine.EngineModel;
   import projects.tanks.client.battlefield.models.map.DynamicShadowParams;
   import projects.tanks.client.battlefield.models.map.DustParams;
   import projects.tanks.client.battlefield.models.map.SkyboxSides;
   import projects.tanks.client.battlefield.models.map.FogParams;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battlefield.models.tankparts.armor.rankup.TankRankUpEffectCC;
   import alternativa.tanks.models.battle.tdm.BattleTDMModel;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.models.battle.assault.AssaultModel;
   import alternativa.tanks.models.battle.battlefield.BattlefieldModel;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.controlpoints.IDominationModel;
   import alternativa.tanks.models.controlpoints.ControlPointsModel;
   import alternativa.tanks.models.statistics.IClientUserInfo;
   import alternativa.tanks.models.statistics.StatisticsModel;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.models.tank.TankModel;
   import alternativa.tanks.services.initialeffects.IInitialEffectsService;
   import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import alternativa.tanks.models.battle.ctf.ICTFModel;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import alternativa.tanks.models.sfx.bcsh.BCSHModel;
   import alternativa.tanks.models.tank.explosion.TankExplosionModel;
   import projects.tanks.client.battlefield.models.bonus.bonuslight.BonusLightCC;
   import flash.geom.ColorTransform;
   import alternativa.tanks.models.bonus.common.BonusCommonModel;
   import projects.tanks.client.battlefield.models.tankparts.armor.explosion.TankExplosionCC;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.object.ClientObject;
   import projects.tanks.client.battlefield.models.tankparts.engine.EngineCC;
   import projects.tanks.clients.flash.commons.models.coloring.ColoringModel;
   import scpacker.utils.CoreUtils;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.model.impl.*;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.impl.GameClass;
   import platform.client.fp10.core.type.impl.GameObject;
   import projects.tanks.clients.flash.resources.resource.MapResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import alternativa.tanks.models.teamlight.ModeLight;
   import alternativa.tanks.models.teamlight.TeamLightColor;
   import projects.tanks.client.commons.models.coloring.ColoringCC;
   import projects.tanks.client.garage.models.item.object3ds.Object3DSCC;
   import alternativa.tanks.model.item3d.Object3DSModel;
   import alternativa.tanks.models.battle.battlefield.mine.BattleMinesModel;
   import projects.tanks.client.commons.models.coloring.ColoringModelBase;
   import projects.tanks.client.garage.models.item.object3ds.Object3DSModelBase;
   import projects.tanks.client.battlefield.models.tankparts.engine.EngineModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.bcsh.BCSHModelBase;
   import projects.tanks.client.battlefield.models.battle.battlefield.BattlefieldModelBase;
   import projects.tanks.client.battlefield.models.map.BattleMapModelBase;
   import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMinesModelBase;
   import projects.tanks.client.battlefield.models.user.tank.TankModelBase;
   import projects.tanks.client.battleservice.model.battle.tdm.BattleTDMModelBase;
   import projects.tanks.client.battleservice.model.battle.dm.BattleDMModelBase;
   import projects.tanks.client.battlefield.models.tankparts.armor.explosion.TankExplosionModelBase;
   import projects.tanks.client.battlefield.models.tankparts.armor.rankup.TankRankUpEffectModelBase;
   import projects.tanks.client.battlefield.models.bonus.bonuslight.BonusLightModelBase;
   import platform.client.fp10.core.type.ISpace;
   import projects.tanks.client.battlefield.models.map.BattleMapCC;
   import projects.tanks.client.battlefield.models.battle.battlefield.BattlefieldCC;
   import projects.tanks.client.battlefield.models.battle.battlefield.types.BattlefieldSounds;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingEffectEntity;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightEffectItem;
   import projects.tanks.client.battleservice.Range;
   import projects.tanks.client.battlefield.models.mapbonuslight.MapBonusLightCC;
   import alternativa.tanks.models.mapbonuslight.MapBonusLightModel;
   import projects.tanks.client.battlefield.models.mapbonuslight.MapBonusLightModelBase;
   import projects.tanks.client.battlefield.models.coloradjust.ColorAdjustParams;
   import alternativa.tanks.models.teamlight.TeamLightModel;
   import projects.tanks.client.battlefield.models.teamlight.TeamLightModelBase;
   import projects.tanks.client.battlefield.models.teamlight.TeamLightCC;
   import projects.tanks.client.battlefield.models.teamlight.TeamLightParams;
   import projects.tanks.client.battlefield.models.teamlight.TeamLightColorParams;
   import alternativa.tanks.models.coloradjust.ColorAdjustModel;
   import projects.tanks.client.battlefield.models.coloradjust.ColorAdjustModelBase;
   import projects.tanks.client.battlefield.models.coloradjust.ColorAdjustCC;
   import alternativa.tanks.models.bonus.battlefield.BattlefieldBonusesModel;
   import projects.tanks.client.battlefield.models.bonus.battle.battlefield.BattlefieldBonusesModelBase;
   import projects.tanks.client.battlefield.models.bonus.battle.battlefield.BattlefieldBonusesCC;
   import projects.tanks.client.battlefield.models.bonus.battle.BonusSpawnData;
   import projects.tanks.client.battleservice.model.statistics.StatisticsModelBase;
   import projects.tanks.client.battleservice.model.statistics.dm.StatisticsDMModelBase;
   import projects.tanks.client.battleservice.model.statistics.team.StatisticsTeamModelBase;
   import alternativa.tanks.models.sfx.smoke.HullSmokeModel;
   import alternativa.tanks.models.tank.hullcommon.HullCommon;
   import alternativa.tanks.models.tank.hullcommon.HullCommonModel;
   import alternativa.tanks.models.tank.armor.SimpleArmorModel;
   import projects.tanks.client.battlefield.models.tankparts.armor.simple.SimpleArmorModelBase;
   import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.smoke.HullSmokeModelBase;
   import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonCC;
   import projects.tanks.client.battlefield.models.tankparts.armor.simple.SimpleArmorCC;
   import alternativa.tanks.models.weapon.common.WeaponCommonModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.turret.RotatingTurretModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.common.WeaponCommonModelBase;
   import alternativa.tanks.models.weapon.turret.RotatingTurretModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.common.WeaponCommonCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.turret.RotatingTurretCC;
   import alternativa.tanks.models.tank.configuration.TankConfigurationModel;
   import projects.tanks.client.battlefield.models.user.configuration.TankConfigurationModelBase;
   import alternativa.tanks.models.tank.suicude.SuicideModel;
   import projects.tanks.client.battlefield.models.user.suicide.SuicideModelBase;
   import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristicsModel;
   import projects.tanks.client.battlefield.models.user.speedcharacteristics.SpeedCharacteristicsModelBase;
   import alternativa.tanks.models.tank.temperature.TankTemperatureModel;
   import projects.tanks.client.battlefield.models.user.temperature.TankTemperatureModelBase;
   import alternativa.tanks.models.tank.reloader.TankReloaderModel;
   import projects.tanks.client.battlefield.models.user.reloader.TankReloaderModelBase;
   import alternativa.tanks.models.tank.spawn.TankSpawnerModel;
   import projects.tanks.client.battlefield.models.user.spawn.TankSpawnerModelBase;
   import alternativa.tanks.models.tank.pause.TankPauseModel;
   import projects.tanks.client.battlefield.models.user.pause.TankPauseModelBase;
   import alternativa.tanks.models.tank.turnover.TankTurnOverModel;
   import projects.tanks.client.battlefield.models.user.turnover.TankTurnOverModelBase;
   import alternativa.tanks.models.tank.damageindicator.DamageIndicatorModel;
   import projects.tanks.client.battlefield.models.user.damageindicator.DamageIndicatorModelBase;
   import projects.tanks.client.battlefield.models.user.tank.TankCC;
   import scpacker.utils.EnumUtils;
   import projects.tanks.client.battlefield.types.TankState;
   import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
   import scpacker.utils.IdTool;
   import projects.tanks.client.battlefield.models.user.configuration.TankConfigurationCC;
   import projects.tanks.client.battlefield.models.user.suicide.SuicideCC;
   import projects.tanks.client.battlefield.models.user.speedcharacteristics.SpeedCharacteristicsCC;
   import projects.tanks.client.battlefield.models.user.spawn.TankSpawnerCC;
   import projects.tanks.client.battlefield.models.user.resistance.TankResistancesCC;
   import scpacker.weapon.WeaponSfxModelUtil;
   import scpacker.weapon.WeaponModelUtil;
   import platform.client.fp10.core.type.IGameClass;
   import flash.utils.Dictionary;
   import alternativa.tanks.models.tank.gearscore.BattleGearScoreModel;
   import projects.tanks.client.battlefield.models.tankparts.gearscore.BattleGearScoreModelBase;
   import projects.tanks.client.battlefield.models.tankparts.gearscore.BattleGearScoreCC;
   import alternativa.tanks.models.tank.resistance.TankResistancesModel;
   import projects.tanks.client.battlefield.models.user.resistance.TankResistancesModelBase;
   import projects.tanks.client.battlefield.models.user.resistance.TankResistance;
   import alternativa.tanks.models.tank.device.TankDeviceModel;
   import projects.tanks.client.battlefield.models.user.device.TankDeviceModelBase;
   import projects.tanks.client.battlefield.models.user.device.TankDeviceCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.smoke.HullSmokeCC;
   import alternativa.tanks.models.battle.gui.inventory.InventoryModel;
   import projects.tanks.client.battlefield.models.battle.gui.inventory.InventoryModelBase;
   import projects.tanks.client.battlefield.models.battle.gui.inventory.InventoryCC;
   import projects.tanks.client.battlefield.models.user.bossstate.BossStateModelBase;
   import alternativa.tanks.models.tank.bosstate.BossStateModel;
   import projects.tanks.client.battlefield.models.user.bossstate.BossStateCC;
   import utils.TankNameGameObjectMapper;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.IObjectLoadListener;
   import scpacker.networking.protocol.packets.tank.TankPacketHandler;
   import platform.client.fp10.core.model.ObjectUnloadPostListener;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
   import platform.client.fp10.core.type.impl.Space;
   
   public class BattlePacketHandler extends AbstractPacketHandler
   {
      private var battlefieldModel:BattlefieldModel;
      private var coloringModel:ColoringModel;
      private var object3DSModel:Object3DSModel;
      private var engineModel:EngineModel;
      private var bcsHModel:BCSHModel;
      private var battleMapModel:BattleMapModel;
      private var mapBonusLightModel:MapBonusLightModel;
      private var battleMinesModel:BattleMinesModel;
      private var tankModel:TankModel;
      private var battleTDMModel:BattleTDMModel;
      private var battleDMModel:BattleDMModel;
      private var tankExplosionModel:TankExplosionModel;
      private var tankRankUpEffectModel:TankRankUpEffectModel;
      private var bonusLightModel:BonusLightModel;
      private var teamLightModel:TeamLightModel;
      private var colorAdjustModel:ColorAdjustModel;
      private var battlefieldBonusesModel:BattlefieldBonusesModel;
      private var hullSmokeModel:HullSmokeModel;
      private var hullCommonModel:HullCommonModel;
      private var simpleArmorModel:SimpleArmorModel;
      private var rotatingTurretModel:RotatingTurretModel;
      private var weaponCommonModel:WeaponCommonModel;
      private var tankConfigurationModel:TankConfigurationModel;
      private var suicideModel:SuicideModel;
      private var speedCharacteristicsModel:SpeedCharacteristicsModel;
      private var tankTemperatureModel:TankTemperatureModel;
      private var tankReloaderModel:TankReloaderModel;
      private var tankSpawnerModel:TankSpawnerModel;
      private var tankPauseModel:TankPauseModel;
      private var tankTurnOverModel:TankTurnOverModel;
      private var damageIndicatorModel:DamageIndicatorModel;
      private var battleGearScoreModel:BattleGearScoreModel;
      private var tankResistancesModel:TankResistancesModel;
      private var tankDeviceModel:TankDeviceModel;
      private var inventoryModel:InventoryModel;
      private var bossStateModel:BossStateModel;

      private var userPropertiesService:IUserPropertiesService;
      private var lightingEffectsService:ILightingEffectsService;
      private var lobbyLayoutService:ILobbyLayoutService = ILobbyLayoutService(OSGi.getInstance().getService(ILobbyLayoutService));

      private var battleSpace:ISpace;

      private var hullGameClass:GameClass;
      private var coloringGameClass:GameClass;
      private var mapGameClass:GameClass;
      private var battlefieldGameClass:IGameClass;
      private var tankGameClass:GameClass;

      static public var battlefieldGameObject:IGameObject;

      private var tankExplosionCC:TankExplosionCC;
      private var hullSmokeCC:HullSmokeCC;

      private var turretGameClassDictionary:Dictionary = new Dictionary();

      public function BattlePacketHandler()
      {
         super();
         this.id = 36;

         this.coloringModel = ColoringModel(modelRegistry.getModel(ColoringModelBase.modelId));
         this.object3DSModel = Object3DSModel(modelRegistry.getModel(Object3DSModelBase.modelId));
         this.engineModel = EngineModel(modelRegistry.getModel(EngineModelBase.modelId));
         this.bcsHModel = BCSHModel(modelRegistry.getModel(BCSHModelBase.modelId));
         this.battlefieldModel = BattlefieldModel(modelRegistry.getModel(BattlefieldModelBase.modelId));
         this.battleMapModel = BattleMapModel(modelRegistry.getModel(BattleMapModelBase.modelId));
         this.mapBonusLightModel = MapBonusLightModel(modelRegistry.getModel(MapBonusLightModelBase.modelId));
         this.battleMinesModel = BattleMinesModel(modelRegistry.getModel(BattleMinesModelBase.modelId));
         this.tankModel = TankModel(modelRegistry.getModel(TankModelBase.modelId));
         this.battleTDMModel = BattleTDMModel(modelRegistry.getModel(BattleTDMModelBase.modelId));
         this.battleDMModel = BattleDMModel(modelRegistry.getModel(BattleDMModelBase.modelId));
         this.tankExplosionModel = TankExplosionModel(modelRegistry.getModel(TankExplosionModelBase.modelId));
         this.tankRankUpEffectModel = TankRankUpEffectModel(modelRegistry.getModel(TankRankUpEffectModelBase.modelId));
         this.bonusLightModel = BonusLightModel(modelRegistry.getModel(BonusLightModelBase.modelId));
         this.teamLightModel = TeamLightModel(modelRegistry.getModel(TeamLightModelBase.modelId));
         this.colorAdjustModel = ColorAdjustModel(modelRegistry.getModel(ColorAdjustModelBase.modelId));
         this.battlefieldBonusesModel = BattlefieldBonusesModel(modelRegistry.getModel(BattlefieldBonusesModelBase.modelId));
         this.hullSmokeModel = HullSmokeModel(modelRegistry.getModel(HullSmokeModelBase.modelId));
         this.hullCommonModel = HullCommonModel(modelRegistry.getModel(HullCommonModelBase.modelId));
         this.simpleArmorModel = SimpleArmorModel(modelRegistry.getModel(SimpleArmorModelBase.modelId));
         this.weaponCommonModel = WeaponCommonModel(modelRegistry.getModel(WeaponCommonModelBase.modelId));
         this.rotatingTurretModel = RotatingTurretModel(modelRegistry.getModel(RotatingTurretModelBase.modelId));
         this.tankConfigurationModel = TankConfigurationModel(modelRegistry.getModel(TankConfigurationModelBase.modelId));
         this.suicideModel = SuicideModel(modelRegistry.getModel(SuicideModelBase.modelId));
         this.speedCharacteristicsModel = SpeedCharacteristicsModel(modelRegistry.getModel(SpeedCharacteristicsModelBase.modelId));
         this.tankTemperatureModel = TankTemperatureModel(modelRegistry.getModel(TankTemperatureModelBase.modelId));
         this.tankReloaderModel = TankReloaderModel(modelRegistry.getModel(TankReloaderModelBase.modelId));
         this.tankSpawnerModel = TankSpawnerModel(modelRegistry.getModel(TankSpawnerModelBase.modelId));
         this.tankPauseModel = TankPauseModel(modelRegistry.getModel(TankPauseModelBase.modelId));
         this.tankTurnOverModel = TankTurnOverModel(modelRegistry.getModel(TankTurnOverModelBase.modelId));
         this.damageIndicatorModel = DamageIndicatorModel(modelRegistry.getModel(DamageIndicatorModelBase.modelId));
         this.battleGearScoreModel = BattleGearScoreModel(modelRegistry.getModel(BattleGearScoreModelBase.modelId));
         this.tankResistancesModel = TankResistancesModel(modelRegistry.getModel(TankResistancesModelBase.modelId));
         this.tankDeviceModel = TankDeviceModel(modelRegistry.getModel(TankDeviceModelBase.modelId));
         this.inventoryModel = InventoryModel(modelRegistry.getModel(InventoryModelBase.modelId));
         this.bossStateModel = BossStateModel(modelRegistry.getModel(BossStateModelBase.modelId));

         this.userPropertiesService = IUserPropertiesService(OSGi.getInstance().getService(IUserPropertiesService));
         this.tankUsersRegistry = TankUsersRegistry(OSGi.getInstance().getService(TankUsersRegistry));
         this.lightingEffectsService = ILightingEffectsService(OSGi.getInstance().getService(ILightingEffectsService));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case TakeBonusBoxInPacket.id:
               //this.bonusTake(param1 as TakeBonusBoxInPacket);
               break;
            case InitBonusBoxesInPacket.id:
               //this.initBonusBoxes(param1 as InitBonusBoxesInPacket);
               break;
            case AddBonusBoxesInPacket.id:
               //this.addBonusBoxes(param1 as AddBonusBoxesInPacket);
               break;
            case InitializeSupplyEffectsInPacket.id:
               this.initializeSupplyEffects(param1 as InitializeSupplyEffectsInPacket);
               break;
            case InitBattleInPacket.id:
               this.initBattle(param1 as InitBattleInPacket);
               break;
            case CreateTankInPacket.id:
               this.createTank(param1 as CreateTankInPacket);
               break;
            case RemoveBonusBoxInPacket.id:
               //this.removeBonus(param1 as RemoveBonusBoxInPacket);
               break;
            case AddBonusBoxInPacket.id:
               //this.addBonus(param1 as AddBonusBoxInPacket);
               break;
            case UnloadBattleSpaceInPacket.id:
               this.unloadBattle();
         }
      }
      
      private function initializeSupplyEffects(param1:InitializeSupplyEffectsInPacket) : void
      {
         var _loc2_:Object = JSON.parse(param1.json);
         var _loc3_:IInitialEffectsService = IInitialEffectsService(OSGi.getInstance().getService(IInitialEffectsService));
         for each(var _loc4_ in _loc2_.effects)
         {
            _loc3_.addInitialEffect(_loc4_.userID,_loc4_.itemIndex,_loc4_.durationTime,_loc4_.effectLevel);
         }
      }

      private function initGameClasses() : void
      {
         var hullGameClassVector:Vector.<Long> = new Vector.<Long>();
         hullGameClassVector.push(this.object3DSModel.id);
         hullGameClassVector.push(this.engineModel.id);
         hullGameClassVector.push(this.tankExplosionModel.id);
         hullGameClassVector.push(this.hullSmokeModel.id);
         hullGameClassVector.push(this.hullCommonModel.id);
         hullGameClassVector.push(this.simpleArmorModel.id);
         this.hullGameClass = gameTypeRegistry.createClass(Long.getLong(14025,684260),hullGameClassVector);

         var coloringGameClassVector:Vector.<Long> = new Vector.<Long>();
         coloringGameClassVector.push(this.coloringModel.id);
         this.coloringGameClass = gameTypeRegistry.createClass(Long.getLong(14025,684460),coloringGameClassVector);

         var mapGameClassVector:Vector.<Long> = new Vector.<Long>();
         mapGameClassVector.push(this.battleMapModel.id);
         mapGameClassVector.push(this.mapBonusLightModel.id);
         mapGameClassVector.push(this.teamLightModel.id);
         mapGameClassVector.push(this.colorAdjustModel.id);
         this.mapGameClass = gameTypeRegistry.createClass(Long.getLong(150325,6843660),mapGameClassVector);

         var battlefieldGameClassVector:Vector.<Long> = new Vector.<Long>();
         battlefieldGameClassVector.push(this.battlefieldModel.id);
         battlefieldGameClassVector.push(this.battlefieldBonusesModel.id);
         battlefieldGameClassVector.push(StatisticsModelBase.modelId);
         battlefieldGameClassVector.push(this.inventoryModel.id);
         battlefieldGameClassVector.push(this.battleMinesModel.id);
         this.battlefieldGameClass = gameTypeRegistry.createClass(Long.getLong(150325,6843665),battlefieldGameClassVector);

         var tankGameClassVector:Vector.<Long> = new Vector.<Long>();
         tankGameClassVector.push(this.tankConfigurationModel.id);
         tankGameClassVector.push(this.tankModel.id);
         tankGameClassVector.push(this.suicideModel.id);
         tankGameClassVector.push(this.speedCharacteristicsModel.id);
         tankGameClassVector.push(this.tankTemperatureModel.id);
         tankGameClassVector.push(this.tankReloaderModel.id);
         tankGameClassVector.push(this.tankRankUpEffectModel.id);
         tankGameClassVector.push(this.tankSpawnerModel.id);
         tankGameClassVector.push(this.tankPauseModel.id);
         tankGameClassVector.push(this.tankTurnOverModel.id);
         tankGameClassVector.push(this.damageIndicatorModel.id);
         tankGameClassVector.push(this.battleGearScoreModel.id);
         tankGameClassVector.push(this.tankResistancesModel.id);
         tankGameClassVector.push(this.tankDeviceModel.id);
         tankGameClassVector.push(this.bossStateModel.id);
         this.tankGameClass = gameTypeRegistry.createClass(Long.getLong(150325,6843665),tankGameClassVector);
      }
      
      private function initBattle(param1:InitBattleInPacket) : void
      {
         this.battleSpace = new Space(Long.getLong(10568210,51255591),null,null,false);
         spaceRegistry.addSpace(this.battleSpace);
         this.initGameClasses();

         var jsonObject:Object = JSON.parse(param1.json);
         var mapGraphicDataJsonObject:Object = JSON.parse(jsonObject.map_graphic_data);
         var skyboxJsonObject:Object = JSON.parse(jsonObject.skybox);
         var lightingJsonObject:Object = JSON.parse(jsonObject.lighting);

         var _loc4_:SkyboxSides = new SkyboxSides();
         _loc4_.back = ImageResource(resourceRegistry.getResource(Long.getLong(0,skyboxJsonObject.back)));
         _loc4_.bottom = ImageResource(resourceRegistry.getResource(Long.getLong(0,skyboxJsonObject.bottom)));
         _loc4_.front = ImageResource(resourceRegistry.getResource(Long.getLong(0,skyboxJsonObject.front)));
         _loc4_.left = ImageResource(resourceRegistry.getResource(Long.getLong(0,skyboxJsonObject.left)));
         _loc4_.right = ImageResource(resourceRegistry.getResource(Long.getLong(0,skyboxJsonObject.right)));
         _loc4_.top = ImageResource(resourceRegistry.getResource(Long.getLong(0,skyboxJsonObject.top)));

         var battleMapCC:BattleMapCC = new BattleMapCC();
         battleMapCC.dustParams = new DustParams(
            jsonObject.dustAlpha,
            jsonObject.dustDensity,
            jsonObject.dustFarDistance,
            jsonObject.dustNearDistance,
            MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,jsonObject.dustParticle))),
            jsonObject.dustSize
         );
         battleMapCC.dynamicShadowParams = new DynamicShadowParams(mapGraphicDataJsonObject.shadowAngleX,mapGraphicDataJsonObject.shadowAngleZ,mapGraphicDataJsonObject.lightColor,mapGraphicDataJsonObject.shadowColor);
         battleMapCC.environmentSound = resourceRegistry.getResource(Long.getLong(0,jsonObject.ambientSound)) as SoundResource;
         battleMapCC.fogParams = new FogParams(mapGraphicDataJsonObject.fogAlpha,mapGraphicDataJsonObject.fogColor,mapGraphicDataJsonObject.fogFarLimit,mapGraphicDataJsonObject.fogNearLimit);
         battleMapCC.gravity = mapGraphicDataJsonObject.gravity;
         battleMapCC.mapResource = resourceRegistry.getResource(Long.getLong(0,jsonObject.mapId)) as MapResource;
         battleMapCC.skyBoxRevolutionAxis = new Vector3d(10,3,0);
         battleMapCC.skyBoxRevolutionSpeed = mapGraphicDataJsonObject.skyboxRevolutionSpeed;
         battleMapCC.skyboxSides = _loc4_;
         battleMapCC.ssaoColor = mapGraphicDataJsonObject.ssaoColor

         var mapGameObject:IGameObject = this.battleSpace.createObject(Long.getLong(0,jsonObject.mapId),this.mapGameClass,"Map object");
         Model.object = mapGameObject;
         this.battleMapModel.putInitParams(battleMapCC);
         Model.popObject();


         var bonusColorAdjust:Object = jsonObject.bonusColorAdjust;
         var mapBonusLightCC:MapBonusLightCC = new MapBonusLightCC();
         mapBonusLightCC.hwColorAdjust = new ColorAdjustParams();
         mapBonusLightCC.softColorAdjust = new ColorAdjustParams();
         if(bonusColorAdjust != null)
         {
            mapBonusLightCC.bonusLightIntensity = jsonObject.bonusLightIntensity;
            mapBonusLightCC.hwColorAdjust = new ColorAdjustParams();
            mapBonusLightCC.hwColorAdjust.redOffset = jsonObject.bonusColorAdjust.redOffset;
            mapBonusLightCC.hwColorAdjust.redMultiplier = jsonObject.bonusColorAdjust.redMultiplier;
            mapBonusLightCC.hwColorAdjust.greenOffset = jsonObject.bonusColorAdjust.greenOffset;
            mapBonusLightCC.hwColorAdjust.greenMultiplier = jsonObject.bonusColorAdjust.greenMultiplier;
            mapBonusLightCC.hwColorAdjust.blueOffset = jsonObject.bonusColorAdjust.blueOffset;
            mapBonusLightCC.hwColorAdjust.blueMultiplier = jsonObject.bonusColorAdjust.blueMultiplier;
            mapBonusLightCC.hwColorAdjust.alphaOffset = jsonObject.bonusColorAdjust.alphaOffset;
            mapBonusLightCC.hwColorAdjust.alphaMultiplier = jsonObject.bonusColorAdjust.alphaMultiplier;
            mapBonusLightCC.softColorAdjust = mapBonusLightCC.hwColorAdjust;
         }
         Model.object = mapGameObject;
         this.mapBonusLightModel.putInitParams(mapBonusLightCC);
         Model.popObject();

         var colorAdjustCC:ColorAdjustCC = new ColorAdjustCC();
         colorAdjustCC.frostParamsHW = new ColorAdjustParams(1, 0, 1.5, 100, 1, 80, 1, 20);
         colorAdjustCC.frostParamsSoft = colorAdjustCC.frostParamsHW;
         colorAdjustCC.heatParamsHW = new ColorAdjustParams(1, 0, 0.6, -40, 0.6, -20, 1.5, 40);
         colorAdjustCC.heatParamsSoft = colorAdjustCC.heatParamsHW;

         Model.object = mapGameObject;
         this.colorAdjustModel.putInitParams(colorAdjustCC);
         Model.popObject();

         var teamLightCC:TeamLightCC = new TeamLightCC();
         teamLightCC.lightModes = new Vector.<TeamLightParams>();

         var ctfTeamLightParams:TeamLightParams = new TeamLightParams();
         ctfTeamLightParams.attenuationBegin = lightingJsonObject.ctfLighting.attenuationBegin;
         ctfTeamLightParams.attenuationEnd = lightingJsonObject.ctfLighting.attenuationEnd;
         ctfTeamLightParams.battleMode = BattleMode.CTF;
         ctfTeamLightParams.blueTeam = new TeamLightColorParams(lightingJsonObject.ctfLighting.blueColor.toString(16),lightingJsonObject.ctfLighting.blueColorIntensity);
         ctfTeamLightParams.neutralTeam = new TeamLightColorParams("0xffffff",0);
         ctfTeamLightParams.redTeam = new TeamLightColorParams(lightingJsonObject.ctfLighting.redColor.toString(16),lightingJsonObject.ctfLighting.redColorIntensity);
         teamLightCC.lightModes.push(ctfTeamLightParams);
         
         var cpTeamLightParams:TeamLightParams = new TeamLightParams();
         cpTeamLightParams.attenuationBegin = lightingJsonObject.dominationLighting.attenuationBegin;
         cpTeamLightParams.attenuationEnd = lightingJsonObject.dominationLighting.attenuationEnd;
         cpTeamLightParams.battleMode = BattleMode.CP;
         cpTeamLightParams.blueTeam = new TeamLightColorParams(lightingJsonObject.dominationLighting.bluePointColor.toString(16),lightingJsonObject.dominationLighting.bluePointIntensity);
         cpTeamLightParams.neutralTeam = new TeamLightColorParams(lightingJsonObject.dominationLighting.neutralPointColor.toString(16),lightingJsonObject.dominationLighting.neutralPointIntensity);
         cpTeamLightParams.redTeam = new TeamLightColorParams(lightingJsonObject.dominationLighting.redPointColor.toString(16),lightingJsonObject.dominationLighting.redPointIntensity);
         teamLightCC.lightModes.push(cpTeamLightParams);

         Model.object = mapGameObject;
         this.teamLightModel.putInitParams(teamLightCC);
         Model.popObject();

         var battlefieldBonusesModelCC:BattlefieldBonusesCC = new BattlefieldBonusesCC();
         battlefieldBonusesModelCC.bonusFallSpeed = 150;
         battlefieldBonusesModelCC.bonuses = new Vector.<BonusSpawnData>();

         battlefieldGameObject = this.battleSpace.rootObject; // battlefield object must be space root object
         battlefieldGameObject.gameClass = battlefieldGameClass; 
         Model.object = battlefieldGameObject;
         this.battlefieldBonusesModel.putInitParams(battlefieldBonusesModelCC);
         Model.popObject();

         var inventoryCC:InventoryCC = new InventoryCC();
         inventoryCC.ultimateEnabled = false;

         Model.object = battlefieldGameObject;
         this.inventoryModel.putInitParams(inventoryCC);
         this.inventoryModel.objectLoaded();
         this.inventoryModel.objectLoadedPost();
         Model.popObject();

         var battlefieldModelCC:BattlefieldCC = new BattlefieldCC();
         battlefieldModelCC.active = jsonObject.active;
         battlefieldModelCC.battleId = jsonObject.battleId;
         battlefieldModelCC.battlefieldSounds = new BattlefieldSounds();
         battlefieldModelCC.battlefieldSounds.killSound = resourceRegistry.getResource(Long.getLong(0,jsonObject.tankExplosionSound)) as SoundResource;
         battlefieldModelCC.battlefieldSounds.battleFinishSound = battlefieldModelCC.battlefieldSounds.killSound; // dummy data
         battlefieldModelCC.colorTransformMultiplier = 1;
         battlefieldModelCC.idleKickPeriodMsec = jsonObject.kick_period_ms;
         battlefieldModelCC.map = mapGameObject;

         battlefieldModelCC.mineExplosionLighting = new LightingSFXEntity();
         battlefieldModelCC.mineExplosionLighting.effects = new Vector.<LightingEffectEntity>();
         var explosionLightEffect:LightingEffectEntity = new LightingEffectEntity(
            "explosion",
            new Vector.<LightEffectItem>()
         )
         explosionLightEffect.items.push(new LightEffectItem(300, 0, "0xff0000", 0.5, 0));
         explosionLightEffect.items.push(new LightEffectItem(1, 2, "0xff0000", 0, 500));
         battlefieldModelCC.mineExplosionLighting.effects.push(explosionLightEffect);

         battlefieldModelCC.proBattle = true; // in Tanki Online 2019 non matchmaking battle is pro battle
         battlefieldModelCC.range = new Range(jsonObject.maxRank,jsonObject.minRank);
         battlefieldModelCC.reArmorEnabled = jsonObject.reArmorEnabled;
         battlefieldModelCC.respawnDuration = 3000;
         battlefieldModelCC.shadowMapCorrectionFactor = 0.5;
         //battlefieldModelCC.showAddressLink = param13;
         battlefieldModelCC.spectator = jsonObject.spectator;
         battlefieldModelCC.withoutBonuses = false; // todo: implement without bonuses, if needed
         battlefieldModelCC.withoutDrones = true;
         battlefieldModelCC.withoutSupplies = false; // todo: implement without supplies

         Model.object = battlefieldGameObject;
         this.battlefieldModel.putInitParams(battlefieldModelCC);
         this.battlefieldModel.objectLoaded();
         this.battlefieldModel.objectLoadedPost();
         Model.popObject();

         var explosionTexture:Long = Long.getLong(0,jsonObject.explosionTextureId);
         var shockWaveTexture:Long = Long.getLong(0,jsonObject.shockWaveTextureId);
         var smokeTextureId:Long = Long.getLong(0,jsonObject.smokeTextureId);

         this.tankExplosionCC = new TankExplosionCC(
            MultiframeImageResource(resourceRegistry.getResource(explosionTexture)),
            MultiframeImageResource(resourceRegistry.getResource(shockWaveTexture)),
            MultiframeImageResource(resourceRegistry.getResource(smokeTextureId))
         );

         this.hullSmokeCC = new HullSmokeCC();
         this.hullSmokeCC.alpha = jsonObject.dustAlpha;
         this.hullSmokeCC.density = jsonObject.dustDensity;
         this.hullSmokeCC.enabled = true;
         this.hullSmokeCC.fadeTime = 1000;
         this.hullSmokeCC.farDistance = jsonObject.dustFarDistance;
         this.hullSmokeCC.nearDistance = jsonObject.dustNearDistance;
         this.hullSmokeCC.particle = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,jsonObject.smokeTextureId)));
         this.hullSmokeCC.size = jsonObject.dustSize;
      }
      
      private function createTank(param1:CreateTankInPacket) : void
      {
         var jsonObject:Object = JSON.parse(param1.json);
         var partsJsonObject:Object = JSON.parse(jsonObject.partsObject);
         var sfxDataJsonObject:Object = JSON.parse(jsonObject.sfxData);

         var engineCC:EngineCC = new EngineCC();
         engineCC.engineIdleSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,partsJsonObject.engineIdleSound)));
         engineCC.engineStartMovingSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,partsJsonObject.engineStartMovingSound)));
         engineCC.engineMovingSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,partsJsonObject.engineMovingSound)));
         //_loc2_.turretRotationSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,_loc7_.turretRotationSound)));

         var coloringCC:ColoringCC = new ColoringCC();
         if(resourceRegistry.getResource(Long.getLong(0,jsonObject.colormap_id)) is MultiframeImageResource)
         {
            coloringCC.animatedColoring = MultiframeImageResource(resourceRegistry.getResource(Long.getLong(0,jsonObject.colormap_id)));
         }
         else
         {
            coloringCC.coloring = ImageResource(resourceRegistry.getResource(Long.getLong(0,jsonObject.colormap_id)));
         }

         var hullObject3DCC:Object3DSCC = new Object3DSCC();
         hullObject3DCC.resourceId = Long.getLong(0,jsonObject.hullResource);

         var turretObject3DCC:Object3DSCC = new Object3DSCC();
         turretObject3DCC.resourceId = Long.getLong(0,jsonObject.turretResource);

         var hullGameObject:IGameObject = this.battleSpace.createObject(IdTool.getNextId(),this.hullGameClass,jsonObject.hull_id);
         var turretGameObject:IGameObject = this.battleSpace.createObject(IdTool.getNextId(),this.getTurretGameClass(jsonObject.turret_id),jsonObject.turret_id);
         var coloringGameObject:IGameObject = this.battleSpace.createObject(IdTool.getNextId(),this.coloringGameClass,jsonObject.colormap_id);

         var hullCommonCC:HullCommonCC = new HullCommonCC();
         hullCommonCC.damping = jsonObject.dampingCoeff;
         hullCommonCC.mass = jsonObject.mass;
         hullCommonCC.deadColoring = ImageResource(resourceRegistry.getResource(Long.getLong(0,jsonObject.deadColoring)));
         hullCommonCC.lightingSFXEntity = new LightingSFXEntity();
         hullCommonCC.lightingSFXEntity.effects = new Vector.<LightingEffectEntity>();
         var explosionLightEffect:LightingEffectEntity = new LightingEffectEntity(
            "explosion",
            new Vector.<LightEffectItem>()
         )
         explosionLightEffect.items.push(new LightEffectItem(1, 2, "0xCCA538", 0, 0));
         explosionLightEffect.items.push(new LightEffectItem(500, 1500, "0xCCA538", 1.2, 100));
         explosionLightEffect.items.push(new LightEffectItem(1, 2, "0xCCA538", 0, 1200));
         hullCommonCC.lightingSFXEntity.effects.push(explosionLightEffect);

         var simpleArmorCC:SimpleArmorCC = new SimpleArmorCC();
         simpleArmorCC.maxHealth = jsonObject.health;
         
         // Initialize hull models
         Model.object = hullGameObject;
         this.tankExplosionModel.putInitParams(this.tankExplosionCC);
         this.tankExplosionModel.objectLoaded();

         this.object3DSModel.putInitParams(hullObject3DCC);
         this.engineModel.putInitParams(engineCC);
         this.hullCommonModel.putInitParams(hullCommonCC);
         this.simpleArmorModel.putInitParams(simpleArmorCC);
         this.hullSmokeModel.putInitParams(this.hullSmokeCC);
         Model.popObject();

         var weaponCommonCC:WeaponCommonCC = new WeaponCommonCC();
         weaponCommonCC.highlightingDistance = 100000;
         weaponCommonCC.impactForce = jsonObject.impact_force;
         weaponCommonCC.kickback = jsonObject.kickback;
         weaponCommonCC.turretRotationAcceleration = jsonObject.turretTurnAcceleration;
         weaponCommonCC.turretRotationSound = resourceRegistry.getResource(Long.getLong(0,partsJsonObject.turretRotationSound)) as SoundResource;
         weaponCommonCC.turretRotationSpeed = jsonObject.turret_turn_speed;
         
         var rotatingTurretCC:RotatingTurretCC = new RotatingTurretCC();
         rotatingTurretCC.angle = 0;
         rotatingTurretCC.control = 0;

         WeaponSfxModelUtil.addSfxModelsForWeapon(jsonObject.turret_id, sfxDataJsonObject, turretGameObject);
         WeaponModelUtil.addModelsForWeapon(turretGameObject, jsonObject.turret_id);

         // Initialize turret models
         Model.object = turretGameObject;
         this.object3DSModel.putInitParams(turretObject3DCC);
         this.weaponCommonModel.putInitParams(weaponCommonCC);
         this.rotatingTurretModel.putInitParams(rotatingTurretCC);
         this.rotatingTurretModel.objectLoaded();
         Model.popObject();

         Model.object = coloringGameObject;
         this.coloringModel.putInitParams(coloringCC);
         Model.popObject();

         var tankCC:TankCC = new TankCC();
         tankCC.health = jsonObject.health;
         tankCC.local = jsonObject.nickname == this.userPropertiesService.userId;
         tankCC.logicState = EnumUtils.stringToTankLogicState(jsonObject.state);
         tankCC.movementDistanceBorderUntilTankCorrection = 2000;
         tankCC.movementTimeoutUntilTankCorrection = 4000;
         tankCC.tankState = new TankState();
         tankCC.tankState.angularVelocity = new Vector3d();
         tankCC.tankState.chassisControl = 0;
         tankCC.tankState.linearVelocity = new Vector3d();
         tankCC.tankState.orientation = EnumUtils.objectToVector3d(jsonObject.orientation);
         tankCC.tankState.position = EnumUtils.objectToVector3d(jsonObject.position);
         tankCC.team = EnumUtils.stringToBattleTeam(jsonObject.team_type);
         tankCC.userId = jsonObject.nickname;
         
         var tankConfigurationCC:TankConfigurationCC = new TankConfigurationCC();
         tankConfigurationCC.coloringId = coloringGameObject.id;
         tankConfigurationCC.hullId = hullGameObject.id;
         tankConfigurationCC.weaponId = turretGameObject.id;
         
         var suicideCC:SuicideCC = new SuicideCC();
         suicideCC.suicideDelayMS = 10000;
         
         var speedcharacteristicsCC:SpeedCharacteristicsCC = new SpeedCharacteristicsCC();
         speedcharacteristicsCC.baseAcceleration = jsonObject.acceleration;
         speedcharacteristicsCC.baseSpeed = jsonObject.maxSpeed;
         speedcharacteristicsCC.baseTurnSpeed = jsonObject.maxTurnSpeed;
         speedcharacteristicsCC.baseTurretRotationSpeed = jsonObject.turret_turn_speed;
         speedcharacteristicsCC.currentAcceleration = jsonObject.acceleration;
         speedcharacteristicsCC.currentSpeed = jsonObject.maxSpeed;
         speedcharacteristicsCC.currentTurnSpeed = jsonObject.maxTurnSpeed;
         speedcharacteristicsCC.currentTurretRotationSpeed = jsonObject.turret_turn_speed;
         speedcharacteristicsCC.reverseAcceleration = jsonObject.reverseAcceleration;
         speedcharacteristicsCC.reverseTurnAcceleration = jsonObject.reverseTurnAcceleration;
         speedcharacteristicsCC.sideAcceleration = jsonObject.sideAcceleration;
         speedcharacteristicsCC.turnAcceleration = jsonObject.turnAcceleration;
         
         var tankRankUpEffectCC:TankRankUpEffectCC = new TankRankUpEffectCC();
         tankRankUpEffectCC.rankUpSound = SoundResource(resourceRegistry.getResource(Long.getLong(0,jsonObject.levelUpSound)));

         var tankSpawnerCC:TankSpawnerCC = new TankSpawnerCC();
         tankSpawnerCC.incarnationId = jsonObject.incarnation;
         
         var battleGearScoreCC:BattleGearScoreCC = new BattleGearScoreCC();
         battleGearScoreCC.score = 0;

         var tankResistancesCC:TankResistancesCC = new TankResistancesCC();
         tankResistancesCC.resistances = new Vector.<TankResistance>();
         
         var tankDeviceCC:TankDeviceCC = new TankDeviceCC();

         var bossStateCC:BossStateCC = new BossStateCC();
         bossStateCC.enabled = false;

         var tankGameObject:IGameObject = this.battleSpace.createObject(IdTool.getNextId(),this.tankGameClass,jsonObject.nickname);
         Model.object = tankGameObject;
         this.tankConfigurationModel.putInitParams(tankConfigurationCC);
         this.suicideModel.putInitParams(suicideCC);
         this.speedCharacteristicsModel.putInitParams(speedcharacteristicsCC);

         this.tankRankUpEffectModel.putInitParams(tankRankUpEffectCC);
         this.tankRankUpEffectModel.objectLoaded();

         this.battleGearScoreModel.putInitParams(battleGearScoreCC);

         this.tankSpawnerModel.putInitParams(tankSpawnerCC);

         this.tankResistancesModel.putInitParams(tankResistancesCC);

         this.tankDeviceModel.putInitParams(tankDeviceCC);

         this.bossStateModel.putInitParams(bossStateCC);

         this.tankModel.putInitParams(tankCC);
         this.tankModel.objectLoaded();

         this.tankSpawnerModel.objectLoaded();
         this.tankResistancesModel.objectLoadedPost();
         Model.popObject();
         
         TankNameGameObjectMapper.addMapping(jsonObject.nickname, tankGameObject);
      }

      // Turret GameClass will be modified by WeaponModelUtil and WeaponSfxModelUtil, so it must be unique for each turret type
      private function getTurretGameClass(turretId:String):GameClass
      {
         var weaponName:String = turretId.split("_")[0];
         if(this.turretGameClassDictionary[weaponName] == null)
         {
            var turretGameClassVector:Vector.<Long> = new Vector.<Long>();
            turretGameClassVector.push(this.object3DSModel.id);
            turretGameClassVector.push(this.weaponCommonModel.id);
            turretGameClassVector.push(this.rotatingTurretModel.id);
            this.turretGameClassDictionary[weaponName] = gameTypeRegistry.createClass(IdTool.getNextId(),turretGameClassVector);
         }
         return this.turretGameClassDictionary[weaponName];
      }

      //private function initBonusBoxes(param1:InitBonusBoxesInPacket) : void
      //{
      //   var _loc6_:* = undefined;
      //   var _loc3_:BonusCommonCC = null;
      //   var _loc4_:IGameObject = null;
      //   var _loc2_:BonusCommonModel = BonusCommonModel(modelRegistry.getModel(Long.getLong(2087671478,1672369054)));
      //   var _loc5_:Object = JSON.parse(param1.json);
      //   for each(_loc6_ in _loc5_.bonuses)
      //   {
//
      //      _loc3_ = new BonusCommonCC();
      //      _loc4_ = CoreUtils.createObject(newname_1931__END.strToId(_loc6_.id),newname_1931__END.strToId("battle_bonus"),newname_1931__END.strToId("battle"));
      //      var _loc10_:* = _loc4_;
      //      var _loc7_:Model = Model;
      //      platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.newname_1693__END;
      //      platform.client.fp10.core.model.impl.Model.newname_1693__END = _loc10_;
      //      _loc3_.newname_7925__END = Tanks3DSResource(newname_122__END.getResource(Long.getLong(0,_loc6_.resourceId)));
      //      _loc3_.newname_7926__END = ImageResource(newname_122__END.getResource(Long.getLong(0,_loc5_.cordResource)));
      //      _loc3_.newname_7927__END = _loc6_.lifeTimeMs;
      //      _loc3_.newname_7928__END = Tanks3DSResource(newname_122__END.getResource(Long.getLong(0,_loc5_.parachuteInnerResource)));
      //      _loc3_.newname_7929__END = Tanks3DSResource(newname_122__END.getResource(Long.getLong(0,_loc5_.parachuteResource)));
      //      _loc3_.newname_7930__END = SoundResource(newname_122__END.getResource(Long.getLong(0,_loc5_.pickupSoundResource)));
      //      _loc2_.putInitParams(_loc3_);
      //      this.bonusLightModel.putInitParams(new BonusLightCC(_loc6_.lighting.attenuationBegin,_loc6_.lighting.attenuationEnd,_loc6_.lighting.intensity,_loc6_.lighting.color));
      //      _loc2_.objectLoaded();
      //      Model.popObject();
      //   }
      //}

      //private function addBonusBoxes(param1:AddBonusBoxesInPacket) : void
      //{
      //   var _loc5_:Object = null;
      //   var _loc3_:Object = null;
      //   var _loc2_:* = JSON.parse(param1.json);
      //   var _loc4_:Array = [];
      //   for each(_loc5_ in _loc2_)
      //   {
      //      _loc3_ = {};
      //      _loc3_.id = newname_1931__END.strToId(_loc5_.id);
      //      _loc3_.position = new Vector3d(_loc5_.position.x,_loc5_.position.y,_loc5_.position.z);
      //      _loc3_.timeFromAppearing = _loc5_.timeFromAppearing;
      //      _loc3_.timeLife = _loc5_.timeLife;
      //      _loc3_.object = CoreUtils.getObject(newname_1931__END.strToId(_loc5_.id.split("#")[0]),newname_1931__END.strToId("battle_bonus"),newname_1931__END.strToId("battle"));
      //      _loc4_.push(_loc3_);
      //   }
      //   this.battlefieldModel.initBonuses(_loc4_);
      //}
      //
      //private function addBonus(param1:AddBonusBoxInPacket) : void
      //{
      //   this.battlefieldModel.addBonus(CoreUtils.getObject(newname_1931__END.strToId(param1.bonusId.split("#")[0]),newname_1931__END.strToId("battle_bonus"),newname_1931__END.strToId("battle")),newname_1931__END.strToId(param1.bonusId),param1.position);
      //}
      //
      //private function removeBonus(param1:RemoveBonusBoxInPacket) : void
      //{
      //   this.battlefieldModel.removeBonus(newname_1931__END.strToId(param1.bonusId));
      //}
      //
      //private function bonusTake(param1:TakeBonusBoxInPacket) : void
      //{
      //   this.battlefieldModel.bonusTaken(newname_1931__END.strToId(param1.bonusId));
      //}

      private function unloadBattle() : void
      {
         lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH_POST,this.unloadBattleSpace);
      }

      private function unloadBattleSpace(param1:LobbyLayoutServiceEvent = null) : void
      {
         lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH_POST,this.unloadBattleSpace);
         var gameObjects:Vector.<IGameObject> = this.battleSpace.objects.concat();
         for each (var gameObject:IGameObject in gameObjects)
         {
            if(gameObject.hasModel(TankModel))
            {
               TankPacketHandler.unloadTankGameObject(gameObject);
            }
         }

         gameObjects = this.battleSpace.objects.concat();
         for each (var gameObject1:IGameObject in gameObjects)
         {
            this.battleSpace.destroyObject(gameObject1.id);
         }

         spaceRegistry.removeSpace(this.battleSpace);
         TankNameGameObjectMapper.clearMappings();

         gameTypeRegistry.destroyClass(Long.getLong(14025,684260));
         gameTypeRegistry.destroyClass(Long.getLong(14025,684460));
         gameTypeRegistry.destroyClass(Long.getLong(150325,6843660));
         gameTypeRegistry.destroyClass(Long.getLong(150325,6843665));
         gameTypeRegistry.destroyClass(Long.getLong(150325,6843665));
         
         for each (var key:String in this.turretGameClassDictionary)
         {
            gameTypeRegistry.destroyClass(this.turretGameClassDictionary[key]);
         }
      }
   }
}

