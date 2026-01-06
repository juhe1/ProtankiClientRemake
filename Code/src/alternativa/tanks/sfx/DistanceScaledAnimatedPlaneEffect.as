package alternativa.tanks.sfx
{
   import alternativa.math.Vector3;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.utils.objectpool.Pool;
   
   public class DistanceScaledAnimatedPlaneEffect extends AnimatedPlaneEffect
   {
      
      private static const MIN_DISTANCE:Number = 3000;
      
      private static const SCALE_COEFFICIENT:Number = 1 / 5000;
      
      private static const v:Vector3 = new Vector3();
      
      public function DistanceScaledAnimatedPlaneEffect(param1:Pool)
      {
         super(param1);
      }
      
      override public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc3_:Boolean = super.play(param1,param2);
         if(_loc3_)
         {
            v.reset(plane.x,plane.y,plane.z);
            _loc4_ = param2.position.distanceTo(v);
            if(_loc4_ > MIN_DISTANCE)
            {
               scale += _loc4_ * SCALE_COEFFICIENT;
            }
            return true;
         }
         return false;
      }
   }
}

