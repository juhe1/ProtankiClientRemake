package alternativa.tanks.models.weapon.ricochet
{
   import alternativa.tanks.battle.objects.tank.Tank;
   
   public class BaseRicochetTargeEvaluator
   {
      
      private static const DISTANCE_WEIGHT:Number = 0.65;
      
      public function BaseRicochetTargeEvaluator()
      {
         super();
      }
      
      protected static function getBasePriority(param1:Tank, param2:int, param3:Number, param4:Number, param5:Number, param6:Number) : Number
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(param1.health > 0)
         {
            _loc7_ = DISTANCE_WEIGHT * param3 / param5 + (1 - DISTANCE_WEIGHT) * param4 / param6;
            _loc8_ = param2 == 0 ? 2 : 0;
            return 1 - _loc7_ + _loc8_;
         }
         return 0;
      }
   }
}

