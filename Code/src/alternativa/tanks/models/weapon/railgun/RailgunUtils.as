package alternativa.tanks.models.weapon.railgun
{
   import alternativa.math.Vector3;
   
   public class RailgunUtils
   {
      
      private static const BIG_DISTANCE:Number = 100000;
      
      public function RailgunUtils()
      {
         super();
      }
      
      public static function getDistantPoint(param1:Vector3, param2:Vector3) : Vector3
      {
         var _loc3_:Vector3 = param1.clone();
         _loc3_.addScaled(RailgunUtils.BIG_DISTANCE,param2);
         return _loc3_;
      }
   }
}

