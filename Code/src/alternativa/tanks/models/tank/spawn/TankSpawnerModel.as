package alternativa.tanks.models.tank.spawn
{
   import alternativa.osgi.service.logging.LogService;
   import alternativa.osgi.service.logging.Logger;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.TankControlLockBits;
   import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
   import alternativa.tanks.models.battle.battlefield.BattleUnloadEvent;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.LocalTankParams;
   import alternativa.tanks.models.tank.MovementTimeoutAndDistanceAnticheatTask;
   import alternativa.tanks.models.tank.SpawnCameraConfigurator;
   import alternativa.tanks.models.tank.spawn.spawnhandlers.LocalTankFirstTimeSpawner;
   import alternativa.tanks.models.tank.spawn.spawnhandlers.ready2spawn.LocalReadyToSpawnHandler;
   import alternativa.tanks.models.tank.spawn.spawnhandlers.ready2spawn.ReadyToSpawnHandler;
   import alternativa.tanks.models.tank.spawn.spawnhandlers.ready2spawn.RemoteReadyToSpawnHandler;
   import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.LocalSpawnHandler;
   import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.RemoteSpawnHandler;
   import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.SpawnHandler;
   import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.SpectatorSpawnHandler;
   import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.TankSpawnListener;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battlefield.models.user.spawn.ITankSpawnerModelBase;
   import projects.tanks.client.battlefield.models.user.spawn.TankSpawnerModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   [ModelInfo]
   public class TankSpawnerModel extends TankSpawnerModelBase implements ITankSpawner, ITankSpawnerModelBase, ObjectUnloadListener, ObjectLoadListener, BattleEventListener
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var logService:LogService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private static const ZERO_VECTOR_3D:Vector3d = new Vector3d(0,0,0);
      
      private var battleEventSupport:BattleEventSupport;
      
      private var logger:Logger;
      
      private var damageLogger:Logger;
      
      private var readyToPlaceTask:ReadyToPlaceTask;
      
      private var spawnCameraConfigurator:SpawnCameraConfigurator;
      
      public function TankSpawnerModel()
      {
         super();
         this.logger = logService.getLogger("tank");
         this.damageLogger = logService.getLogger("damage");
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(BattleUnloadEvent,this.onBattleFinish);
         this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
      }
      
      private function onBattleFinish(param1:*) : void
      {
         this.removeReadyToPlaceTask();
      }
      
      public function prepareToSpawn(param1:Vector3d, param2:Vector3d) : void
      {
         this.spawnCameraConfigurator.setupCamera(param1,param2);
         this.removeReadyToPlaceTask();
         this.readyToPlaceTask = new ReadyToPlaceTask(battleService.getRespawnDurationMs(),object);
         battleService.getBattleRunner().addLogicUnit(this.readyToPlaceTask);
      }
      
      public function spawn(param1:BattleTeam, param2:Vector3d, param3:Vector3d, param4:int, param5:int) : void
      {
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:MovementTimeoutAndDistanceAnticheatTask = null;
         var _loc12_:SpawnHandler = null;
         var _loc6_:ITankModel = ITankModel(object.adapt(ITankModel));
         var _loc7_:Tank = _loc6_.getTank();
         if(_loc6_.isLocal())
         {
            LocalTankParams.teamType = param1;
            server.confirmSpawn(param5);
         }
         if(_loc7_ != null)
         {
            _loc6_.removeTankFromBattle();
            _loc7_.spawn(param1,param5);
            _loc7_.setSemiActivatedState();
            _loc6_.doSetHealth(param4);
            _loc6_.unlockMovementControl(TankControlLockBits.DEAD | TankControlLockBits.DISABLED);
            _loc8_ = Boolean(_loc6_.getUserInfo().isLocal);
            _loc9_ = _loc8_ ? int(_loc6_.getChassisController().getControlState()) : 0;
            _loc10_ = _loc8_ ? TrackedChassis.TURN_SPEED_COUNT : 0;
            _loc6_.setChassisState(param2,param3,ZERO_VECTOR_3D,ZERO_VECTOR_3D,_loc9_,_loc10_);
            _loc11_ = _loc6_.getMovementAnticheatTask();
            if(Boolean(_loc11_))
            {
               _loc11_.updateLatestServerTankPosition(param2,param3);
            }
            _loc12_ = SpawnHandler(getData(SpawnHandler));
            _loc12_.spawn(_loc7_);
            _loc6_.addTankToBattle(_loc7_);
            TankSpawnListener(object.event(TankSpawnListener)).onTankSpawn();
         }
      }
      
      public function getIncarnationId() : int
      {
         return getInitParam().incarnationId;
      }
      
      public function objectLoaded() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:ITankModel = ITankModel(object.adapt(ITankModel));
         if(_loc1_.isLocal())
         {
            _loc2_ = Boolean(battleService.isLocalTankFirstLoad());
            this.spawnCameraConfigurator = new SpawnCameraConfigurator(_loc2_);
            if(_loc2_)
            {
               putData(LocalTankFirstTimeSpawner,new LocalTankFirstTimeSpawner(object,server));
            }
            battleService.setLocalTankLoaded();
            putData(ReadyToSpawnHandler,new LocalReadyToSpawnHandler(object,server));
            putData(SpawnHandler,new LocalSpawnHandler());
            if(Boolean(this.readyToPlaceTask))
            {
               this.readyToPlaceTask.setTankObject(object);
            }
         }
         else
         {
            putData(ReadyToSpawnHandler,new RemoteReadyToSpawnHandler(object));
            putData(SpawnHandler,new RemoteSpawnHandler());
         }
      }
      
      public function setLocal() : void
      {
         putData(SpawnHandler,new SpectatorSpawnHandler());
      }
      
      public function setRemote() : void
      {
         putData(SpawnHandler,new RemoteSpawnHandler());
      }
      
      public function readyToSpawn() : void
      {
         var _loc1_:ReadyToSpawnHandler = ReadyToSpawnHandler(getData(ReadyToSpawnHandler));
         _loc1_.handleReadyToSpawn();
      }
      
      public function setReadyToPlace() : void
      {
         this.removeReadyToPlaceTask();
         server.setReadyToPlace();
      }
      
      private function removeReadyToPlaceTask() : void
      {
         if(Boolean(this.readyToPlaceTask))
         {
            battleService.getBattleRunner().removeLogicUnit(this.readyToPlaceTask);
            this.readyToPlaceTask = null;
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function objectUnloaded() : void
      {
         var _loc1_:ITankModel = ITankModel(object.adapt(ITankModel));
         if(_loc1_.isLocal())
         {
            this.spawnCameraConfigurator = null;
            if(Boolean(this.readyToPlaceTask))
            {
               this.readyToPlaceTask.setTankObject(null);
            }
         }
      }
   }
}

