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

      private var userPropertiesService:IUserPropertiesService;
      private var lightingEffectsService:ILightingEffectsService;

      private var battleSpace:ISpace;

      private var tankGameClass:GameClass;
      private var turretGameClass:GameClass;
      private var mapGameClass:GameClass;
      private var battlefieldGameClass:GameClass;

      static public var battlefieldGameObject:IGameObject;

      private var tankExplosionCC:TankExplosionCC;

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

         this.userPropertiesService = IUserPropertiesService(OSGi.getInstance().getService(IUserPropertiesService));
         this.tankUsersRegistry = TankUsersRegistry(OSGi.getInstance().getService(TankUsersRegistry));
         this.lightingEffectsService = ILightingEffectsService(OSGi.getInstance().getService(ILightingEffectsService));

         var tankGameClassVector:Vector.<Long> = new Vector.<Long>();
         tankGameClassVector.push(this.coloringModel.id);
         tankGameClassVector.push(this.object3DSModel.id);
         tankGameClassVector.push(this.engineModel.id);
         this.tankGameClass = gameTypeRegistry.createClass(Long.getLong(14025,684260),tankGameClassVector);

         var turretGameClassVector:Vector.<Long> = new Vector.<Long>();
         turretGameClassVector.push(this.coloringModel.id);
         turretGameClassVector.push(this.object3DSModel.id);
         turretGameClassVector.push(this.bcsHModel.id);
         this.turretGameClass = gameTypeRegistry.createClass(Long.getLong(55443,68234),turretGameClassVector);

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
         this.battlefieldGameClass = gameTypeRegistry.createClass(Long.getLong(150325,6843665),battlefieldGameClassVector);

         this.battleSpace = spaceRegistry.getSpace(Long.getLong(10568210,51255591));
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
               //this.createTank(param1 as CreateTankInPacket);
               break;
            case RemoveBonusBoxInPacket.id:
               //this.removeBonus(param1 as RemoveBonusBoxInPacket);
               break;
            case AddBonusBoxInPacket.id:
               //this.addBonus(param1 as AddBonusBoxInPacket);
               break;
            case UnloadBattleSpaceInPacket.id:
               //this.unloadBattleSpace();
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
      
      private function initBattle(param1:InitBattleInPacket) : void
      {
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
         colorAdjustCC.frostParamsHW = new ColorAdjustParams(1,1,1.5,1,20,80,100,0);
         colorAdjustCC.frostParamsSoft = colorAdjustCC.frostParamsHW;
         colorAdjustCC.heatParamsHW = new ColorAdjustParams(1,0.75,0.6,1,-16,-66,-66);
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

	      battlefieldGameObject = battleSpace.createObject(Long.getLong(47926,64811),this.battlefieldGameClass,"Battlefield object");
         Model.object = battlefieldGameObject;
         this.battlefieldBonusesModel.putInitParams(battlefieldBonusesModelCC);
         Model.popObject();

         var battlefieldModelCC:BattlefieldCC = new BattlefieldCC();
         battlefieldModelCC.active = jsonObject.active;
         battlefieldModelCC.battleId = jsonObject.battleId;
         battlefieldModelCC.battlefieldSounds = new BattlefieldSounds();
         battlefieldModelCC.battlefieldSounds.killSound = resourceRegistry.getResource(Long.getLong(0,jsonObject.tankExplosionSound)) as SoundResource;
         battlefieldModelCC.battlefieldSounds.battleFinishSound = battlefieldModelCC.battlefieldSounds.killSound; // dummy data
         battlefieldModelCC.colorTransformMultiplier = 0.5;
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
         battlefieldModelCC.spectator = true;//jsonObject.spectator;
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
      }
      
      //private function createTank(param1:CreateTankInPacket) : void
      //{
      //   var _loc9_:TankSpecification = null;
      //   var _loc4_:TankState = null;
      //   var _loc8_:TankRankUpEffectCC = null;
      //   var _loc6_:Object = JSON.parse(param1.json);
      //   var _loc7_:Object = JSON.parse(_loc6_.partsObject);
      //   var _loc13_:ColoringCC = new ColoringCC();
      //   var _loc11_:Object3DSCC = new Object3DSCC();
      //   var _loc12_:Object3DSCC = new Object3DSCC();
      //   var _loc2_:EngineCC = new EngineCC();
      //   _loc2_.newname_2429__END = SoundResource(newname_122__END.getResource(Long.getLong(0,_loc7_.engineIdleSound)));
      //   _loc2_.newname_2430__END = SoundResource(newname_122__END.getResource(Long.getLong(0,_loc7_.engineStartMovingSound)));
      //   _loc2_.newname_2431__END = SoundResource(newname_122__END.getResource(Long.getLong(0,_loc7_.engineMovingSound)));
      //   _loc2_.newname_2432__END = SoundResource(newname_122__END.getResource(Long.getLong(0,_loc7_.turretRotationSound)));
      //   if(newname_122__END.getResource(Long.getLong(0,_loc6_.colormap_id)) is MultiframeImageResource)
      //   {
      //      _loc13_.animatedColoring = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,_loc6_.colormap_id)));
      //   }
      //   else
      //   {
      //      _loc13_.coloring = ImageResource(newname_122__END.getResource(Long.getLong(0,_loc6_.colormap_id)));
      //   }
      //   _loc12_.resourceId = Long.getLong(0,_loc6_.hullResource);
      //   _loc11_.resourceId = Long.getLong(0,_loc6_.turretResource);
      //   var _loc10_:TankParts = new TankParts();
      //   _loc10_.newname_2428__END = new GameObject(Long.getLong(0,_loc6_.hullResource),this.tankGameClass,_loc6_.hull_id,null);
      //   _loc10_.newname_2372__END = new GameObject(Long.getLong(0,_loc6_.turretResource),this.tankGameClass,_loc6_.turret_id,null);
      //   _loc10_.newname_2459__END = new GameObject(Long.getLong(0,_loc6_.colormap_id),this.tankGameClass,_loc6_.colormap_id,null);
      //   var _loc18_:* = _loc10_.newname_2428__END;
      //   var _loc14_:Model = Model;
      //   platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.newname_1693__END;
      //   platform.client.fp10.core.model.impl.Model.newname_1693__END = _loc18_;
      //   this.object3DSModel.putInitParams(_loc12_);
      //   this.engineModel.putInitParams(_loc2_);
      //   Model.popObject();
      //   var _loc19_:* = _loc10_.newname_2372__END;
      //   var _loc15_:Model = Model;
      //   platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.newname_1693__END;
      //   platform.client.fp10.core.model.impl.Model.newname_1693__END = _loc19_;
      //   this.object3DSModel.putInitParams(_loc11_);
      //   Model.popObject();
      //   var _loc20_:* = _loc10_.newname_2459__END;
      //   var _loc16_:Model = Model;
      //   platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.newname_1693__END;
      //   platform.client.fp10.core.model.impl.Model.newname_1693__END = _loc20_;
      //   this.coloringModel.putInitParams(_loc13_);
      //   Model.popObject();
      //   _loc9_ = new TankSpecification();
      //   _loc9_.speed = _loc6_.maxSpeed;
      //   _loc9_.newname_1012__END = _loc6_.maxTurnSpeed;
      //   _loc9_.newname_2450__END = _loc6_.turret_turn_speed;
      //   _loc9_.acceleration = _loc6_.acceleration;
      //   _loc9_.dampingCoeff = _loc6_.dampingCoeff;
      //   _loc9_.reverseAcceleration = _loc6_.reverseAcceleration;
      //   _loc9_.reverseTurnAcceleration = _loc6_.reverseTurnAcceleration;
      //   _loc9_.sideAcceleration = _loc6_.sideAcceleration;
      //   _loc9_.turnAcceleration = _loc6_.turnAcceleration;
      //   _loc9_.turretTurnAcceleration = _loc6_.turretTurnAcceleration;
      //   if(!_loc6_.state_null)
      //   {
      //      _loc4_ = new TankState();
      //      _loc4_.orientation = newname_2263__END.newname_7923__END(_loc6_.orientation);
      //      _loc4_.position = newname_2263__END.newname_7923__END(_loc6_.position);
      //      _loc4_.turretAngle = _loc6_.turretAngle;
      //      _loc4_.turretControl = _loc6_.turretControl;
      //   }
      //   var _loc3_:ClientTank = new ClientTank();
      //   _loc3_.health = _loc6_.health;
      //   _loc3_.IncarnationID = _loc6_.incarnation;
      //   _loc3_.self = _loc6_.nickname == this.userPropertiesService.userId;
      //   _loc3_.newname_923__END = newname_2263__END.newname_7924__END(_loc6_.state);
      //   _loc3_.newname_2371__END = _loc9_;
      //   _loc3_.newname_2442__END = _loc4_;
      //   _loc3_.teamType = _loc6_.team_type == "NONE" ? BattleTeam.newname_871__END : (_loc6_.team_type == "RED" ? BattleTeam.newname_701__END : BattleTeam.newname_700__END);
      //   var _loc5_:ClientObject = new ClientObject(_loc6_.nickname);
      //   this.tankModel.initObject(_loc5_,_loc6_.mass,_loc10_,_loc6_.impact_force,_loc6_.kickback,_loc6_.turretTurnAcceleration,_loc6_.turret_turn_speed,_loc6_.nickname);
      //   WeaponsManager.newname_5980__END(_loc5_,_loc6_.turret_id,JSON.parse(_loc6_.sfxData),_loc10_.newname_2372__END);
      //   this.tankModel.initTank(_loc5_,_loc3_,_loc10_,ImageResource(newname_122__END.getResource(Long.getLong(0,_loc6_.deadColoring))));
      //   var _loc21_:* = null;
      //   var _loc17_:Model = Model;
      //   platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.newname_1693__END;
      //   platform.client.fp10.core.model.impl.Model.newname_1693__END = _loc21_;
      //   if(this.tankRankUpEffectModel.newname_1637__END() == null)
      //   {
      //      _loc8_ = new TankRankUpEffectCC(ImageResource(newname_122__END.getResource(Long.getLong(0,_loc6_.beamTexture))),ImageResource(newname_122__END.getResource(Long.getLong(0,_loc6_.waveTexture))),ImageResource(newname_122__END.getResource(Long.getLong(0,_loc6_.sparkTexture))),SoundResource(newname_122__END.getResource(Long.getLong(0,_loc6_.levelUpSound))));
      //      this.tankRankUpEffectModel.putInitParams(_loc8_);
      //   }
      //   this.tankRankUpEffectModel.objectLoaded();
      //   Model.popObject();
      //}

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
      //
      //private function unloadBattleSpace() : void
      //{
      //   var _loc5_:BonusCommonModel = BonusCommonModel(modelRegistry.getModel(Long.getLong(2087671478,1672369054)));
      //   var _loc1_:TankModel = TankModel(OSGi.getInstance().getService(LocalTankInfoService));
      //   for each(var _loc7_ in this.tankUsersRegistry.getUsers())
      //   {
      //      _loc1_.objectUnloaded(_loc7_);
      //      this.tankRankUpEffectModel.objectUnloaded();
      //   }
      //   BonusRegionsModel(modelRegistry.getModel(Long.getLong(1214265883,963276324))).objectUnloaded();
      //   StatisticsModel(OSGi.getInstance().getService(BattlefieldGUI)).objectUnloaded();
      //   this.battleDMModel.objectUnloaded();
      //   this.battleTDMModel.objectUnloaded();
      //   ObjectUnloadListener(OSGi.getInstance().getService(IClientUserInfo)).objectUnloaded();
      //   OSGi.getInstance().unregisterService(IClientUserInfo);
      //   ChatModel(modelRegistry.getModel(Long.getLong(1896886505,1439133662))).objectUnloaded();
      //   WeaponsManager.destroy();
      //   var _loc2_:CaptureTheFlagModel = OSGi.getInstance().getService(ICTFModel) as CaptureTheFlagModel;
      //   if(_loc2_ != null)
      //   {
      //      _loc2_.objectUnloaded();
      //      OSGi.getInstance().unregisterService(ICTFModel);
      //   }
      //   var _loc3_:ControlPointsModel = OSGi.getInstance().getService(IDominationModel) as ControlPointsModel;
      //   if(_loc3_ != null)
      //   {
      //      _loc3_.objectUnloaded();
      //      OSGi.getInstance().unregisterService(IDominationModel);
      //   }
      //   var _loc4_:AssaultModel = OSGi.getInstance().getService(newname_1807__END) as AssaultModel;
      //   if(_loc4_ != null)
      //   {
      //      _loc4_.objectUnloaded();
      //      OSGi.getInstance().unregisterService(newname_1807__END);
      //   }
      //   var _loc6_:InventoryModel = InventoryModel(modelRegistry.getModel(Long.getLong(1500686585,-1760437566)));
      //   _loc6_.objectUnloaded();
      //   this.battleMinesModel.objectUnloaded();
      //   this.tankExplosionModel.objectUnloaded();
      //   this.battlefieldModel.objectUnloaded();
      //   CoreUtils.unloadSpace(newname_1931__END.strToId("battle"));
      //}
   }
}

