package alternativa.tanks.utils
{
   public class ShiftUtils
   {
      
      public function ShiftUtils()
      {
         super();
      }
      
      public static function rotateRight(param1:int, param2:int) : int
      {
         var _loc3_:int = param1 << 32 - param2;
         return (param1 >>> param2) + _loc3_;
      }
      
      public static function rotateLeft(param1:int, param2:int) : int
      {
         var _loc3_:int = param1 >>> 32 - param2;
         return (param1 << param2) + _loc3_;
      }
   }
}

