package alternativa.physics.contactislands
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.BodyContact;
   import alternativa.physics.PhysicsScene;
   import alternativa.physics.ShapeContact;
   
   public class ContactIsland
   {
      
      private static var poolSize:int;
      
      private static const pool:Vector.<ContactIsland> = new Vector.<ContactIsland>();
      
      private static const _relativeVelocity:Vector3 = new Vector3();
      
      private static const COLLISION_MODE:int = 0;
      
      private static const CONTACT_MODE:int = 1;
      
      public const bodyContacts:Vector.<BodyContact> = new Vector.<BodyContact>();
      
      private var physicsScene:PhysicsScene;
      
      private const allShapeContacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();
      
      private const levelShapeContacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();
      
      private var prevLevelBodies:Vector.<Body> = new Vector.<Body>();
      
      private var levelBodies:Vector.<Body> = new Vector.<Body>();
      
      private const levelBodyContacts:Vector.<BodyContact> = new Vector.<BodyContact>();
      
      private const contactLevels:ContactLevels = new ContactLevels();
      
      public function ContactIsland()
      {
         super();
      }
      
      public static function create() : ContactIsland
      {
         if(poolSize == 0)
         {
            return new ContactIsland();
         }
         --poolSize;
         var _loc1_:ContactIsland = pool[poolSize];
         pool[poolSize] = null;
         return _loc1_;
      }
      
      public function dispose() : void
      {
         this.physicsScene = null;
         this.bodyContacts.length = 0;
         this.allShapeContacts.length = 0;
         this.levelShapeContacts.length = 0;
         this.prevLevelBodies.length = 0;
         this.levelBodies.length = 0;
         this.levelBodyContacts.length = 0;
         this.contactLevels.clear();
         pool[poolSize++] = this;
      }
      
      public function init(param1:PhysicsScene) : void
      {
         var _loc5_:BodyContact = null;
         var _loc6_:Vector.<ShapeContact> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         this.physicsScene = param1;
         var _loc2_:int = int(this.bodyContacts.length);
         var _loc3_:Vector.<ShapeContact> = this.allShapeContacts;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = this.bodyContacts[_loc4_];
            _loc6_ = _loc5_.shapeContacts;
            _loc7_ = int(_loc6_.length);
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc3_[_loc3_.length] = _loc6_[_loc8_];
               _loc8_++;
            }
            _loc4_++;
         }
      }
      
      public function collisionPhase(param1:int) : void
      {
         this.resolveCollisions(param1);
      }
      
      public function contactPhase(param1:int) : void
      {
         this.resolveContacts(param1);
      }
      
      private function resolveCollisions(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = int(this.allShapeContacts.length);
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            this.shuffleContacts(this.allShapeContacts);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               this.resolveContact(this.allShapeContacts[_loc4_],COLLISION_MODE);
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      private function resolveContacts(param1:int) : void
      {
         var _loc2_:Vector.<Body> = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ShapeContact = null;
         this.processContacts(param1);
         this.contactLevels.init(this.bodyContacts);
         this.contactLevels.getStaticLevel(this.levelBodyContacts,this.levelBodies);
         if(this.levelBodyContacts.length > 0)
         {
            this.getShapeContacts(this.levelBodyContacts,this.levelShapeContacts);
            this.resolveContactsForLevel(param1,this.levelShapeContacts);
            this.calculatePseudoVelocities(param1,this.levelShapeContacts);
            while(this.contactLevels.hasContacts())
            {
               _loc2_ = this.prevLevelBodies;
               this.prevLevelBodies = this.levelBodies;
               this.levelBodies = _loc2_;
               this.levelBodyContacts.length = 0;
               this.levelBodies.length = 0;
               this.contactLevels.getNextLevel(this.prevLevelBodies,this.levelBodyContacts,this.levelBodies);
               this.setBodiesMobility(this.prevLevelBodies,false);
               this.levelShapeContacts.length = 0;
               this.getShapeContacts(this.levelBodyContacts,this.levelShapeContacts);
               _loc3_ = int(this.levelShapeContacts.length);
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc5_ = this.levelShapeContacts[_loc4_];
                  _loc5_.calcualteDynamicFrameData(this.physicsScene.allowedPenetration,this.physicsScene.penetrationErrorCorrection,this.physicsScene.maxCorrectablePenetration,this.physicsScene.dt);
                  _loc4_++;
               }
               this.resolveContactsForLevel(param1,this.levelShapeContacts);
               this.calculatePseudoVelocities(param1,this.levelShapeContacts);
               this.setBodiesMobility(this.prevLevelBodies,true);
            }
         }
         else
         {
            this.getShapeContacts(this.bodyContacts,this.levelShapeContacts);
            this.resolveContactsForLevel(param1,this.levelShapeContacts);
            this.calculatePseudoVelocities(param1,this.levelShapeContacts);
         }
      }
      
      private function processContacts(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = int(this.allShapeContacts.length);
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            this.shuffleContacts(this.allShapeContacts);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               this.resolveContact(this.allShapeContacts[_loc4_],CONTACT_MODE);
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      private function getShapeContacts(param1:Vector.<BodyContact>, param2:Vector.<ShapeContact>) : void
      {
         var _loc5_:BodyContact = null;
         var _loc6_:Vector.<ShapeContact> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = _loc5_.shapeContacts;
            _loc7_ = int(_loc6_.length);
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               param2[param2.length] = _loc6_[_loc8_];
               _loc8_++;
            }
            _loc4_++;
         }
      }
      
      private function shuffleContacts(param1:Vector.<ShapeContact>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:ShapeContact = null;
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 1;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc3_ * Math.random();
            _loc5_ = param1[_loc4_];
            param1[_loc4_] = param1[_loc3_];
            param1[_loc3_] = _loc5_;
            _loc3_++;
         }
      }
      
      private function resolveContactsForLevel(param1:int, param2:Vector.<ShapeContact>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            this.shuffleContacts(param2);
            _loc4_ = int(param2.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.resolveContact(param2[_loc5_],CONTACT_MODE);
               _loc5_++;
            }
            _loc3_++;
         }
      }
      
      private function calculatePseudoVelocities(param1:int, param2:Vector.<ShapeContact>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            this.shuffleContacts(param2);
            _loc4_ = int(param2.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.resolveContactPseudoVelocity(param2[_loc5_]);
               _loc5_++;
            }
            _loc3_++;
         }
      }
      
      private function setBodiesMobility(param1:Vector.<Body>, param2:Boolean) : void
      {
         var _loc5_:Body = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc5_.movable = param2;
            _loc4_++;
         }
      }
      
      private function resolveContact(param1:ShapeContact, param2:int) : void
      {
         var _loc8_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc3_:Vector3 = param1.normal;
         var _loc4_:Body = param1.shape1.body;
         var _loc5_:Body = param1.shape2.body;
         var _loc6_:Vector3 = _relativeVelocity;
         this.calculateRelativeVelocity(param1,_loc6_);
         var _loc7_:Number = _loc6_.x * _loc3_.x + _loc6_.y * _loc3_.y + _loc6_.z * _loc3_.z;
         if(param2 == CONTACT_MODE)
         {
            _loc8_ = 0;
            if(_loc7_ < 0)
            {
               param1.satisfied = false;
            }
            else if(param1.satisfied)
            {
               return;
            }
         }
         else
         {
            param1.satisfied = true;
            _loc8_ = param1.collisionSpeed;
         }
         var _loc9_:Number = _loc6_.dot(param1.tangent1);
         var _loc10_:Number = _loc6_.dot(param1.tangent2);
         var _loc11_:Number = param1.tangentImpulse1 - _loc9_ / param1.tangentSpeedDelta1;
         var _loc12_:Number = param1.tangentImpulse2 - _loc10_ / param1.tangentSpeedDelta2;
         var _loc13_:Number = _loc11_ * _loc11_ + _loc12_ * _loc12_;
         var _loc14_:Number = param1.friction * param1.normalImpulse;
         if(_loc13_ > _loc14_ * _loc14_)
         {
            _loc20_ = Math.sqrt(_loc13_);
            _loc11_ *= _loc14_ / _loc20_;
            _loc12_ *= _loc14_ / _loc20_;
         }
         var _loc15_:Number = _loc11_ - param1.tangentImpulse1;
         var _loc16_:Number = _loc12_ - param1.tangentImpulse2;
         param1.tangentImpulse1 = _loc11_;
         param1.tangentImpulse2 = _loc12_;
         if(_loc4_.movable)
         {
            _loc4_.applyWorldImpulseAtLocalPoint(param1.r1,param1.tangent1,_loc15_);
            _loc4_.applyWorldImpulseAtLocalPoint(param1.r1,param1.tangent2,_loc16_);
         }
         if(_loc5_.movable)
         {
            _loc5_.applyWorldImpulseAtLocalPoint(param1.r2,param1.tangent1,-_loc15_);
            _loc5_.applyWorldImpulseAtLocalPoint(param1.r2,param1.tangent2,-_loc16_);
         }
         this.calculateRelativeVelocity(param1,_loc6_);
         _loc7_ = _loc6_.x * _loc3_.x + _loc6_.y * _loc3_.y + _loc6_.z * _loc3_.z;
         var _loc17_:Number = _loc8_ - _loc7_;
         var _loc18_:Number = param1.normalImpulse + _loc17_ / param1.normalSpeedDelta;
         if(_loc18_ < 0)
         {
            _loc18_ = 0;
         }
         var _loc19_:Number = _loc18_ - param1.normalImpulse;
         param1.normalImpulse = _loc18_;
         if(_loc4_.movable)
         {
            _loc4_.applyWorldImpulseAtLocalPoint(param1.r1,param1.normal,_loc19_);
         }
         if(_loc5_.movable)
         {
            _loc5_.applyWorldImpulseAtLocalPoint(param1.r2,param1.normal,-_loc19_);
         }
      }
      
      private function calculateRelativeVelocity(param1:ShapeContact, param2:Vector3) : void
      {
         var _loc4_:Vector3 = null;
         var _loc3_:Vector3 = param1.shape1.body.state.angularVelocity;
         _loc4_ = param1.r1;
         var _loc5_:Number = _loc3_.y * _loc4_.z - _loc3_.z * _loc4_.y;
         var _loc6_:Number = _loc3_.z * _loc4_.x - _loc3_.x * _loc4_.z;
         var _loc7_:Number = _loc3_.x * _loc4_.y - _loc3_.y * _loc4_.x;
         _loc4_ = param1.shape1.body.state.velocity;
         param2.x = _loc4_.x + _loc5_;
         param2.y = _loc4_.y + _loc6_;
         param2.z = _loc4_.z + _loc7_;
         _loc3_ = param1.shape2.body.state.angularVelocity;
         _loc4_ = param1.r2;
         _loc5_ = _loc3_.y * _loc4_.z - _loc3_.z * _loc4_.y;
         _loc6_ = _loc3_.z * _loc4_.x - _loc3_.x * _loc4_.z;
         _loc7_ = _loc3_.x * _loc4_.y - _loc3_.y * _loc4_.x;
         _loc4_ = param1.shape2.body.state.velocity;
         param2.x -= _loc4_.x + _loc5_;
         param2.y -= _loc4_.y + _loc6_;
         param2.z -= _loc4_.z + _loc7_;
      }
      
      private function resolveContactPseudoVelocity(param1:ShapeContact) : void
      {
         var _loc2_:Vector3 = _relativeVelocity;
         this.calcPseudoSeparationVelocity(param1,_loc2_);
         var _loc3_:Number = _loc2_.x * param1.normal.x + _loc2_.y * param1.normal.y + _loc2_.z * param1.normal.z;
         var _loc4_:Number = param1.contactSeparationSpeed - _loc3_;
         var _loc5_:Number = _loc4_ / param1.normalSpeedDelta;
         if(param1.shape1.body.movable)
         {
            param1.shape1.body.applyWorldPseudoImpulseAtLocalPoint(param1.r1,param1.normal,_loc5_);
         }
         if(param1.shape2.body.movable)
         {
            param1.shape2.body.applyWorldPseudoImpulseAtLocalPoint(param1.r2,param1.normal,-_loc5_);
         }
      }
      
      private function calcPseudoSeparationVelocity(param1:ShapeContact, param2:Vector3) : void
      {
         var _loc4_:Vector3 = null;
         var _loc7_:Number = NaN;
         var _loc3_:Vector3 = param1.shape1.body.pseudoAngularVelocity;
         _loc4_ = param1.r1;
         var _loc5_:Number = _loc3_.y * _loc4_.z - _loc3_.z * _loc4_.y;
         var _loc6_:Number = _loc3_.z * _loc4_.x - _loc3_.x * _loc4_.z;
         _loc7_ = _loc3_.x * _loc4_.y - _loc3_.y * _loc4_.x;
         _loc4_ = param1.shape1.body.pseudoVelocity;
         param2.x = _loc4_.x + _loc5_;
         param2.y = _loc4_.y + _loc6_;
         param2.z = _loc4_.z + _loc7_;
         _loc3_ = param1.shape2.body.pseudoAngularVelocity;
         _loc4_ = param1.r2;
         _loc5_ = _loc3_.y * _loc4_.z - _loc3_.z * _loc4_.y;
         _loc6_ = _loc3_.z * _loc4_.x - _loc3_.x * _loc4_.z;
         _loc7_ = _loc3_.x * _loc4_.y - _loc3_.y * _loc4_.x;
         _loc4_ = param1.shape2.body.pseudoVelocity;
         param2.x -= _loc4_.x + _loc5_;
         param2.y -= _loc4_.y + _loc6_;
         param2.z -= _loc4_.z + _loc7_;
      }
   }
}

