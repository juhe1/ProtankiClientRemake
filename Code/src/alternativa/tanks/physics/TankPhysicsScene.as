package alternativa.tanks.physics
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.PhysicsScene;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.tanks.battle.BattleRunner;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.utils.DataValidationErrorEvent;
   import alternativa.tanks.utils.DataValidatorType;
   import alternativa.tanks.utils.Vector3Validator;
   
   public class TankPhysicsScene
   {
      
      private static const MAX_UP_VELOCITY:Number = 200;
      
      private var gravityValidator:Vector3Validator;
      
      private var physicsScene:PhysicsScene;
      
      private var collisionDetector:TanksCollisionDetector;
      
      private var battleEventDispatcher:BattleEventDispatcher;
      
      public function TankPhysicsScene(param1:int, param2:Number, param3:BattleEventDispatcher)
      {
         super();
         this.battleEventDispatcher = param3;
         this.physicsScene = new PhysicsScene();
         this.physicsScene.gravity.reset(0,0,-param2);
         this.gravityValidator = new Vector3Validator(this.physicsScene.gravity);
         this.physicsScene.collisionIterations = 4;
         this.physicsScene.contactIterations = 4;
         this.physicsScene.allowedPenetration = 5;
         this.collisionDetector = new TanksCollisionDetector();
         this.physicsScene.collisionDetector = this.collisionDetector;
         this.physicsScene.time = param1;
      }
      
      public function getPhysicsTime() : int
      {
         return this.physicsScene.time;
      }
      
      public function initStaticGeometry(param1:Vector.<CollisionShape>) : void
      {
         this.collisionDetector.buildKdTree(param1);
      }
      
      public function getCollisionDetector() : TanksCollisionDetector
      {
         return this.collisionDetector;
      }
      
      public function addBody(param1:TankBody) : void
      {
         this.physicsScene.addBody(param1.body);
         this.collisionDetector.addTankBody(param1);
      }
      
      public function removeBody(param1:TankBody) : void
      {
         this.physicsScene.removeBody(param1.body);
         this.collisionDetector.removeTankBody(param1);
      }
      
      public function destroy() : void
      {
         this.collisionDetector.destroy();
      }
      
      public function update(param1:int) : void
      {
         if(this.gravityValidator.isValid())
         {
            this.physicsScene.update(param1);
            this.postPhysicsTankProcessor();
         }
         else
         {
            this.physicsScene.time = int.MAX_VALUE;
            this.battleEventDispatcher.dispatchEventOnce(new DataValidationErrorEvent(DataValidatorType.MEMHACK_GRAVITY));
         }
      }
      
      private function postPhysicsTankProcessor() : void
      {
         var _loc1_:TankBody = null;
         var _loc2_:Body = null;
         var _loc3_:Vector3 = null;
         var _loc4_:Vector3 = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         for each(_loc1_ in this.collisionDetector.getTankBodies())
         {
            _loc2_ = _loc1_.body;
            _loc3_ = _loc2_.state.velocity;
            _loc4_ = BattleUtils.tmpVector;
            _loc2_.state.orientation.getZAxis(_loc4_);
            _loc5_ = _loc3_.x * _loc4_.x + _loc3_.y * _loc4_.y + _loc3_.z * _loc4_.z;
            if(_loc4_.z < -0.1 || _loc4_.z < 0.1 && _loc5_ < 0)
            {
               _loc5_ = -_loc5_;
               _loc4_.reverse();
            }
            _loc1_.updateSoaring();
            if(_loc1_.hasContactsWithStatic || _loc1_.wasContactWithStatic || _loc1_.hasContactsWithOtherBodies() || !_loc1_.isSoaring())
            {
               _loc6_ = MAX_UP_VELOCITY;
               if(!_loc1_.hasContactsWithStatic && _loc1_.isSoaring() && _loc1_.previousUpVelocity > _loc6_)
               {
                  _loc6_ = _loc1_.previousUpVelocity;
               }
               _loc7_ = _loc1_.additionForcesSum.dot(_loc4_);
               _loc8_ = _loc7_ * _loc1_.body.invMass * BattleRunner.PHYSICS_STEP_IN_MS / 1000;
               if(_loc8_ < MAX_UP_VELOCITY)
               {
                  _loc8_ = 0;
               }
               _loc6_ = Math.max(_loc8_,_loc6_);
               if(_loc5_ > _loc6_)
               {
                  _loc9_ = _loc5_ - _loc6_;
                  _loc3_.x -= _loc9_ * _loc4_.x;
                  _loc3_.y -= _loc9_ * _loc4_.y;
                  _loc3_.z -= _loc9_ * _loc4_.z;
                  _loc5_ = _loc6_;
               }
            }
            _loc1_.previousUpVelocity = _loc5_;
            _loc1_.additionForcesSum.reset();
         }
      }
      
      public function getGravity() : Number
      {
         return this.physicsScene.gravity.z;
      }
   }
}

