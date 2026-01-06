package alternativa.tanks.models.tank
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.BodyState;
   import alternativa.tanks.battle.BattleRunner;
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.PostPhysicsController;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.LocalTankKilledEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.weapon.shared.MarginalCollider;
   import alternativa.tanks.physics.SweptSphereTest;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import platform.client.fp10.core.type.IGameObject;
   
   public class ChassisStateCorrectionTask extends BattleRunnerProvider implements PostPhysicsController
   {
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private static const COLLISION_PREDICTION_TIME_SEC:Number = 2;
      
      private static const PENETRATION_PREVENTION_INTERVAL_MSEC:EncryptedInt = new EncryptedIntImpl(1000);
      
      private static const MAX_INTERVAL_MS:EncryptedInt = new EncryptedIntImpl(2000);
      
      private static const MAX_DISTANCE:Number = 500;
      
      private static const MAX_DISTANCE_Z:Number = 200;
      
      private static const MAX_DISTANCE_SQUARED:Number = MAX_DISTANCE * MAX_DISTANCE;
      
      private static const SIGNIFICANT_ENERGY_DELTA:Number = 300000;
      
      private var tank:Tank;
      
      private var lastCorrectionTime:int;
      
      private var lastCorrectionPosition:Vector3 = new Vector3();
      
      private var previousEnergy:Number;
      
      private var tanksInBattle:Dictionary;
      
      private var tracksCollisions:int;
      
      private var bodyHasCollisions:Boolean;
      
      private var firstPhysicsStep:Boolean;
      
      private var battleEventSupport:BattleEventSupport;
      
      private var controlWasChanged:Boolean = false;
      
      public function ChassisStateCorrectionTask(param1:Tank, param2:Dictionary)
      {
         super();
         this.tank = param1;
         this.tanksInBattle = param2;
         this.firstPhysicsStep = true;
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
         this.battleEventSupport.addEventHandler(LocalTankKilledEvent,this.tankKilled);
         this.battleEventSupport.activateHandlers();
      }
      
      private function tankKilled(param1:Object) : void
      {
         this.firstPhysicsStep = true;
      }
      
      public function reset() : void
      {
         this.lastCorrectionTime = getBattleRunner().getPhysicsTime();
         this.lastCorrectionPosition.copy(this.getCurrentPosition());
         this.tracksCollisions = this.tank.getLeftTrack().numContacts + this.tank.getRightTrack().numContacts;
         this.bodyHasCollisions = this.tank.hasCollisionWithStatic() || this.tank.hasCollisionWithOtherBodies();
         this.previousEnergy = this.getEnergy();
      }
      
      public function runAfterPhysicsUpdate(param1:Number) : void
      {
         var _loc3_:Body = null;
         var _loc2_:Boolean = this.needMandatoryCorrection() || this.firstPhysicsStep;
         this.firstPhysicsStep = false;
         if(this.tank.hasCollisionWithOtherBodies())
         {
            for each(_loc3_ in this.tank.getPenetratedBodies())
            {
               this.tankModel().handleCollisionWithOtherTank(_loc3_.tank);
            }
         }
         if(this.hasStaticIntersection() || this.tank.isJumpBegin())
         {
            this.correctByPreviousState();
         }
         if(_loc2_ || this.needRegularCorrection())
         {
            this.correctByCurrentState(_loc2_);
            this.controlWasChanged = false;
         }
      }
      
      private function hasStaticIntersection() : Boolean
      {
         return MarginalCollider.segmentWithStaticIntersection(this.lastCorrectionPosition,this.tank.getBody().state.position);
      }
      
      private function correctByPreviousState() : void
      {
         this.lastCorrectionTime = getBattleRunner().getPhysicsTime() - BattleRunner.PHYSICS_STEP_IN_MS;
         this.lastCorrectionPosition.copy(this.getPrevPosition());
         this.tankModel().onPrevStateCorrection(true);
      }
      
      private function getPrevPosition() : Vector3
      {
         return this.tank.getBody().prevState.position;
      }
      
      private function needRegularCorrection() : Boolean
      {
         return this.isTimeToRegularCorrect() || this.controlWasChanged;
      }
      
      private function needMandatoryCorrection() : Boolean
      {
         return this.isXYDistanceTooLarge() || this.isZDistanceTooLarge() || this.isDeepPenetrationPreventionRequired() || this.tracksCollisionsStateChanges() || this.bodyCollisionsStateChanged() || this.fullEnergySignificallyChanges() || this.tank.isJumpEnd() || this.tank.isElasticStaticCollisionWhenSoaring();
      }
      
      public function controlChanged() : void
      {
         this.controlWasChanged = true;
      }
      
      private function bodyCollisionsStateChanged() : Boolean
      {
         var _loc1_:Boolean = this.tank.hasCollisionWithStatic() || this.tank.hasCollisionWithOtherBodies();
         return _loc1_ != this.bodyHasCollisions;
      }
      
      private function tracksCollisionsStateChanges() : Boolean
      {
         var _loc1_:int = this.tank.getLeftTrack().numContacts + this.tank.getRightTrack().numContacts;
         return this.tracksCollisions == 0 && _loc1_ != 0 || this.tracksCollisions != 0 && _loc1_ == 0;
      }
      
      private function isTimeToRegularCorrect() : Boolean
      {
         return getBattleRunner().getPhysicsTime() - this.lastCorrectionTime >= MAX_INTERVAL_MS.getInt();
      }
      
      private function isXYDistanceTooLarge() : Boolean
      {
         return this.lastCorrectionPosition.distanceToXYSquared(this.getCurrentPosition()) > MAX_DISTANCE_SQUARED;
      }
      
      private function isZDistanceTooLarge() : Boolean
      {
         return Math.abs(this.lastCorrectionPosition.z - this.getCurrentPosition().z) > MAX_DISTANCE_Z;
      }
      
      private function correctByCurrentState(param1:Boolean) : void
      {
         this.reset();
         this.tankModel().sendStateCorrection(param1);
      }
      
      private function getCurrentPosition() : Vector3
      {
         return this.tank.getBody().state.position;
      }
      
      private function fullEnergySignificallyChanges() : Boolean
      {
         var _loc1_:Number = this.getEnergy() - this.previousEnergy;
         return _loc1_ > SIGNIFICANT_ENERGY_DELTA;
      }
      
      private function isDeepPenetrationPreventionRequired() : Boolean
      {
         var _loc1_:int = int(PENETRATION_PREVENTION_INTERVAL_MSEC.getInt());
         return this.isCollisionPossible() && getTimer() - this.lastCorrectionTime > _loc1_;
      }
      
      private function getEnergy() : Number
      {
         var _loc1_:BodyState = this.tank.getBody().state;
         var _loc2_:Number = _loc1_.position.z * Math.abs(getBattleRunner().getGravity());
         var _loc3_:Number = _loc1_.velocity.length();
         var _loc4_:Number = _loc3_ * _loc3_ * 0.5;
         return _loc4_ + _loc2_;
      }
      
      private function isCollisionPossible() : Boolean
      {
         var _loc5_:Tank = null;
         var _loc6_:Body = null;
         var _loc7_:BodyState = null;
         var _loc1_:Body = this.tank.getBody();
         var _loc2_:BodyState = _loc1_.state;
         var _loc3_:Number = this.tank.getBoundSphereRadius();
         var _loc4_:Number = COLLISION_PREDICTION_TIME_SEC;
         for each(_loc5_ in this.tanksInBattle)
         {
            if(this.tank != _loc5_)
            {
               _loc6_ = _loc5_.getBody();
               _loc7_ = _loc6_.state;
               if(SweptSphereTest.test(_loc2_.position,_loc2_.velocity,_loc3_,_loc7_.position,_loc7_.velocity,_loc5_.getBoundSphereRadius(),_loc4_))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function tankModel() : ITankModel
      {
         var _loc1_:IGameObject = this.tank.getUser();
         return ITankModel(_loc1_.adapt(ITankModel));
      }
   }
}

