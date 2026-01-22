package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.tanks.models.tank.rankup.TankRankUpEffectModel;
   import alternativa.types.Long;
   import alternativa.tanks.models.tank.TankModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battlefield.models.user.tank.TankModelBase;
   import projects.tanks.client.battlefield.models.tankparts.armor.rankup.TankRankUpEffectModelBase;
   import platform.client.fp10.core.type.IGameObject;
   import utils.TankNameGameObjectMapper;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.battlefield.types.DamageType;
   import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
   import alternativa.tanks.models.tank.configuration.TankConfiguration;
   import alternativa.tanks.models.weapon.turret.RotatingTurretModel;
   import projects.tanks.client.battlefield.models.tankparts.weapon.turret.IRotatingTurretModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import alternativa.osgi.OSGi;
   import projects.tanks.client.battlefield.models.user.spawn.ITankSpawnerModelBase;
   import projects.tanks.client.battlefield.models.user.temperature.ITankTemperatureModelBase;
   import projects.tanks.client.battlefield.models.user.speedcharacteristics.ISpeedCharacteristicsModelBase;
   import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristicsModel;
   import projects.tanks.client.battlefield.models.user.speedcharacteristics.SpeedCharacteristicsModelBase;
   import alternativa.tanks.models.tank.temperature.TankTemperatureModel;
   import projects.tanks.client.battlefield.models.user.temperature.TankTemperatureModelBase;
   import alternativa.tanks.models.tank.spawn.TankSpawnerModel;
   import projects.tanks.client.battlefield.models.user.spawn.TankSpawnerModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.turret.RotatingTurretModelBase;
   import scpacker.utils.CoreUtils;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
   
   public class TankPacketHandler extends AbstractPacketHandler
   {
      private var tankModel:TankModel;
      private var tankRankUpEffectModel:TankRankUpEffectModel;
      private var speedCharacteristicsModel:SpeedCharacteristicsModel;
      private var tankTemperatureModel:TankTemperatureModel;
      private var tankSpawnerModel:TankSpawnerModel;
      private var rotatingTurretModel:RotatingTurretModel;

      private var userPropertiesService:IUserPropertiesService;
      
      public function TankPacketHandler()
      {
         super();
         this.id = 39;

         this.tankModel = TankModel(modelRegistry.getModel(TankModelBase.modelId));
         this.tankRankUpEffectModel = TankRankUpEffectModel(modelRegistry.getModel(TankRankUpEffectModelBase.modelId));
         this.speedCharacteristicsModel = SpeedCharacteristicsModel(modelRegistry.getModel(SpeedCharacteristicsModelBase.modelId));
         this.tankTemperatureModel = TankTemperatureModel(modelRegistry.getModel(TankTemperatureModelBase.modelId));
         this.tankSpawnerModel = TankSpawnerModel(modelRegistry.getModel(TankSpawnerModelBase.modelId));
         this.rotatingTurretModel = RotatingTurretModel(modelRegistry.getModel(RotatingTurretModelBase.modelId));

         this.userPropertiesService = IUserPropertiesService(OSGi.getInstance().getService(IUserPropertiesService));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ActivateTankInPacket.id:
               this.activateTank(param1 as ActivateTankInPacket);
               break;
            case ActivateEffectInPacket.id:
               this.activateEffect(param1 as ActivateEffectInPacket);
               break;
            case StopEffectInPacket.id:
               this.stopEffect(param1 as StopEffectInPacket);
               break;
            case KillTankInPacket.id:
               this.killTank(param1 as KillTankInPacket);
               break;
            case MoveAndSetTurretStateInPacket.id:
               this.moveAndSetTurretState(param1 as MoveAndSetTurretStateInPacket);
               break;
            case MoveTankInPacket.id:
               this.move(param1 as MoveTankInPacket);
               break;
            case MovementControlInPacket.id:
               this.movementControl(param1 as MovementControlInPacket);
               break;
            case PrepareToSpawnInPacket.id:
               this.prepareToSpawn(param1 as PrepareToSpawnInPacket);
               break;
            case RotateTurretInPacket.id:
               this.rotateTurret(param1 as RotateTurretInPacket);
               break;
            case SetTankHealthInPacket.id:
               this.setHealth(param1 as SetTankHealthInPacket);
               break;
            case SetSpecificationInPacket.id:
               this.setSpecification(param1 as SetSpecificationInPacket);
               break;
            case SetTankTemperatureInPacket.id:
               this.setTemperature(param1 as SetTankTemperatureInPacket);
               break;
            case SpawnTankInPacket.id:
               this.spawn(param1 as SpawnTankInPacket);
               break;
            case UnloadTankInPacket.id:
               this.unloadTank(param1 as UnloadTankInPacket);
         }
      }
      
      private function activateTank(param1:ActivateTankInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankModel.activateTank();
            Model.popObject();
         }
      }
      
      private function killTank(param1:KillTankInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankModel.kill(param1.killer,param1.delay, DamageType.SMOKY);
            if(!this.tankModel.isLocal())
            {
               this.tankModel.deathConfirmed();
            }
            Model.popObject();
         }
      }
      
      private function moveAndSetTurretState(param1:MoveAndSetTurretStateInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankModel.moveAndSetTurretState(param1.movement,param1.turretDirection);
            Model.popObject();
         }
      }
      
      private function move(param1:MoveTankInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankModel.move(param1.movement);
            Model.popObject();
         }
      }
      
      private function movementControl(param1:MovementControlInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankModel.movementControl(param1.control);
            Model.popObject();
         }
      }
      
      private function prepareToSpawn(param1:PrepareToSpawnInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(this.userPropertiesService.userId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankSpawnerModel.prepareToSpawn(param1.position,param1.orientation);
            Model.popObject();
         }
      }
      
      private function rotateTurret(param1:RotateTurretInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            var turretGameObject:IGameObject = TankConfiguration(tankGameObject.adapt(TankConfiguration)).getTurretObject();
            Model.popObject();

            Model.object = turretGameObject;
            this.rotatingTurretModel.rotate(param1.turretRotation);
            Model.popObject();
         }
      }
      
      private function setHealth(param1:SetTankHealthInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankModel.setHealth(param1.health);
            Model.popObject();
         }
      }
      
      private function spawn(param1:SpawnTankInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankSpawnerModel.spawn(param1.team,param1.position,param1.orientation,param1.health,param1.incarnationId);
            Model.popObject();
         }
      }
      
      private function setTemperature(param1:SetTankTemperatureInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.tankTemperatureModel.setTemperature(param1.temperature);
            Model.popObject();
         }
      }
      
      private function setSpecification(param1:SetSpecificationInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            this.speedCharacteristicsModel.setSpecification(param1.maxSpeed,param1.maxTurnSpeed,param1.maxTurretRotationSpeed,param1.acceleration,param1.specificationId);
            Model.popObject();
         }
      }
      
      private function unloadTank(param1:UnloadTankInPacket) : void
      {
         // todo: remove effects when tank is unloaded
         this.tankRankUpEffectModel.objectUnloaded();
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            unloadTankGameObject(tankGameObject);
         }
      }
      
      public static function unloadTankGameObject(tankGameObject:IGameObject) : void
      {
         Model.object = tankGameObject;

         var tankConfiguration:TankConfiguration = TankConfiguration(tankGameObject.adapt(TankConfiguration));
         var coloringGameObject:IGameObject = tankConfiguration.getColoringObject();
         var hullGameObject:IGameObject = tankConfiguration.getHullObject();
         var turretGameObject:IGameObject = tankConfiguration.getTurretObject();

         tankGameObject.space.destroyObject(tankGameObject.id);
         coloringGameObject.space.destroyObject(coloringGameObject.id);
         hullGameObject.space.destroyObject(hullGameObject.id);
         turretGameObject.space.destroyObject(turretGameObject.id);

         Model.popObject();
         TankNameGameObjectMapper.removeMapping(tankGameObject.name);
      }
      
      private function activateEffect(param1:ActivateEffectInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            // todo: create new game object for effect
            //this.tankModel.onEffectActivated(param1.effectId,param1.duration,param1.activeAfterDeath,param1.effectLevel);
            Model.popObject();
         }
      }
      
      private function stopEffect(param1:StopEffectInPacket) : void
      {
         var tankGameObject:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1.tankId);
         if(tankGameObject != null)
         {
            Model.object = tankGameObject;
            //this.tankModel.onEffectStopped(param1.effectId,false);
            Model.popObject();
         }
      }
   }
}

