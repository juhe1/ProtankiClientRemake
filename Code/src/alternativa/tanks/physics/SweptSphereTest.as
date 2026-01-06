package alternativa.tanks.physics
{
   import alternativa.math.Vector3;
   
   public class SweptSphereTest
   {
      
      private static const A:Vector3 = new Vector3();
      
      private static const V:Vector3 = new Vector3();
      
      public function SweptSphereTest()
      {
         super();
      }
      
      public static function test(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3, param5:Vector3, param6:Number, param7:Number) : Boolean
      {
         A.diff(param1,param4);
         var _loc8_:Number = param3 + param6;
         var _loc9_:Number = A.dot(A) - _loc8_ * _loc8_;
         if(_loc9_ < 0)
         {
            return true;
         }
         V.diff(param2,param5);
         var _loc10_:Number = V.dot(V);
         if(_loc10_ < 0.0001)
         {
            return false;
         }
         var _loc11_:Number = A.dot(V);
         if(_loc11_ > 0)
         {
            return false;
         }
         var _loc12_:Number = _loc11_ * _loc11_ - _loc10_ * _loc9_;
         if(_loc12_ < 0)
         {
            return false;
         }
         var _loc13_:Number = Math.sqrt(_loc12_);
         var _loc14_:Number = (-_loc11_ - _loc13_) / _loc10_;
         return _loc14_ < param7;
      }
   }
}

