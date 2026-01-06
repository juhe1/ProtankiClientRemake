package alternativa.physics.collision.colliders
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.ShapeContact;
   import alternativa.physics.collision.CollisionShape;
   import flash.geom.Point;
   
   public class PolygonsIntersectionUtils
   {
      
      private static const projectedPoints1:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point()]);
      
      private static const projectedPoints2:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point()]);
      
      private static const intersection:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point()]);
      
      private static var points1:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point()]);
      
      private static var points2:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point(),new Point()]);
      
      private static const point:Point = new Point();
      
      private static const normal1:Vector3 = new Vector3();
      
      private static const normal2:Vector3 = new Vector3();
      
      public function PolygonsIntersectionUtils()
      {
         super();
      }
      
      public static function findContacts(param1:CollisionShape, param2:Vector.<Vertex>, param3:int, param4:CollisionShape, param5:Vector.<Vertex>, param6:int, param7:Matrix4, param8:Vector.<ShapeContact>) : void
      {
         var _loc11_:Point = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:ShapeContact = null;
         var _loc15_:Vector3 = null;
         calculateFaceNormal(param2,normal1);
         calculateFaceNormal(param5,normal2);
         fillProjectedPoints(param2,param3,projectedPoints1);
         fillProjectedPoints(param5,param6,projectedPoints2);
         var _loc9_:int = findPolygonsIntersection(projectedPoints1,param3,projectedPoints2,param6,intersection);
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_)
         {
            _loc11_ = intersection[_loc10_];
            _loc12_ = getFaceZ(_loc11_,Vertex(param2[0]).transformed,normal1);
            _loc13_ = getFaceZ(_loc11_,Vertex(param5[0]).transformed,normal2);
            if(_loc13_ > _loc12_)
            {
               _loc14_ = ShapeContact.create();
               _loc14_.shape1 = param1;
               _loc14_.shape2 = param4;
               _loc15_ = _loc14_.position;
               _loc15_.x = _loc11_.x;
               _loc15_.y = _loc11_.y;
               _loc15_.z = 0.5 * (_loc12_ + _loc13_);
               _loc15_.transform4(param7);
               _loc14_.penetration = _loc13_ - _loc12_;
               _loc14_.normal.x = param7.m02;
               _loc14_.normal.y = param7.m12;
               _loc14_.normal.z = param7.m22;
               param8[param8.length] = _loc14_;
            }
            _loc10_++;
         }
      }
      
      private static function calculateFaceNormal(param1:Vector.<Vertex>, param2:Vector3) : void
      {
         var _loc9_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc3_:Vertex = param1[0];
         var _loc4_:Vertex = param1[1];
         var _loc5_:Vertex = param1[2];
         var _loc6_:Vector3 = _loc3_.transformed;
         var _loc7_:Vector3 = _loc4_.transformed;
         var _loc8_:Vector3 = _loc5_.transformed;
         _loc9_ = _loc7_.x - _loc6_.x;
         var _loc10_:Number = _loc7_.y - _loc6_.y;
         _loc11_ = _loc7_.z - _loc6_.z;
         _loc12_ = _loc8_.x - _loc6_.x;
         var _loc13_:Number = _loc8_.y - _loc6_.y;
         _loc14_ = _loc8_.z - _loc6_.z;
         param2.x = _loc10_ * _loc14_ - _loc11_ * _loc13_;
         param2.y = _loc11_ * _loc12_ - _loc9_ * _loc14_;
         param2.z = _loc9_ * _loc13_ - _loc10_ * _loc12_;
         param2.normalize();
      }
      
      private static function fillProjectedPoints(param1:Vector.<Vertex>, param2:int, param3:Vector.<Point>) : void
      {
         var _loc5_:Vertex = null;
         var _loc6_:Point = null;
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = param3[_loc4_];
            _loc6_.x = _loc5_.transformed.x;
            _loc6_.y = _loc5_.transformed.y;
            _loc4_++;
         }
      }
      
      private static function findPolygonsIntersection(param1:Vector.<Point>, param2:int, param3:Vector.<Point>, param4:int, param5:Vector.<Point>) : int
      {
         var _loc9_:Point = null;
         var _loc10_:Vector.<Point> = null;
         copyPoints(param3,points1,param4);
         var _loc6_:int = param4;
         var _loc7_:Point = param1[param2 - 1];
         var _loc8_:int = 0;
         while(_loc8_ < param2)
         {
            _loc9_ = param1[_loc8_];
            _loc6_ = clip(_loc7_,_loc9_,points1,points2,_loc6_);
            if(_loc6_ == 0)
            {
               break;
            }
            _loc7_ = _loc9_;
            _loc10_ = points1;
            points1 = points2;
            points2 = _loc10_;
            _loc8_++;
         }
         copyPoints(points1,param5,_loc6_);
         return _loc6_;
      }
      
      private static function copyPoints(param1:Vector.<Point>, param2:Vector.<Point>, param3:int) : void
      {
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc4_:int = 0;
         while(_loc4_ < param3)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = param2[_loc4_];
            _loc6_.x = _loc5_.x;
            _loc6_.y = _loc5_.y;
            _loc4_++;
         }
      }
      
      private static function clip(param1:Point, param2:Point, param3:Vector.<Point>, param4:Vector.<Point>, param5:int) : int
      {
         var _loc10_:Point = null;
         var _loc11_:Boolean = false;
         var _loc6_:Point = param3[param5 - 1];
         var _loc7_:Boolean = arePointsCCW(param1,param2,_loc6_);
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         while(_loc9_ < param5)
         {
            _loc10_ = param3[_loc9_];
            _loc11_ = arePointsCCW(param1,param2,_loc10_);
            if(_loc11_)
            {
               if(!_loc7_)
               {
                  calculateIntersection(param1,param2,_loc6_,_loc10_,point);
                  setPoint(point,param4,_loc8_++);
               }
               setPoint(_loc10_,param4,_loc8_++);
            }
            else if(_loc7_)
            {
               calculateIntersection(param1,param2,_loc6_,_loc10_,point);
               setPoint(point,param4,_loc8_++);
            }
            _loc7_ = _loc11_;
            _loc6_ = _loc10_;
            _loc9_++;
         }
         return _loc8_;
      }
      
      private static function setPoint(param1:Point, param2:Vector.<Point>, param3:int) : void
      {
         var _loc4_:Point = param2[param3];
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
      }
      
      private static function arePointsCCW(param1:Point, param2:Point, param3:Point) : Boolean
      {
         var _loc4_:Number = param2.x - param1.x;
         var _loc5_:Number = param2.y - param1.y;
         var _loc6_:Number = param3.x - param1.x;
         var _loc7_:Number = param3.y - param1.y;
         return _loc4_ * _loc7_ - _loc5_ * _loc6_ > 0;
      }
      
      private static function calculateIntersection(param1:Point, param2:Point, param3:Point, param4:Point, param5:Point) : void
      {
         var _loc6_:Number = param2.x - param1.x;
         var _loc7_:Number = param2.y - param1.y;
         var _loc8_:Number = param4.x - param3.x;
         var _loc9_:Number = param4.y - param3.y;
         var _loc10_:Number = param3.x - param1.x;
         var _loc11_:Number = param3.y - param1.y;
         var _loc12_:Number = (_loc6_ * _loc11_ - _loc7_ * _loc10_) / (_loc7_ * _loc8_ - _loc6_ * _loc9_);
         param5.x = param3.x + _loc12_ * _loc8_;
         param5.y = param3.y + _loc12_ * _loc9_;
      }
      
      private static function getFaceZ(param1:Point, param2:Vector3, param3:Vector3) : Number
      {
         var _loc4_:Number = param2.dot(param3);
         return (_loc4_ - param1.x * param3.x - param1.y * param3.y) / param3.z;
      }
   }
}

