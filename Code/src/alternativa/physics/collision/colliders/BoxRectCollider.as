package alternativa.physics.collision.colliders
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.ShapeContact;
   import alternativa.physics.collision.Collider;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.physics.collision.primitives.CollisionRect;
   
   public class BoxRectCollider implements Collider
   {
      
      private static const boxFaceVertices:Vector.<Vertex> = Vector.<Vertex>([new Vertex(),new Vertex(),new Vertex(),new Vertex()]);
      
      private static const rectFaceVertices:Vector.<Vertex> = Vector.<Vertex>([new Vertex(),new Vertex(),new Vertex(),new Vertex()]);
      
      private static const _basisMatrix:Matrix4 = new Matrix4();
      
      private const _vectorToBox:Vector3 = new Vector3();
      
      private const _axis:Vector3 = new Vector3();
      
      private const axis10:Vector3 = new Vector3();
      
      private const axis11:Vector3 = new Vector3();
      
      private const axis12:Vector3 = new Vector3();
      
      private const axis20:Vector3 = new Vector3();
      
      private const axis21:Vector3 = new Vector3();
      
      private const axis22:Vector3 = new Vector3();
      
      private const minOverlapAxis:Vector3 = new Vector3();
      
      private var minOverlap:Number;
      
      private var epsilon:Number;
      
      public function BoxRectCollider(param1:Number)
      {
         super();
         this.epsilon = param1;
      }
      
      public function getContacts(param1:CollisionShape, param2:CollisionShape, param3:Vector.<ShapeContact>) : void
      {
         var _loc4_:CollisionRect = null;
         var _loc5_:CollisionBox = null;
         if(this.haveCollision(param1,param2))
         {
            if(param1 is CollisionRect)
            {
               _loc4_ = CollisionRect(param1);
               _loc5_ = CollisionBox(param2);
            }
            else
            {
               _loc4_ = CollisionRect(param2);
               _loc5_ = CollisionBox(param1);
            }
            this.findContacts(_loc5_,_loc4_,this.minOverlapAxis,param3);
         }
      }
      
      public function haveCollision(param1:CollisionShape, param2:CollisionShape) : Boolean
      {
         var _loc3_:CollisionBox = null;
         var _loc4_:CollisionRect = null;
         this.minOverlap = 10000000000;
         if(param1 is CollisionBox)
         {
            _loc3_ = CollisionBox(param1);
            _loc4_ = CollisionRect(param2);
         }
         else
         {
            _loc3_ = CollisionBox(param2);
            _loc4_ = CollisionRect(param1);
         }
         var _loc5_:Matrix4 = _loc3_.transform;
         var _loc6_:Matrix4 = _loc4_.transform;
         this._vectorToBox.x = _loc5_.m03 - _loc6_.m03;
         this._vectorToBox.y = _loc5_.m13 - _loc6_.m13;
         this._vectorToBox.z = _loc5_.m23 - _loc6_.m23;
         this.axis22.x = _loc6_.m02;
         this.axis22.y = _loc6_.m12;
         this.axis22.z = _loc6_.m22;
         if(!this.testMainAxis(_loc3_,_loc4_,this.axis22,this._vectorToBox))
         {
            return false;
         }
         this.axis10.x = _loc5_.m00;
         this.axis10.y = _loc5_.m10;
         this.axis10.z = _loc5_.m20;
         if(!this.testMainAxis(_loc3_,_loc4_,this.axis10,this._vectorToBox))
         {
            return false;
         }
         this.axis11.x = _loc5_.m01;
         this.axis11.y = _loc5_.m11;
         this.axis11.z = _loc5_.m21;
         if(!this.testMainAxis(_loc3_,_loc4_,this.axis11,this._vectorToBox))
         {
            return false;
         }
         this.axis12.x = _loc5_.m02;
         this.axis12.y = _loc5_.m12;
         this.axis12.z = _loc5_.m22;
         if(!this.testMainAxis(_loc3_,_loc4_,this.axis12,this._vectorToBox))
         {
            return false;
         }
         this.axis20.x = _loc6_.m00;
         this.axis20.y = _loc6_.m10;
         this.axis20.z = _loc6_.m20;
         this.axis21.x = _loc6_.m01;
         this.axis21.y = _loc6_.m11;
         this.axis21.z = _loc6_.m21;
         if(!this.testDerivedAxis(_loc3_,_loc4_,this.axis10,this.axis20,this._vectorToBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(_loc3_,_loc4_,this.axis10,this.axis21,this._vectorToBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(_loc3_,_loc4_,this.axis11,this.axis20,this._vectorToBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(_loc3_,_loc4_,this.axis11,this.axis21,this._vectorToBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(_loc3_,_loc4_,this.axis12,this.axis20,this._vectorToBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(_loc3_,_loc4_,this.axis12,this.axis21,this._vectorToBox))
         {
            return false;
         }
         return true;
      }
      
      private function testMainAxis(param1:CollisionBox, param2:CollisionRect, param3:Vector3, param4:Vector3) : Boolean
      {
         var _loc5_:Number = this.getOverlapOnAxis(param1,param2,param3,param4);
         return this.registerOverlap(_loc5_,param3);
      }
      
      private function testDerivedAxis(param1:CollisionBox, param2:CollisionRect, param3:Vector3, param4:Vector3, param5:Vector3) : Boolean
      {
         var _loc7_:Number = NaN;
         this._axis.x = param3.y * param4.z - param3.z * param4.y;
         this._axis.y = param3.z * param4.x - param3.x * param4.z;
         this._axis.z = param3.x * param4.y - param3.y * param4.x;
         var _loc6_:Number = this._axis.x * this._axis.x + this._axis.y * this._axis.y + this._axis.z * this._axis.z;
         if(_loc6_ < 1e-10)
         {
            return true;
         }
         _loc7_ = 1 / Math.sqrt(_loc6_);
         this._axis.x *= _loc7_;
         this._axis.y *= _loc7_;
         this._axis.z *= _loc7_;
         var _loc8_:Number = this.getOverlapOnAxis(param1,param2,this._axis,param5);
         return this.registerOverlap(_loc8_,this._axis);
      }
      
      private function getOverlapOnAxis(param1:CollisionBox, param2:CollisionRect, param3:Vector3, param4:Vector3) : Number
      {
         var _loc5_:Matrix4 = param1.transform;
         var _loc6_:Number = (_loc5_.m00 * param3.x + _loc5_.m10 * param3.y + _loc5_.m20 * param3.z) * param1.hs.x;
         if(_loc6_ < 0)
         {
            _loc6_ = -_loc6_;
         }
         var _loc7_:Number = _loc6_;
         _loc6_ = (_loc5_.m01 * param3.x + _loc5_.m11 * param3.y + _loc5_.m21 * param3.z) * param1.hs.y;
         if(_loc6_ < 0)
         {
            _loc6_ = -_loc6_;
         }
         _loc7_ += _loc6_;
         _loc6_ = (_loc5_.m02 * param3.x + _loc5_.m12 * param3.y + _loc5_.m22 * param3.z) * param1.hs.z;
         if(_loc6_ < 0)
         {
            _loc6_ = -_loc6_;
         }
         _loc7_ += _loc6_;
         _loc5_ = param2.transform;
         _loc6_ = (_loc5_.m00 * param3.x + _loc5_.m10 * param3.y + _loc5_.m20 * param3.z) * param2.hs.x;
         if(_loc6_ < 0)
         {
            _loc6_ = -_loc6_;
         }
         _loc7_ += _loc6_;
         _loc6_ = (_loc5_.m01 * param3.x + _loc5_.m11 * param3.y + _loc5_.m21 * param3.z) * param2.hs.y;
         if(_loc6_ < 0)
         {
            _loc6_ = -_loc6_;
         }
         _loc7_ += _loc6_;
         _loc6_ = param4.x * param3.x + param4.y * param3.y + param4.z * param3.z;
         if(_loc6_ < 0)
         {
            _loc6_ = -_loc6_;
         }
         return _loc7_ - _loc6_;
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
      
      private function findContacts(param1:CollisionBox, param2:CollisionRect, param3:Vector3, param4:Vector.<ShapeContact>) : void
      {
         var _loc5_:Matrix4 = null;
         var _loc12_:ShapeContact = null;
         var _loc13_:Vector3 = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         _loc5_ = param1.transform;
         var _loc6_:Matrix4 = param2.transform;
         var _loc7_:Vector3 = this._vectorToBox;
         _loc7_.x = _loc5_.m03 - _loc6_.m03;
         _loc7_.y = _loc5_.m13 - _loc6_.m13;
         _loc7_.z = _loc5_.m23 - _loc6_.m23;
         if(param3.x * _loc7_.x + param3.y * _loc7_.y + param3.z * _loc7_.z < 0)
         {
            param3.x = -param3.x;
            param3.y = -param3.y;
            param3.z = -param3.z;
         }
         var _loc8_:Matrix4 = _basisMatrix;
         ColliderUtils.buildContactBasis(param3,_loc5_,_loc6_,_loc8_);
         ColliderUtils.getBoxFaceVerticesInCCWOrder(param1,param3,FaceSide.BACK,boxFaceVertices);
         ColliderUtils.getRectFaceInCCWOrder(param2,param3,rectFaceVertices);
         ColliderUtils.transformFaceToReferenceSpace(_loc8_,_loc5_,boxFaceVertices,4);
         ColliderUtils.transformFaceToReferenceSpace(_loc8_,_loc6_,rectFaceVertices,4);
         var _loc9_:int = int(param4.length);
         PolygonsIntersectionUtils.findContacts(param1,boxFaceVertices,4,param2,rectFaceVertices,4,_loc8_,param4);
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
            else if(Math.abs(_loc6_.m22) > 0.999)
            {
               _loc13_.x = _loc14_;
               _loc13_.y = _loc15_;
               _loc13_.z = _loc16_;
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

