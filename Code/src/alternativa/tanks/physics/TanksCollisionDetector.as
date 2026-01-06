package alternativa.tanks.physics
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.BodyContact;
   import alternativa.physics.ShapeContact;
   import alternativa.physics.collision.Collider;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.physics.collision.CollisionKdNode;
   import alternativa.physics.collision.CollisionKdTree;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.physics.collision.IRayCollisionFilter;
   import alternativa.physics.collision.colliders.BoxBoxCollider;
   import alternativa.physics.collision.colliders.BoxRectCollider;
   import alternativa.physics.collision.colliders.BoxSphereCollider;
   import alternativa.physics.collision.colliders.BoxTriangleCollider;
   import alternativa.physics.collision.types.AABB;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.objects.tank.Tank;
   
   public class TanksCollisionDetector implements CollisionDetector
   {
      
      private static const AABB_INTERSECTION_EPSILON:Number = 0.01;
      
      private const colliders:Object = {};
      
      private const _rayHit:RayHit = new RayHit();
      
      private const _time:MinMax = new MinMax();
      
      private const _normal:Vector3 = new Vector3();
      
      private const _o:Vector3 = new Vector3();
      
      private const _dynamicRayHit:RayHit = new RayHit();
      
      private const _rayAABB:AABB = new AABB();
      
      private const shapeContacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();
      
      private var tree:CollisionKdTree = new CollisionKdTree();
      
      private var threshold:Number = 0.0001;
      
      private var tankBodies:Vector.<TankBody> = new Vector.<TankBody>();
      
      private var staticBody:Body;
      
      public function TanksCollisionDetector()
      {
         super();
         var _loc1_:Number = 0.000001;
         this.setCollider(CollisionShape.BOX,CollisionShape.BOX,new BoxBoxCollider(_loc1_));
         this.setCollider(CollisionShape.BOX,CollisionShape.RECT,new BoxRectCollider(_loc1_));
         this.setCollider(CollisionShape.BOX,CollisionShape.TRIANGLE,new BoxTriangleCollider(_loc1_));
         this.setCollider(CollisionShape.BOX,CollisionShape.SPHERE,new BoxSphereCollider());
         this.createStaticBody();
      }
      
      private function setCollider(param1:int, param2:int, param3:Collider) : void
      {
         this.colliders[param1 | param2] = param3;
      }
      
      private function createStaticBody() : void
      {
         this.staticBody = new Body(1,new Matrix3(),10000000000);
         this.staticBody.movable = false;
      }
      
      public function buildKdTree(param1:Vector.<CollisionShape>, param2:AABB = null) : void
      {
         var _loc3_:CollisionShape = null;
         for each(_loc3_ in param1)
         {
            _loc3_.body = this.staticBody;
         }
         this.tree.createTree(param1,param2);
      }
      
      public function addTankBody(param1:TankBody) : void
      {
         param1.hasContactsWithStatic = false;
         this.tankBodies.push(param1);
      }
      
      public function removeTankBody(param1:TankBody) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(this.tankBodies.indexOf(param1));
         if(_loc2_ > -1)
         {
            _loc3_ = this.tankBodies.length - 1;
            this.tankBodies[_loc2_] = this.tankBodies[_loc3_];
            this.tankBodies.length = _loc3_;
         }
      }
      
      public function getTankBodies() : Vector.<TankBody>
      {
         return this.tankBodies;
      }
      
      public function getBodyContacts(param1:Vector.<BodyContact>) : void
      {
         var _loc4_:TankBody = null;
         var _loc5_:Tank = null;
         var _loc6_:int = 0;
         var _loc2_:int = int(this.tankBodies.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.tankBodies[_loc3_];
            _loc4_.wasContactWithStatic = _loc4_.hasContactsWithStatic;
            _loc5_ = _loc4_.body.tank;
            _loc4_.hasContactsWithStatic = _loc5_.hasTracksContactsWithStatic();
            _loc4_.penetratedBodies.length = 0;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.tankBodies[_loc3_];
            _loc6_ = int(param1.length);
            this.getContactsWithStatic(_loc4_,param1);
            if(_loc6_ != param1.length)
            {
               _loc4_.hasContactsWithStatic = true;
            }
            _loc6_ = int(param1.length);
            this.getContactsWithOtherBodies(_loc4_,_loc3_ + 1,param1);
            _loc3_++;
         }
      }
      
      public function getShapeContactsWithStatic(param1:CollisionShape, param2:Vector.<ShapeContact>) : void
      {
         return this.getShapeNodeCollisions(this.tree.rootNode,param1,param2);
      }
      
      private function getContactsWithStatic(param1:TankBody, param2:Vector.<BodyContact>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:BodyContact = null;
         if(!param1.body.frozen)
         {
            _loc3_ = int(param1.staticShapes.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this.getShapeNodeCollisions(this.tree.rootNode,param1.staticShapes[_loc4_],this.shapeContacts);
               _loc4_++;
            }
            if(this.shapeContacts.length > 0)
            {
               _loc5_ = BodyContact.create();
               _loc5_.body1 = param1.body;
               _loc5_.body2 = this.staticBody;
               _loc5_.setShapeContacts(this.shapeContacts);
               this.shapeContacts.length = 0;
               param2[param2.length] = _loc5_;
            }
         }
      }
      
      private function getContactsWithOtherBodies(param1:TankBody, param2:int, param3:Vector.<BodyContact>) : void
      {
         var _loc6_:TankBody = null;
         var _loc7_:Body = null;
         var _loc8_:Body = null;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:BodyContact = null;
         var _loc13_:int = 0;
         var _loc14_:ShapeContact = null;
         var _loc4_:int = int(this.tankBodies.length);
         var _loc5_:int = param2;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = this.tankBodies[_loc5_];
            _loc7_ = param1.body;
            _loc8_ = _loc6_.body;
            if(!(_loc7_.frozen && _loc8_.frozen) && _loc7_.aabb.intersects(_loc8_.aabb,AABB_INTERSECTION_EPSILON))
            {
               this.getContacts(param1.tankCollisionBox,_loc6_.tankCollisionBox,this.shapeContacts);
               _loc9_ = int(this.shapeContacts.length);
               if(_loc9_ > 0)
               {
                  _loc10_ = _loc7_.postCollisionFilter == null || Boolean(_loc7_.postCollisionFilter.considerBodies(_loc7_,_loc8_));
                  _loc11_ = _loc8_.postCollisionFilter == null || Boolean(_loc8_.postCollisionFilter.considerBodies(_loc8_,_loc7_));
                  if(_loc10_ && _loc11_)
                  {
                     _loc12_ = BodyContact.create();
                     _loc12_.body1 = _loc7_;
                     _loc12_.body2 = _loc8_;
                     _loc12_.setShapeContacts(this.shapeContacts);
                     param3[param3.length] = _loc12_;
                     param1.penetratedBodies.push(_loc8_);
                     _loc6_.penetratedBodies.push(_loc7_);
                  }
                  else
                  {
                     _loc13_ = 0;
                     while(_loc13_ < _loc9_)
                     {
                        _loc14_ = this.shapeContacts[_loc13_];
                        _loc14_.dispose();
                        _loc13_++;
                     }
                  }
                  this.shapeContacts.length = 0;
               }
            }
            _loc5_++;
         }
      }
      
      public function getContacts(param1:CollisionShape, param2:CollisionShape, param3:Vector.<ShapeContact>) : void
      {
         if((param1.collisionGroup & param2.collisionGroup) == 0)
         {
            return;
         }
         if(param1.body == param2.body)
         {
            return;
         }
         if(!param1.aabb.intersects(param2.aabb,AABB_INTERSECTION_EPSILON))
         {
            return;
         }
         var _loc4_:Collider = this.colliders[param1.type | param2.type];
         _loc4_.getContacts(param1,param2,param3);
      }
      
      public function testCollision(param1:CollisionShape, param2:CollisionShape) : Boolean
      {
         if((param1.collisionGroup & param2.collisionGroup) == 0)
         {
            return false;
         }
         if(param1.body == param2.body)
         {
            return false;
         }
         if(!param1.aabb.intersects(param2.aabb,AABB_INTERSECTION_EPSILON))
         {
            return false;
         }
         var _loc3_:Collider = this.colliders[param1.type | param2.type];
         return _loc3_.haveCollision(param1,param2);
      }
      
      public function raycast(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter, param6:RayHit) : Boolean
      {
         var _loc7_:Boolean = this.raycastStatic(param1,param2,param3,param4,param5,param6);
         var _loc8_:Boolean = this.raycastDynamic(param1,param2,param3,param4,param5,this._dynamicRayHit);
         if(!(_loc8_ || _loc7_))
         {
            return false;
         }
         if(_loc8_ && _loc7_)
         {
            if(param6.t > this._dynamicRayHit.t)
            {
               param6.copy(this._dynamicRayHit);
            }
            this._dynamicRayHit.clear();
            return true;
         }
         if(_loc7_)
         {
            this._dynamicRayHit.clear();
            return true;
         }
         param6.copy(this._dynamicRayHit);
         this._dynamicRayHit.clear();
         return true;
      }
      
      public function raycastStatic(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter, param6:RayHit) : Boolean
      {
         if(!this.getRayBoundBoxIntersection(param1,param2,this.tree.rootNode.boundBox,this._time))
         {
            return false;
         }
         if(this._time.max < 0 || this._time.min > param4)
         {
            return false;
         }
         if(this._time.min <= 0)
         {
            this._time.min = 0;
            this._o.x = param1.x;
            this._o.y = param1.y;
            this._o.z = param1.z;
         }
         else
         {
            this._o.x = param1.x + this._time.min * param2.x;
            this._o.y = param1.y + this._time.min * param2.y;
            this._o.z = param1.z + this._time.min * param2.z;
         }
         if(this._time.max > param4)
         {
            this._time.max = param4;
         }
         var _loc7_:Boolean = this.testRayAgainstNode(this.tree.rootNode,param1,this._o,param2,param3,this._time.min,this._time.max,param5,param6);
         return _loc7_ ? param6.t <= param4 : false;
      }
      
      public function hasStaticHit(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter = null) : Boolean
      {
         var _loc6_:Boolean = this.raycastStatic(param1,param2,param3,param4,param5,this._rayHit);
         this._rayHit.clear();
         return _loc6_;
      }
      
      private function getShapeNodeCollisions(param1:CollisionKdNode, param2:CollisionShape, param3:Vector.<ShapeContact>) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Vector.<CollisionShape> = null;
         var _loc7_:Vector.<int> = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(param1.indices != null)
         {
            _loc6_ = this.tree.staticChildren;
            _loc7_ = param1.indices;
            _loc8_ = int(_loc7_.length);
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               this.getContacts(param2,_loc6_[_loc7_[_loc9_]],param3);
               _loc9_++;
            }
         }
         if(param1.axis == -1)
         {
            return;
         }
         switch(param1.axis)
         {
            case 0:
               _loc4_ = param2.aabb.minX;
               _loc5_ = param2.aabb.maxX;
               break;
            case 1:
               _loc4_ = param2.aabb.minY;
               _loc5_ = param2.aabb.maxY;
               break;
            case 2:
               _loc4_ = param2.aabb.minZ;
               _loc5_ = param2.aabb.maxZ;
         }
         if(_loc4_ < param1.coord)
         {
            this.getShapeNodeCollisions(param1.negativeNode,param2,param3);
         }
         if(_loc5_ > param1.coord)
         {
            this.getShapeNodeCollisions(param1.positiveNode,param2,param3);
         }
         if(param1.splitTree != null && _loc4_ < param1.coord && _loc5_ > param1.coord)
         {
            this.getShapeNodeCollisions(param1.splitTree.rootNode,param2,param3);
         }
      }
      
      private function testShapeNodeCollision(param1:CollisionShape, param2:CollisionKdNode) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Vector.<CollisionShape> = null;
         var _loc6_:Vector.<int> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param2.indices != null)
         {
            _loc5_ = this.tree.staticChildren;
            _loc6_ = param2.indices;
            _loc7_ = int(_loc6_.length);
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               if(this.testCollision(param1,_loc5_[_loc6_[_loc8_]]))
               {
                  return true;
               }
               _loc8_++;
            }
         }
         if(param2.axis == -1)
         {
            return false;
         }
         switch(param2.axis)
         {
            case 0:
               _loc3_ = param1.aabb.minX;
               _loc4_ = param1.aabb.maxX;
               break;
            case 1:
               _loc3_ = param1.aabb.minY;
               _loc4_ = param1.aabb.maxY;
               break;
            case 2:
               _loc3_ = param1.aabb.minZ;
               _loc4_ = param1.aabb.maxZ;
         }
         if(param2.splitTree != null && _loc3_ < param2.coord && _loc4_ > param2.coord)
         {
            if(this.testShapeNodeCollision(param1,param2.splitTree.rootNode))
            {
               return true;
            }
         }
         if(_loc3_ < param2.coord)
         {
            if(this.testShapeNodeCollision(param1,param2.negativeNode))
            {
               return true;
            }
         }
         if(_loc4_ > param2.coord)
         {
            if(this.testShapeNodeCollision(param1,param2.positiveNode))
            {
               return true;
            }
         }
         return false;
      }
      
      private function raycastDynamic(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter, param6:RayHit) : Boolean
      {
         var _loc13_:TankBody = null;
         var _loc14_:Body = null;
         var _loc15_:AABB = null;
         var _loc16_:int = 0;
         var _loc17_:CollisionShape = null;
         var _loc18_:Number = NaN;
         var _loc7_:Number = param1.x + param2.x * param4;
         var _loc8_:Number = param1.y + param2.y * param4;
         var _loc9_:Number = param1.z + param2.z * param4;
         if(_loc7_ < param1.x)
         {
            this._rayAABB.minX = _loc7_;
            this._rayAABB.maxX = param1.x;
         }
         else
         {
            this._rayAABB.minX = param1.x;
            this._rayAABB.maxX = _loc7_;
         }
         if(_loc8_ < param1.y)
         {
            this._rayAABB.minY = _loc8_;
            this._rayAABB.maxY = param1.y;
         }
         else
         {
            this._rayAABB.minY = param1.y;
            this._rayAABB.maxY = _loc8_;
         }
         if(_loc9_ < param1.z)
         {
            this._rayAABB.minZ = _loc9_;
            this._rayAABB.maxZ = param1.z;
         }
         else
         {
            this._rayAABB.minZ = param1.z;
            this._rayAABB.maxZ = _loc9_;
         }
         var _loc10_:Number = param4 + 1;
         var _loc11_:int = int(this.tankBodies.length);
         var _loc12_:int = 0;
         while(_loc12_ < _loc11_)
         {
            _loc13_ = this.tankBodies[_loc12_];
            _loc14_ = _loc13_.body;
            _loc15_ = _loc14_.aabb;
            if(!(this._rayAABB.maxX < _loc15_.minX || this._rayAABB.minX > _loc15_.maxX || this._rayAABB.maxY < _loc15_.minY || this._rayAABB.minY > _loc15_.maxY || this._rayAABB.maxZ < _loc15_.minZ || this._rayAABB.minZ > _loc15_.maxZ))
            {
               _loc16_ = 0;
               while(_loc16_ < _loc14_.numCollisionShapes)
               {
                  _loc17_ = _loc14_.collisionShapes[_loc16_];
                  if((_loc17_.collisionGroup & param3) != 0)
                  {
                     _loc15_ = _loc17_.aabb;
                     if(!(this._rayAABB.maxX < _loc15_.minX || this._rayAABB.minX > _loc15_.maxX || this._rayAABB.maxY < _loc15_.minY || this._rayAABB.minY > _loc15_.maxY || this._rayAABB.maxZ < _loc15_.minZ || this._rayAABB.minZ > _loc15_.maxZ))
                     {
                        if(!(param5 != null && !param5.considerBody(_loc14_)))
                        {
                           _loc18_ = _loc17_.raycast(param1,param2,this.threshold,this._normal);
                           if(_loc18_ >= 0 && _loc18_ < _loc10_)
                           {
                              _loc10_ = _loc18_;
                              param6.shape = _loc17_;
                              param6.normal.x = this._normal.x;
                              param6.normal.y = this._normal.y;
                              param6.normal.z = this._normal.z;
                           }
                        }
                     }
                  }
                  _loc16_++;
               }
            }
            _loc12_++;
         }
         if(_loc10_ > param4)
         {
            return false;
         }
         param6.position.x = param1.x + param2.x * _loc10_;
         param6.position.y = param1.y + param2.y * _loc10_;
         param6.position.z = param1.z + param2.z * _loc10_;
         param6.t = _loc10_;
         return true;
      }
      
      private function getRayBoundBoxIntersection(param1:Vector3, param2:Vector3, param3:AABB, param4:MinMax) : Boolean
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         param4.min = -1;
         param4.max = 1e+308;
         var _loc7_:int = 0;
         for(; _loc7_ < 3; _loc7_++)
         {
            switch(_loc7_)
            {
               case 0:
                  if(!(param2.x < this.threshold && param2.x > -this.threshold))
                  {
                     _loc5_ = (param3.minX - param1.x) / param2.x;
                     _loc6_ = (param3.maxX - param1.x) / param2.x;
                     break;
                  }
                  if(param1.x < param3.minX || param1.x > param3.maxX)
                  {
                     return false;
                  }
                  continue;
               case 1:
                  if(!(param2.y < this.threshold && param2.y > -this.threshold))
                  {
                     _loc5_ = (param3.minY - param1.y) / param2.y;
                     _loc6_ = (param3.maxY - param1.y) / param2.y;
                     break;
                  }
                  if(param1.y < param3.minY || param1.y > param3.maxY)
                  {
                     return false;
                  }
                  continue;
               case 2:
                  if(!(param2.z < this.threshold && param2.z > -this.threshold))
                  {
                     _loc5_ = (param3.minZ - param1.z) / param2.z;
                     _loc6_ = (param3.maxZ - param1.z) / param2.z;
                     break;
                  }
                  if(param1.z < param3.minZ || param1.z > param3.maxZ)
                  {
                     return false;
                  }
                  continue;
            }
            if(_loc5_ < _loc6_)
            {
               if(_loc5_ > param4.min)
               {
                  param4.min = _loc5_;
               }
               if(_loc6_ < param4.max)
               {
                  param4.max = _loc6_;
               }
            }
            else
            {
               if(_loc6_ > param4.min)
               {
                  param4.min = _loc6_;
               }
               if(_loc5_ < param4.max)
               {
                  param4.max = _loc5_;
               }
            }
            if(param4.max < param4.min)
            {
               return false;
            }
         }
         return true;
      }
      
      private function testRayAgainstNode(param1:CollisionKdNode, param2:Vector3, param3:Vector3, param4:Vector3, param5:int, param6:Number, param7:Number, param8:IRayCollisionFilter, param9:RayHit) : Boolean
      {
         var _loc10_:Number = NaN;
         var _loc11_:CollisionKdNode = null;
         var _loc12_:Boolean = false;
         var _loc13_:CollisionKdNode = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:CollisionShape = null;
         if(param1.indices != null && this.getRayNodeIntersection(param2,param4,param5,this.tree.staticChildren,param1.indices,param8,param9))
         {
            return true;
         }
         if(param1.axis == -1)
         {
            return false;
         }
         switch(param1.axis)
         {
            case 0:
               if(param4.x > -this.threshold && param4.x < this.threshold)
               {
                  _loc10_ = param7 + 1;
               }
               else
               {
                  _loc10_ = (param1.coord - param2.x) / param4.x;
               }
               _loc11_ = param3.x < param1.coord ? param1.negativeNode : param1.positiveNode;
               break;
            case 1:
               if(param4.y > -this.threshold && param4.y < this.threshold)
               {
                  _loc10_ = param7 + 1;
               }
               else
               {
                  _loc10_ = (param1.coord - param2.y) / param4.y;
               }
               _loc11_ = param3.y < param1.coord ? param1.negativeNode : param1.positiveNode;
               break;
            case 2:
               if(param4.z > -this.threshold && param4.z < this.threshold)
               {
                  _loc10_ = param7 + 1;
               }
               else
               {
                  _loc10_ = (param1.coord - param2.z) / param4.z;
               }
               _loc11_ = param3.z < param1.coord ? param1.negativeNode : param1.positiveNode;
         }
         if(_loc10_ < param6 || _loc10_ > param7)
         {
            return this.testRayAgainstNode(_loc11_,param2,param3,param4,param5,param6,param7,param8,param9);
         }
         _loc12_ = this.testRayAgainstNode(_loc11_,param2,param3,param4,param5,param6,_loc10_,param8,param9);
         if(_loc12_)
         {
            return true;
         }
         this._o.x = param2.x + _loc10_ * param4.x;
         this._o.y = param2.y + _loc10_ * param4.y;
         this._o.z = param2.z + _loc10_ * param4.z;
         if(param1.splitTree != null)
         {
            _loc13_ = param1.splitTree.rootNode;
            while(_loc13_ != null && _loc13_.axis != -1)
            {
               switch(_loc13_.axis)
               {
                  case 0:
                     _loc13_ = this._o.x < _loc13_.coord ? _loc13_.negativeNode : _loc13_.positiveNode;
                     break;
                  case 1:
                     _loc13_ = this._o.y < _loc13_.coord ? _loc13_.negativeNode : _loc13_.positiveNode;
                     break;
                  case 2:
                     _loc13_ = this._o.z < _loc13_.coord ? _loc13_.negativeNode : _loc13_.positiveNode;
               }
            }
            if(_loc13_ != null && _loc13_.indices != null)
            {
               _loc14_ = int(_loc13_.indices.length);
               _loc15_ = 0;
               while(_loc15_ < _loc14_)
               {
                  _loc16_ = this.tree.staticChildren[_loc13_.indices[_loc15_]];
                  if((_loc16_.collisionGroup & param5) != 0)
                  {
                     if(!(param8 != null && !param8.considerBody(_loc16_.body)))
                     {
                        param9.t = _loc16_.raycast(param2,param4,this.threshold,param9.normal);
                        if(param9.t >= 0)
                        {
                           param9.position.copy(this._o);
                           param9.shape = _loc16_;
                           return true;
                        }
                     }
                  }
                  _loc15_++;
               }
            }
         }
         return this.testRayAgainstNode(_loc11_ == param1.negativeNode ? param1.positiveNode : param1.negativeNode,param2,this._o,param4,param5,_loc10_,param7,param8,param9);
      }
      
      private function getRayNodeIntersection(param1:Vector3, param2:Vector3, param3:int, param4:Vector.<CollisionShape>, param5:Vector.<int>, param6:IRayCollisionFilter, param7:RayHit) : Boolean
      {
         var _loc11_:CollisionShape = null;
         var _loc12_:Number = NaN;
         var _loc8_:int = int(param5.length);
         var _loc9_:Number = 1e+308;
         var _loc10_:int = 0;
         while(_loc10_ < _loc8_)
         {
            _loc11_ = param4[param5[_loc10_]];
            if((_loc11_.collisionGroup & param3) != 0)
            {
               if(!(param6 != null && !param6.considerBody(_loc11_.body)))
               {
                  _loc12_ = _loc11_.raycast(param1,param2,this.threshold,this._normal);
                  if(_loc12_ > 0 && _loc12_ < _loc9_)
                  {
                     _loc9_ = _loc12_;
                     param7.shape = _loc11_;
                     param7.normal.x = this._normal.x;
                     param7.normal.y = this._normal.y;
                     param7.normal.z = this._normal.z;
                  }
               }
            }
            _loc10_++;
         }
         if(_loc9_ == 1e+308)
         {
            return false;
         }
         param7.position.x = param1.x + param2.x * _loc9_;
         param7.position.y = param1.y + param2.y * _loc9_;
         param7.position.z = param1.z + param2.z * _loc9_;
         param7.t = _loc9_;
         return true;
      }
      
      public function testStaticCollision(param1:CollisionShape) : Boolean
      {
         return this.testShapeNodeCollision(param1,this.tree.rootNode);
      }
      
      public function destroy() : void
      {
         var _loc1_:TankBody = null;
         this.tree.destroyTree();
         this.tree = null;
         for each(_loc1_ in this.tankBodies)
         {
            _loc1_.destroy();
         }
         this.tankBodies.length = 0;
         this.staticBody = null;
      }
   }
}

