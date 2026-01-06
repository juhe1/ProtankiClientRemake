package alternativa.physics
{
   import alternativa.math.Vector3;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.physics.contactislands.ContactIsland;
   import alternativa.physics.contactislands.IslandsGenerator;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   
   public class PhysicsScene
   {
      
      private static const thousandth:EncryptedInt = new EncryptedIntImpl(1000);
      
      public var penetrationErrorCorrection:Number = 0.7;
      
      public var maxCorrectablePenetration:Number = 10;
      
      public var allowedPenetration:Number = 0.01;
      
      public var collisionIterations:int = 4;
      
      public var contactIterations:int = 4;
      
      public var freezeSteps:int = 10;
      
      public var linSpeedFreezeLimit:Number = 5;
      
      public var angSpeedFreezeLimit:Number = 0.05;
      
      public const gravity:Vector3 = new Vector3(0,0,-9.8);
      
      public var collisionDetector:CollisionDetector;
      
      public var bodies:Vector.<Body> = new Vector.<Body>();
      
      public var timeStamp:int;
      
      public var time:int;
      
      public var dt:Number;
      
      private const bodyContacts:Vector.<BodyContact> = new Vector.<BodyContact>();
      
      private var islandsGenerator:IslandsGenerator;
      
      public function PhysicsScene()
      {
         super();
         this.islandsGenerator = new IslandsGenerator(this);
      }
      
      public function addBody(param1:Body) : void
      {
         param1.scene = this;
         param1.id = this.bodies.length;
         this.bodies.push(param1);
      }
      
      public function removeBody(param1:Body) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Body = null;
         var _loc2_:int = int(this.bodies.indexOf(param1));
         if(_loc2_ > -1)
         {
            _loc3_ = this.bodies.length - 1;
            _loc4_ = this.bodies[_loc3_];
            this.bodies[_loc2_] = _loc4_;
            _loc4_.id = _loc2_;
            this.bodies.length = _loc3_;
            param1.scene = null;
         }
      }
      
      public function update(param1:int) : void
      {
         ++this.timeStamp;
         this.time += param1;
         this.dt = param1 / thousandth.getInt();
         this.applyForces();
         this.detectCollisions();
         this.prepareBodyContacts(this.bodyContacts,this.dt);
         this.islandsGenerator.generate(this.bodyContacts,this.bodies.length);
         this.resolveCollisions(this.islandsGenerator.contactIslands);
         this.intergateVelocities(this.dt);
         this.resolveContacts(this.islandsGenerator.contactIslands);
         this.islandsGenerator.clear();
         this.disposeBodyContacts(this.bodyContacts);
         this.integratePositions(this.dt);
         this.postPhysics();
      }
      
      private function applyForces() : void
      {
         var _loc3_:Body = null;
         var _loc1_:int = int(this.bodies.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.bodies[_loc2_];
            _loc3_.calcAccelerations();
            if(_loc3_.movable && !_loc3_.frozen)
            {
               _loc3_.acceleration.x += this.gravity.x;
               _loc3_.acceleration.y += this.gravity.y;
               _loc3_.acceleration.z += this.gravity.z;
            }
            _loc2_++;
         }
      }
      
      private function detectCollisions() : void
      {
         this.calculateBodiesDerivedData();
         this.collisionDetector.getBodyContacts(this.bodyContacts);
      }
      
      private function calculateBodiesDerivedData() : void
      {
         var _loc3_:Body = null;
         var _loc1_:int = int(this.bodies.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.bodies[_loc2_];
            if(!_loc3_.frozen)
            {
               _loc3_.saveState();
               _loc3_.calcDerivedData();
            }
            _loc2_++;
         }
      }
      
      private function prepareBodyContacts(param1:Vector.<BodyContact>, param2:Number) : void
      {
         var _loc5_:BodyContact = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            this.prepareShapeContacts(_loc5_.shapeContacts,param2);
            _loc4_++;
         }
      }
      
      private function prepareShapeContacts(param1:Vector.<ShapeContact>, param2:Number) : void
      {
         var _loc5_:ShapeContact = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc5_.calculatePersistentFrameData();
            _loc5_.calcualteDynamicFrameData(this.allowedPenetration,this.penetrationErrorCorrection,this.maxCorrectablePenetration,param2);
            _loc4_++;
         }
      }
      
      private function resolveCollisions(param1:Vector.<ContactIsland>) : void
      {
         var _loc4_:ContactIsland = null;
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            _loc4_.collisionPhase(this.collisionIterations);
            _loc3_++;
         }
      }
      
      private function resolveContacts(param1:Vector.<ContactIsland>) : void
      {
         var _loc4_:ContactIsland = null;
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            _loc4_.contactPhase(this.contactIterations);
            _loc3_++;
         }
      }
      
      private function intergateVelocities(param1:Number) : void
      {
         var _loc4_:Body = null;
         var _loc2_:int = int(this.bodies.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.bodies[_loc3_];
            _loc4_.integrateVelocity(param1);
            _loc3_++;
         }
      }
      
      private function integratePositions(param1:Number) : void
      {
         var _loc4_:Body = null;
         var _loc2_:int = int(this.bodies.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.bodies[_loc3_];
            if(_loc4_.movable && !_loc4_.frozen)
            {
               _loc4_.integratePosition(param1);
               _loc4_.integratePseudoVelocity(param1);
            }
            _loc3_++;
         }
      }
      
      private function postPhysics() : void
      {
         var _loc3_:Body = null;
         var _loc4_:BodyState = null;
         var _loc1_:int = int(this.bodies.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.bodies[_loc2_];
            _loc3_.clearAccumulators();
            _loc3_.calcDerivedData();
            if(_loc3_.canFreeze && !_loc3_.frozen)
            {
               _loc4_ = _loc3_.state;
               if(_loc4_.velocity.length() < this.linSpeedFreezeLimit && _loc4_.angularVelocity.length() < this.angSpeedFreezeLimit)
               {
                  ++_loc3_.freezeCounter;
                  if(_loc3_.freezeCounter >= this.freezeSteps)
                  {
                     _loc3_.frozen = true;
                  }
               }
               else
               {
                  _loc3_.freezeCounter = 0;
                  _loc3_.frozen = false;
               }
            }
            _loc2_++;
         }
      }
      
      private function disposeBodyContacts(param1:Vector.<BodyContact>) : void
      {
         var _loc4_:BodyContact = null;
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            _loc4_.dispose();
            _loc3_++;
         }
         param1.length = 0;
      }
   }
}

