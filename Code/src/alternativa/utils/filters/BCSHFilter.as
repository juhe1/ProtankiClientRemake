package alternativa.utils.filters
{
   import flash.filters.ColorMatrixFilter;
   import flash.utils.Dictionary;
   
   public class BCSHFilter
   {
      
      private static const DELTA:Number = 0.01;
      
      private static var filters:Dictionary = new Dictionary();
      
      public function BCSHFilter()
      {
         super();
      }
      
      public static function createFilter(param1:Number, param2:Number, param3:Number, param4:Number) : ColorMatrixFilter
      {
         var _loc5_:Object = null;
         var _loc6_:AdjustColor = null;
         var _loc7_:ColorMatrixFilter = null;
         var _loc8_:Object = null;
         for(_loc5_ in filters)
         {
            if(areEqual(param1,_loc5_.b) && areEqual(param2,_loc5_.c) && areEqual(param3,_loc5_.s) && areEqual(param4,_loc5_.h))
            {
               return filters[_loc5_];
            }
         }
         _loc6_ = new AdjustColor();
         _loc6_.brightness = param1;
         _loc6_.contrast = param2;
         _loc6_.saturation = param3;
         _loc6_.hue = param4;
         _loc7_ = new ColorMatrixFilter();
         _loc7_.matrix = _loc6_.CalculateFinalFlatArray();
         _loc8_ = {
            "b":param1,
            "c":param2,
            "s":param3,
            "h":param4
         };
         filters[_loc8_] = _loc7_;
         return _loc7_;
      }
      
      private static function areEqual(param1:Number, param2:Number) : Boolean
      {
         return Math.abs(param1 - param2) < DELTA;
      }
   }
}

