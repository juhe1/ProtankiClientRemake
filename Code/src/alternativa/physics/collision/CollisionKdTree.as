package alternativa.physics.collision
{
   import alternativa.physics.collision.types.AABB;
   
   public class CollisionKdTree
   {
      
      private static const nodeBoundBoxThreshold:AABB = new AABB();
      
      private static const splitCoordsX:Vector.<Number> = new Vector.<Number>();
      
      private static const splitCoordsY:Vector.<Number> = new Vector.<Number>();
      
      private static const splitCoordsZ:Vector.<Number> = new Vector.<Number>();
      
      private static const _nodeBB:Vector.<Number> = new Vector.<Number>(6);
      
      private static const _bb:Vector.<Number> = new Vector.<Number>(6);
      
      public var threshold:Number = 0.1;
      
      public var minPrimitivesPerNode:int = 1;
      
      public var rootNode:CollisionKdNode;
      
      public var staticChildren:Vector.<CollisionShape>;
      
      public var numStaticChildren:int;
      
      public var staticBoundBoxes:Vector.<AABB> = new Vector.<AABB>();
      
      private var splitAxis:int;
      
      private var splitCoord:Number;
      
      private var splitCost:Number;
      
      public function CollisionKdTree()
      {
         super();
      }
      
      public function createTree(param1:Vector.<CollisionShape>, param2:AABB = null) : void
      {
         var _loc5_:CollisionShape = null;
         var _loc6_:AABB = null;
         this.staticChildren = param1.concat();
         this.numStaticChildren = this.staticChildren.length;
         this.rootNode = new CollisionKdNode();
         this.rootNode.indices = new Vector.<int>();
         var _loc3_:AABB = this.rootNode.boundBox = param2 != null ? param2 : new AABB();
         var _loc4_:int = 0;
         while(_loc4_ < this.numStaticChildren)
         {
            _loc5_ = this.staticChildren[_loc4_];
            _loc6_ = this.staticBoundBoxes[_loc4_] = _loc5_.calculateAABB();
            _loc3_.addBoundBox(_loc6_);
            this.rootNode.indices[_loc4_] = _loc4_;
            _loc4_++;
         }
         this.staticBoundBoxes.length = this.numStaticChildren;
         this.splitNode(this.rootNode);
         splitCoordsX.length = splitCoordsY.length = splitCoordsZ.length = 0;
      }
      
      private function splitNode(param1:CollisionKdNode) : void
      {
         var _loc4_:AABB = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc15_:AABB = null;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc2_:Vector.<int> = param1.indices;
         var _loc3_:int = int(_loc2_.length);
         if(_loc3_ <= this.minPrimitivesPerNode)
         {
            return;
         }
         _loc4_ = param1.boundBox;
         nodeBoundBoxThreshold.minX = _loc4_.minX + this.threshold;
         nodeBoundBoxThreshold.minY = _loc4_.minY + this.threshold;
         nodeBoundBoxThreshold.minZ = _loc4_.minZ + this.threshold;
         nodeBoundBoxThreshold.maxX = _loc4_.maxX - this.threshold;
         nodeBoundBoxThreshold.maxY = _loc4_.maxY - this.threshold;
         nodeBoundBoxThreshold.maxZ = _loc4_.maxZ - this.threshold;
         var _loc5_:Number = this.threshold * 2;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc15_ = this.staticBoundBoxes[_loc2_[_loc6_]];
            if(_loc15_.maxX - _loc15_.minX <= _loc5_)
            {
               if(_loc15_.minX <= nodeBoundBoxThreshold.minX)
               {
                  splitCoordsX[_loc8_++] = _loc4_.minX;
               }
               else if(_loc15_.maxX >= nodeBoundBoxThreshold.maxX)
               {
                  splitCoordsX[_loc8_++] = _loc4_.maxX;
               }
               else
               {
                  splitCoordsX[_loc8_++] = (_loc15_.minX + _loc15_.maxX) * 0.5;
               }
            }
            else
            {
               if(_loc15_.minX > nodeBoundBoxThreshold.minX)
               {
                  splitCoordsX[_loc8_++] = _loc15_.minX;
               }
               if(_loc15_.maxX < nodeBoundBoxThreshold.maxX)
               {
                  splitCoordsX[_loc8_++] = _loc15_.maxX;
               }
            }
            if(_loc15_.maxY - _loc15_.minY <= _loc5_)
            {
               if(_loc15_.minY <= nodeBoundBoxThreshold.minY)
               {
                  splitCoordsY[_loc9_++] = _loc4_.minY;
               }
               else if(_loc15_.maxY >= nodeBoundBoxThreshold.maxY)
               {
                  splitCoordsY[_loc9_++] = _loc4_.maxY;
               }
               else
               {
                  splitCoordsY[_loc9_++] = (_loc15_.minY + _loc15_.maxY) * 0.5;
               }
            }
            else
            {
               if(_loc15_.minY > nodeBoundBoxThreshold.minY)
               {
                  splitCoordsY[_loc9_++] = _loc15_.minY;
               }
               if(_loc15_.maxY < nodeBoundBoxThreshold.maxY)
               {
                  splitCoordsY[_loc9_++] = _loc15_.maxY;
               }
            }
            if(_loc15_.maxZ - _loc15_.minZ <= _loc5_)
            {
               if(_loc15_.minZ <= nodeBoundBoxThreshold.minZ)
               {
                  splitCoordsZ[_loc10_++] = _loc4_.minZ;
               }
               else if(_loc15_.maxZ >= nodeBoundBoxThreshold.maxZ)
               {
                  splitCoordsZ[_loc10_++] = _loc4_.maxZ;
               }
               else
               {
                  splitCoordsZ[_loc10_++] = (_loc15_.minZ + _loc15_.maxZ) * 0.5;
               }
            }
            else
            {
               if(_loc15_.minZ > nodeBoundBoxThreshold.minZ)
               {
                  splitCoordsZ[_loc10_++] = _loc15_.minZ;
               }
               if(_loc15_.maxZ < nodeBoundBoxThreshold.maxZ)
               {
                  splitCoordsZ[_loc10_++] = _loc15_.maxZ;
               }
            }
            _loc6_++;
         }
         this.splitAxis = -1;
         this.splitCost = 1e+308;
         _nodeBB[0] = _loc4_.minX;
         _nodeBB[1] = _loc4_.minY;
         _nodeBB[2] = _loc4_.minZ;
         _nodeBB[3] = _loc4_.maxX;
         _nodeBB[4] = _loc4_.maxY;
         _nodeBB[5] = _loc4_.maxZ;
         this.checkNodeAxis(param1,0,_loc8_,splitCoordsX,_nodeBB);
         this.checkNodeAxis(param1,1,_loc9_,splitCoordsY,_nodeBB);
         this.checkNodeAxis(param1,2,_loc10_,splitCoordsZ,_nodeBB);
         if(this.splitAxis < 0)
         {
            return;
         }
         var _loc11_:Boolean = this.splitAxis == 0;
         var _loc12_:Boolean = this.splitAxis == 1;
         param1.axis = this.splitAxis;
         param1.coord = this.splitCoord;
         param1.negativeNode = new CollisionKdNode();
         param1.negativeNode.parent = param1;
         param1.negativeNode.boundBox = _loc4_.clone();
         param1.positiveNode = new CollisionKdNode();
         param1.positiveNode.parent = param1;
         param1.positiveNode.boundBox = _loc4_.clone();
         if(_loc11_)
         {
            param1.negativeNode.boundBox.maxX = param1.positiveNode.boundBox.minX = this.splitCoord;
         }
         else if(_loc12_)
         {
            param1.negativeNode.boundBox.maxY = param1.positiveNode.boundBox.minY = this.splitCoord;
         }
         else
         {
            param1.negativeNode.boundBox.maxZ = param1.positiveNode.boundBox.minZ = this.splitCoord;
         }
         var _loc13_:Number = this.splitCoord - this.threshold;
         var _loc14_:Number = this.splitCoord + this.threshold;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc15_ = this.staticBoundBoxes[_loc2_[_loc6_]];
            _loc16_ = _loc11_ ? _loc15_.minX : (_loc12_ ? _loc15_.minY : _loc15_.minZ);
            _loc17_ = _loc11_ ? _loc15_.maxX : (_loc12_ ? _loc15_.maxY : _loc15_.maxZ);
            if(_loc17_ <= _loc14_)
            {
               if(_loc16_ < _loc13_)
               {
                  if(param1.negativeNode.indices == null)
                  {
                     param1.negativeNode.indices = new Vector.<int>();
                  }
                  param1.negativeNode.indices.push(_loc2_[_loc6_]);
                  _loc2_[_loc6_] = -1;
               }
               else
               {
                  if(param1.splitIndices == null)
                  {
                     param1.splitIndices = new Vector.<int>();
                  }
                  param1.splitIndices.push(_loc2_[_loc6_]);
                  _loc2_[_loc6_] = -1;
               }
            }
            else if(_loc16_ >= _loc13_)
            {
               if(param1.positiveNode.indices == null)
               {
                  param1.positiveNode.indices = new Vector.<int>();
               }
               param1.positiveNode.indices.push(_loc2_[_loc6_]);
               _loc2_[_loc6_] = -1;
            }
            _loc6_++;
         }
         _loc6_ = 0;
         _loc7_ = 0;
         while(_loc6_ < _loc3_)
         {
            if(_loc2_[_loc6_] >= 0)
            {
               _loc2_[_loc7_++] = _loc2_[_loc6_];
            }
            _loc6_++;
         }
         if(_loc7_ > 0)
         {
            _loc2_.length = _loc7_;
         }
         else
         {
            param1.indices = null;
         }
         if(param1.splitIndices != null)
         {
            param1.splitTree = new CollisionKdTree2D(this,param1);
            param1.splitTree.createTree();
         }
         if(param1.negativeNode.indices != null)
         {
            this.splitNode(param1.negativeNode);
         }
         if(param1.positiveNode.indices != null)
         {
            this.splitNode(param1.positiveNode);
         }
      }
      
      private function checkNodeAxis(param1:CollisionKdNode, param2:int, param3:int, param4:Vector.<Number>, param5:Vector.<Number>) : void
      {
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Boolean = false;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:Number = NaN;
         var _loc21_:AABB = null;
         var _loc6_:int = (param2 + 1) % 3;
         var _loc7_:int = (param2 + 2) % 3;
         var _loc8_:Number = (param5[_loc6_ + 3] - param5[_loc6_]) * (param5[_loc7_ + 3] - param5[_loc7_]);
         var _loc9_:int = 0;
         while(_loc9_ < param3)
         {
            _loc10_ = param4[_loc9_];
            if(!isNaN(_loc10_))
            {
               _loc11_ = _loc10_ - this.threshold;
               _loc12_ = _loc10_ + this.threshold;
               _loc13_ = _loc8_ * (_loc10_ - param5[param2]);
               _loc14_ = _loc8_ * (param5[int(param2 + 3)] - _loc10_);
               _loc15_ = 0;
               _loc16_ = 0;
               _loc17_ = false;
               _loc18_ = int(param1.indices.length);
               _loc19_ = 0;
               while(_loc19_ < _loc18_)
               {
                  _loc21_ = this.staticBoundBoxes[param1.indices[_loc19_]];
                  _bb[0] = _loc21_.minX;
                  _bb[1] = _loc21_.minY;
                  _bb[2] = _loc21_.minZ;
                  _bb[3] = _loc21_.maxX;
                  _bb[4] = _loc21_.maxY;
                  _bb[5] = _loc21_.maxZ;
                  if(_bb[param2 + 3] <= _loc12_)
                  {
                     if(_bb[param2] < _loc11_)
                     {
                        _loc15_++;
                     }
                  }
                  else
                  {
                     if(_bb[param2] < _loc11_)
                     {
                        _loc17_ = true;
                        break;
                     }
                     _loc16_++;
                  }
                  _loc19_++;
               }
               _loc20_ = _loc13_ * _loc15_ + _loc14_ * _loc16_;
               if(!_loc17_ && _loc20_ < this.splitCost && _loc15_ > 0 && _loc16_ > 0)
               {
                  this.splitAxis = param2;
                  this.splitCost = _loc20_;
                  this.splitCoord = _loc10_;
               }
               _loc19_ = _loc9_ + 1;
               while(_loc19_ < param3)
               {
                  if(param4[_loc19_] >= _loc10_ - this.threshold && param4[_loc19_] <= _loc10_ + this.threshold)
                  {
                     param4[_loc19_] = NaN;
                  }
                  _loc19_++;
               }
            }
            _loc9_++;
         }
      }
      
      public function traceTree() : void
      {
         this.traceNode("",this.rootNode);
      }
      
      private function traceNode(param1:String, param2:CollisionKdNode) : void
      {
         if(param2 == null)
         {
            return;
         }
         this.traceNode(param1 + "-",param2.negativeNode);
         this.traceNode(param1 + "+",param2.positiveNode);
      }
      
      public function destroyTree() : void
      {
         if(Boolean(this.rootNode))
         {
            this.rootNode.destroy();
            this.rootNode = null;
         }
         if(Boolean(this.staticChildren))
         {
            this.staticChildren.length = 0;
            this.staticChildren = null;
         }
         this.staticBoundBoxes.length = 0;
      }
   }
}

