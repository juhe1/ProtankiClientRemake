package alternativa.tanks.battle
{
   import alternativa.physics.Body;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.triggers.Triggers;
   import alternativa.tanks.battle.utils.AddPostPhysicsControllerAction;
   import alternativa.tanks.battle.utils.LogicUnitDeferredAction;
   import alternativa.tanks.battle.utils.PhysicsControllerDeferredAction;
   import alternativa.tanks.battle.utils.RemovePostPhysicsController;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.physics.TankBody;
   import alternativa.tanks.physics.TankBodyIdProvider;
   import alternativa.tanks.physics.TankPhysicsScene;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import alternativa.tanks.sound.ISoundManager;
   import alternativa.tanks.sound.SoundManager;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import flash.media.Sound;
   import flash.utils.getTimer;
   
   public class BattleRunner
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var localTankInfoService:LocalTankInfoService;
      
      public static const PHYSICS_STEP_IN_MS:int = 33;
      
      public static const PHYSICS_STEP_IN_S:Number = 0.033;
      
      private static const thousand:EncryptedInt = new EncryptedIntImpl(1000);
      
      public var physicsPerformanceMonitor:PerformanceMonitor = new PerformanceMonitor(30);
      
      private var time:int;
      
      private var lastRunLogicTime:int;
      
      private var logicUnits:Vector.<LogicUnit> = new Vector.<LogicUnit>();
      
      private var logicInProgress:Boolean;
      
      private var physicsControllers:Vector.<PhysicsController> = new Vector.<PhysicsController>();
      
      private var postPhysicsControllers:Vector.<PostPhysicsController> = new Vector.<PostPhysicsController>();
      
      private var physicsInterpolators:Vector.<PhysicsInterpolator> = new Vector.<PhysicsInterpolator>();
      
      private var deferredActions:Vector.<DeferredAction> = new Vector.<DeferredAction>();
      
      private var localBody:Body;
      
      private var physicsInProgress:Boolean;
      
      private var soundManager:ISoundManager;
      
      private var battleEventDispatcher:BattleEventDispatcher;
      
      private const _triggers:Triggers = new Triggers();
      
      private var physicsScene:TankPhysicsScene;
      
      public function BattleRunner(param1:Number, param2:Sound, param3:BattleEventDispatcher)
      {
         super();
         this.battleEventDispatcher = param3;
         this.time = getTimer();
         this.physicsScene = new TankPhysicsScene(this.time,param1,param3);
         this.soundManager = SoundManager.createSoundManager(param2);
         this.lastRunLogicTime = this.time;
         TankBodyIdProvider.resetIds();
      }
      
      public function getSoundManager() : ISoundManager
      {
         return this.soundManager;
      }
      
      public function initStaticGeometry(param1:Vector.<CollisionShape>) : void
      {
         this.physicsScene.initStaticGeometry(param1);
      }
      
      public function getCollisionDetector() : TanksCollisionDetector
      {
         return this.physicsScene.getCollisionDetector();
      }
      
      public function addLogicUnit(param1:LogicUnit) : void
      {
         if(this.logicInProgress)
         {
            this.addDeferredAction(new LogicUnitDeferredAction(param1,true));
         }
         else if(this.logicUnits.indexOf(param1) < 0)
         {
            this.logicUnits.push(param1);
         }
      }
      
      public function removeLogicUnit(param1:LogicUnit) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.logicInProgress)
         {
            this.addDeferredAction(new LogicUnitDeferredAction(param1,false));
         }
         else
         {
            _loc2_ = int(this.logicUnits.length);
            if(_loc2_ > 0)
            {
               _loc3_ = int(this.logicUnits.indexOf(param1));
               if(_loc3_ >= 0)
               {
                  this.logicUnits[_loc3_] = this.logicUnits[--_loc2_];
                  this.logicUnits.length = _loc2_;
               }
            }
         }
      }
      
      public function addTrigger(param1:Trigger) : void
      {
         this._triggers.add(param1);
      }
      
      public function removeTrigger(param1:Trigger) : void
      {
         this._triggers.remove(param1);
      }
      
      public function setLocalBody(param1:Body) : void
      {
         this.localBody = param1;
      }
      
      public function addBodyWrapper(param1:TankBody) : void
      {
         this.physicsScene.addBody(param1);
      }
      
      public function removeBodyWrapper(param1:TankBody) : void
      {
         this.physicsScene.removeBody(param1);
         if(this.localBody == param1.body)
         {
            this.setLocalBody(null);
         }
      }
      
      public function addPhysicsController(param1:PhysicsController) : void
      {
         if(this.physicsInProgress)
         {
            this.addDeferredAction(new PhysicsControllerDeferredAction(param1,true));
         }
         else if(this.physicsControllers.indexOf(param1) < 0)
         {
            this.physicsControllers.push(param1);
         }
      }
      
      public function removePhysicsController(param1:PhysicsController) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.physicsInProgress)
         {
            this.addDeferredAction(new PhysicsControllerDeferredAction(param1,false));
         }
         else
         {
            _loc2_ = int(this.physicsControllers.length);
            if(_loc2_ > 0)
            {
               _loc3_ = int(this.physicsControllers.indexOf(param1));
               if(_loc3_ >= 0)
               {
                  this.physicsControllers.splice(_loc3_,1);
               }
            }
         }
      }
      
      public function addPostPhysicsController(param1:PostPhysicsController) : void
      {
         if(this.physicsInProgress)
         {
            this.addDeferredAction(new AddPostPhysicsControllerAction(param1));
         }
         else if(this.postPhysicsControllers.indexOf(param1) < 0)
         {
            this.postPhysicsControllers.push(param1);
         }
      }
      
      public function removePostPhysicsController(param1:PostPhysicsController) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.physicsInProgress)
         {
            this.addDeferredAction(new RemovePostPhysicsController(param1));
         }
         else
         {
            _loc2_ = int(this.postPhysicsControllers.length);
            if(_loc2_ > 0)
            {
               _loc3_ = int(this.postPhysicsControllers.indexOf(param1));
               if(_loc3_ >= 0)
               {
                  this.postPhysicsControllers.splice(_loc3_,1);
               }
            }
         }
      }
      
      public function addPhysicsInterpolator(param1:PhysicsInterpolator) : void
      {
         if(this.physicsInterpolators.indexOf(param1) < 0)
         {
            this.physicsInterpolators.push(param1);
         }
      }
      
      public function removePhysicsInterpolator(param1:PhysicsInterpolator) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(this.physicsInterpolators.length);
         if(_loc2_ > 0)
         {
            _loc3_ = int(this.physicsInterpolators.indexOf(param1));
            if(_loc3_ >= 0)
            {
               this.physicsInterpolators[_loc3_] = this.physicsInterpolators[--_loc2_];
               this.physicsInterpolators.length = _loc2_;
            }
         }
      }
      
      public function tick() : void
      {
         var _loc1_:int = getTimer();
         var _loc2_:int = _loc1_ - this.time;
         this.time = _loc1_;
         this.runPhysics(PHYSICS_STEP_IN_MS);
         battleService.getBattleScene3D().render(this.time,_loc2_);
         battleService.getBattleView().update();
         this.soundManager.updateSoundEffects(_loc2_,battleService.getBattleScene3D().getCamera());
      }
      
      public function shutdown() : void
      {
         this.soundManager.stopAllSounds();
         this.soundManager.removeAllEffects();
         this.physicsScene.destroy();
      }
      
      private function runLogicUnits(param1:int) : void
      {
         var _loc5_:LogicUnit = null;
         var _loc2_:int = param1 - this.lastRunLogicTime;
         this.lastRunLogicTime = param1;
         this.logicInProgress = true;
         var _loc3_:int = int(this.logicUnits.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.logicUnits[_loc4_];
            _loc5_.runLogic(param1,_loc2_);
            _loc4_++;
         }
         this.logicInProgress = false;
         this.executeDeferedActions();
      }
      
      private function runPhysics(param1:int) : void
      {
         this.physicsPerformanceMonitor.beginFrame();
         while(this.physicsScene.getPhysicsTime() < this.time)
         {
            this.updateLocalTankPhysicsState();
            this.runLogicUnits(this.getPhysicsTime());
            this.physicsInProgress = true;
            this.runPhysicsControllers(param1 / thousand.getInt());
            this.physicsScene.update(param1);
            this.runPostPhysicsControllers(param1 / thousand.getInt());
            this._triggers.check(this.localBody);
            this.physicsInProgress = false;
            this.executeDeferedActions();
         }
         this.physicsPerformanceMonitor.endFrame();
         this.runPhysicsInterpolators();
      }
      
      private function updateLocalTankPhysicsState() : void
      {
         if(localTankInfoService.isLocalTankLoaded())
         {
            localTankInfoService.getLocalTank().updatePhysicsState();
         }
      }
      
      private function runPhysicsControllers(param1:Number) : void
      {
         var _loc4_:PhysicsController = null;
         var _loc2_:int = int(this.physicsControllers.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.physicsControllers[_loc3_];
            _loc4_.runBeforePhysicsUpdate(param1);
            _loc3_++;
         }
      }
      
      private function runPostPhysicsControllers(param1:Number) : void
      {
         var _loc4_:PostPhysicsController = null;
         var _loc2_:int = int(this.postPhysicsControllers.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.postPhysicsControllers[_loc3_];
            _loc4_.runAfterPhysicsUpdate(param1);
            _loc3_++;
         }
      }
      
      private function runPhysicsInterpolators() : void
      {
         var _loc4_:PhysicsInterpolator = null;
         var _loc1_:Number = 1 + (this.time - this.physicsScene.getPhysicsTime()) / PHYSICS_STEP_IN_MS;
         var _loc2_:int = int(this.physicsInterpolators.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.physicsInterpolators[_loc3_];
            _loc4_.interpolatePhysicsState(_loc1_);
            _loc3_++;
         }
      }
      
      private function addDeferredAction(param1:DeferredAction) : void
      {
         this.deferredActions.push(param1);
      }
      
      private function executeDeferedActions() : void
      {
         var _loc1_:DeferredAction = null;
         while(true)
         {
            _loc1_ = this.deferredActions.pop();
            if(_loc1_ == null)
            {
               break;
            }
            _loc1_.execute();
         }
      }
      
      public function getPhysicsTime() : int
      {
         return this.physicsScene.getPhysicsTime();
      }
      
      public function getGravity() : Number
      {
         return this.physicsScene.getGravity();
      }
   }
}

