package alternativa.physics.collision.colliders
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.ShapeContact;
   import alternativa.physics.collision.Collider;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.physics.collision.primitives.CollisionTriangle;
   
   public class BoxTriangleCollider implements Collider
   {
      
      public var epsilon:Number;
      
      private var minOverlap:Number;
      
      private const toBox:Vector3 = new Vector3();
      
      private const axis:Vector3 = new Vector3();
      
      private const axis10:Vector3 = new Vector3();
      
      private const axis11:Vector3 = new Vector3();
      
      private const axis12:Vector3 = new Vector3();
      
      private const axis20:Vector3 = new Vector3();
      
      private const axis21:Vector3 = new Vector3();
      
      private const axis22:Vector3 = new Vector3();
      
      private const minOverlapAxis:Vector3 = new Vector3();
      
      private const _basisMatrix:Matrix4 = new Matrix4();
      
      private const boxFaceVertices:Vector.<Vertex> = Vector.<Vertex>([new Vertex(),new Vertex(),new Vertex(),new Vertex()]);
      
      private const triFaceVertices:Vector.<Vertex> = Vector.<Vertex>([new Vertex(),new Vertex(),new Vertex()]);
      
      public function BoxTriangleCollider(param1:Number)
      {
         super();
         this.epsilon = param1;
      }
      
      public function getContacts(param1:CollisionShape, param2:CollisionShape, param3:Vector.<ShapeContact>) : void
      {
         var _loc4_:CollisionTriangle = null;
         var _loc5_:CollisionBox = null;
         if(!this.haveCollision(param1,param2))
         {
            return;
         }
         if(param1 is CollisionBox)
         {
            _loc5_ = CollisionBox(param1);
            _loc4_ = CollisionTriangle(param2);
         }
         else
         {
            _loc5_ = CollisionBox(param2);
            _loc4_ = CollisionTriangle(param1);
         }
         this.findContacts(_loc5_,_loc4_,this.minOverlapAxis,param3);
      }
      
      public function haveCollision(param1:CollisionShape, param2:CollisionShape) : Boolean
      {
         var _loc3_:CollisionTriangle = null;
         var _loc4_:CollisionBox = null;
         var _loc5_:Matrix4 = null;
         var _loc6_:Matrix4 = null;
         var _loc7_:Vector3 = null;
         if(param1 is CollisionBox)
         {
            _loc4_ = CollisionBox(param1);
            _loc3_ = CollisionTriangle(param2);
         }
         else
         {
            _loc4_ = CollisionBox(param2);
            _loc3_ = CollisionTriangle(param1);
         }
         _loc5_ = _loc4_.transform;
         _loc6_ = _loc3_.transform;
         this.toBox.x = _loc5_.m03 - _loc6_.m03;
         this.toBox.y = _loc5_.m13 - _loc6_.m13;
         this.toBox.z = _loc5_.m23 - _loc6_.m23;
         this.minOverlap = 10000000000;
         this.axis.x = _loc6_.m02;
         this.axis.y = _loc6_.m12;
         this.axis.z = _loc6_.m22;
         if(!this.testOverlapOnMainAxis(_loc4_,_loc3_,this.axis,this.toBox))
         {
            return false;
         }
         this.axis10.x = _loc5_.m00;
         this.axis10.y = _loc5_.m10;
         this.axis10.z = _loc5_.m20;
         if(!this.testOverlapOnMainAxis(_loc4_,_loc3_,this.axis10,this.toBox))
         {
            return false;
         }
         this.axis11.x = _loc5_.m01;
         this.axis11.y = _loc5_.m11;
         this.axis11.z = _loc5_.m21;
         if(!this.testOverlapOnMainAxis(_loc4_,_loc3_,this.axis11,this.toBox))
         {
            return false;
         }
         this.axis12.x = _loc5_.m02;
         this.axis12.y = _loc5_.m12;
         this.axis12.z = _loc5_.m22;
         if(!this.testOverlapOnMainAxis(_loc4_,_loc3_,this.axis12,this.toBox))
         {
            return false;
         }
         _loc7_ = _loc3_.e0;
         this.axis20.x = _loc6_.m00 * _loc7_.x + _loc6_.m01 * _loc7_.y + _loc6_.m02 * _loc7_.z;
         this.axis20.y = _loc6_.m10 * _loc7_.x + _loc6_.m11 * _loc7_.y + _loc6_.m12 * _loc7_.z;
         this.axis20.z = _loc6_.m20 * _loc7_.x + _loc6_.m21 * _loc7_.y + _loc6_.m22 * _loc7_.z;
         if(!this.testOverlapOnDerivedAxis(_loc4_,_loc3_,this.axis10,this.axis20,this.toBox))
         {
            return false;
         }
         if(!this.testOverlapOnDerivedAxis(_loc4_,_loc3_,this.axis11,this.axis20,this.toBox))
         {
            return false;
         }
         if(!this.testOverlapOnDerivedAxis(_loc4_,_loc3_,this.axis12,this.axis20,this.toBox))
         {
            return false;
         }
         _loc7_ = _loc3_.e1;
         this.axis21.x = _loc6_.m00 * _loc7_.x + _loc6_.m01 * _loc7_.y + _loc6_.m02 * _loc7_.z;
         this.axis21.y = _loc6_.m10 * _loc7_.x + _loc6_.m11 * _loc7_.y + _loc6_.m12 * _loc7_.z;
         this.axis21.z = _loc6_.m20 * _loc7_.x + _loc6_.m21 * _loc7_.y + _loc6_.m22 * _loc7_.z;
         if(!this.testOverlapOnDerivedAxis(_loc4_,_loc3_,this.axis10,this.axis21,this.toBox))
         {
            return false;
         }
         if(!this.testOverlapOnDerivedAxis(_loc4_,_loc3_,this.axis11,this.axis21,this.toBox))
         {
            return false;
         }
         if(!this.testOverlapOnDerivedAxis(_loc4_,_loc3_,this.axis12,this.axis21,this.toBox))
         {
            return false;
         }
         _loc7_ = _loc3_.e2;
         this.axis22.x = _loc6_.m00 * _loc7_.x + _loc6_.m01 * _loc7_.y + _loc6_.m02 * _loc7_.z;
         this.axis22.y = _loc6_.m10 * _loc7_.x + _loc6_.m11 * _loc7_.y + _loc6_.m12 * _loc7_.z;
         this.axis22.z = _loc6_.m20 * _loc7_.x + _loc6_.m21 * _loc7_.y + _loc6_.m22 * _loc7_.z;
         if(!this.testOverlapOnDerivedAxis(_loc4_,_loc3_,this.axis10,this.axis22,this.toBox))
         {
            return false;
         }
         if(!this.testOverlapOnDerivedAxis(_loc4_,_loc3_,this.axis11,this.axis22,this.toBox))
         {
            return false;
         }
         return this.testOverlapOnDerivedAxis(_loc4_,_loc3_,this.axis12,this.axis22,this.toBox);
      }
      
      private function testOverlapOnMainAxis(param1:CollisionBox, param2:CollisionTriangle, param3:Vector3, param4:Vector3) : Boolean
      {
         var _loc5_:Number = this.getOverlapOnAxis(param1,param2,param3,param4);
         return this.registerOverlap(_loc5_,param3);
      }
      
      private function registerOverlap(param1:Number, param2:Vector3) : Boolean
      {
         if(param1 < this.epsilon)
         {
            return false;
         }
         if(param1 + this.epsilon < this.minOverlap)
         {
            this.minOverlap = param1;
            this.minOverlapAxis.x = param2.x;
            this.minOverlapAxis.y = param2.y;
            this.minOverlapAxis.z = param2.z;
         }
         return true;
      }
      
      private function testOverlapOnDerivedAxis(param1:CollisionBox, param2:CollisionTriangle, param3:Vector3, param4:Vector3, param5:Vector3) : Boolean
      {
         var _loc7_:Number = NaN;
         this.axis.x = param3.y * param4.z - param3.z * param4.y;
         this.axis.y = param3.z * param4.x - param3.x * param4.z;
         this.axis.z = param3.x * param4.y - param3.y * param4.x;
         var _loc6_:Number = this.axis.x * this.axis.x + this.axis.y * this.axis.y + this.axis.z * this.axis.z;
         if(_loc6_ < 1e-10)
         {
            return true;
         }
         _loc7_ = 1 / Math.sqrt(_loc6_);
         this.axis.x *= _loc7_;
         this.axis.y *= _loc7_;
         this.axis.z *= _loc7_;
         var _loc8_:Number = this.getOverlapOnAxis(param1,param2,this.axis,param5);
         return this.registerOverlap(_loc8_,this.axis);
      }
      
      private function getOverlapOnAxis(param1:CollisionBox, param2:CollisionTriangle, param3:Vector3, param4:Vector3) : Number
      {
         var _loc8_:Number = NaN;
         var _loc5_:Matrix4 = param1.transform;
         var _loc6_:Vector3 = param1.hs;
         var _loc7_:Number = 0;
         _loc8_ = (_loc5_.m00 * param3.x + _loc5_.m10 * param3.y + _loc5_.m20 * param3.z) * _loc6_.x;
         if(_loc8_ < 0)
         {
            _loc7_ -= _loc8_;
         }
         else
         {
            _loc7_ += _loc8_;
         }
         _loc8_ = (_loc5_.m01 * param3.x + _loc5_.m11 * param3.y + _loc5_.m21 * param3.z) * _loc6_.y;
         if(_loc8_ < 0)
         {
            _loc7_ -= _loc8_;
         }
         else
         {
            _loc7_ += _loc8_;
         }
         _loc8_ = (_loc5_.m02 * param3.x + _loc5_.m12 * param3.y + _loc5_.m22 * param3.z) * _loc6_.z;
         if(_loc8_ < 0)
         {
            _loc7_ -= _loc8_;
         }
         else
         {
            _loc7_ += _loc8_;
         }
         var _loc9_:Number = param4.x * param3.x + param4.y * param3.y + param4.z * param3.z;
         var _loc10_:Matrix4 = param2.transform;
         var _loc11_:Number = _loc10_.m00 * param3.x + _loc10_.m10 * param3.y + _loc10_.m20 * param3.z;
         var _loc12_:Number = _loc10_.m01 * param3.x + _loc10_.m11 * param3.y + _loc10_.m21 * param3.z;
         var _loc13_:Number = _loc10_.m02 * param3.x + _loc10_.m12 * param3.y + _loc10_.m22 * param3.z;
         var _loc14_:Number = 0;
         var _loc15_:Vector3 = param2.v0;
         var _loc16_:Vector3 = param2.v1;
         var _loc17_:Vector3 = param2.v2;
         if(_loc9_ < 0)
         {
            _loc9_ = -_loc9_;
            _loc8_ = _loc15_.x * _loc11_ + _loc15_.y * _loc12_ + _loc15_.z * _loc13_;
            if(_loc8_ < _loc14_)
            {
               _loc14_ = _loc8_;
            }
            _loc8_ = _loc16_.x * _loc11_ + _loc16_.y * _loc12_ + _loc16_.z * _loc13_;
            if(_loc8_ < _loc14_)
            {
               _loc14_ = _loc8_;
            }
            _loc8_ = _loc17_.x * _loc11_ + _loc17_.y * _loc12_ + _loc17_.z * _loc13_;
            if(_loc8_ < _loc14_)
            {
               _loc14_ = _loc8_;
            }
            _loc14_ = -_loc14_;
         }
         else
         {
            _loc8_ = _loc15_.x * _loc11_ + _loc15_.y * _loc12_ + _loc15_.z * _loc13_;
            if(_loc8_ > _loc14_)
            {
               _loc14_ = _loc8_;
            }
            _loc8_ = _loc16_.x * _loc11_ + _loc16_.y * _loc12_ + _loc16_.z * _loc13_;
            if(_loc8_ > _loc14_)
            {
               _loc14_ = _loc8_;
            }
            _loc8_ = _loc17_.x * _loc11_ + _loc17_.y * _loc12_ + _loc17_.z * _loc13_;
            if(_loc8_ > _loc14_)
            {
               _loc14_ = _loc8_;
            }
         }
         return _loc7_ + _loc14_ - _loc9_;
      }
      
      private function findContacts(param1:CollisionBox, param2:CollisionTriangle, param3:Vector3, param4:Vector.<ShapeContact>) : void
      {
         var _loc6_:Matrix4 = null;
         var _loc7_:Vector3 = null;
         var _loc12_:ShapeContact = null;
         var _loc13_:Vector3 = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc5_:Matrix4 = param1.transform;
         _loc6_ = param2.transform;
         _loc7_ = this.toBox;
         _loc7_.x = _loc5_.m03 - _loc6_.m03;
         _loc7_.y = _loc5_.m13 - _loc6_.m13;
         _loc7_.z = _loc5_.m23 - _loc6_.m23;
         if(param3.x * _loc7_.x + param3.y * _loc7_.y + param3.z * _loc7_.z < 0)
         {
            param3.x = -param3.x;
            param3.y = -param3.y;
            param3.z = -param3.z;
         }
         var _loc8_:Matrix4 = this._basisMatrix;
         ColliderUtils.buildContactBasis(param3,_loc5_,_loc6_,_loc8_);
         ColliderUtils.getBoxFaceVerticesInCCWOrder(param1,param3,FaceSide.BACK,this.boxFaceVertices);
         ColliderUtils.getTriangleFaceInCCWOrder(param2,param3,this.triFaceVertices);
         ColliderUtils.transformFaceToReferenceSpace(_loc8_,_loc5_,this.boxFaceVertices,4);
         ColliderUtils.transformFaceToReferenceSpace(_loc8_,_loc6_,this.triFaceVertices,3);
         var _loc9_:int = int(param4.length);
         PolygonsIntersectionUtils.findContacts(param1,this.boxFaceVertices,4,param2,this.triFaceVertices,3,_loc8_,param4);
         var _loc10_:int = int(param4.length);
         var _loc11_:int = _loc9_;
         while(_loc11_ < _loc10_)
         {
            _loc12_ = param4[_loc11_];
            _loc13_ = _loc12_.normal;
            _loc14_ = _loc6_.m02;
            _loc15_ = _loc6_.m12;
            _loc16_ = _loc6_.m22;
            if(_loc13_.x * _loc14_ + _loc13_.y * _loc15_ + _loc13_.z * _loc16_ < 0)
            {
               _loc12_.dispose();
               _loc10_--;
               param4[_loc11_] = param4[_loc10_];
               param4[_loc10_] = null;
               _loc11_--;
            }
            _loc11_++;
         }
         if(_loc10_ < param4.length)
         {
            param4.length = _loc10_;
         }
      }
   }
}

