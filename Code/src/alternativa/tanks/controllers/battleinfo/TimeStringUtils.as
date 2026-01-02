package alternativa.tanks.controllers.battleinfo
{
   public class TimeStringUtils
   {
      
      public function TimeStringUtils()
      {
         super();
      }
      
      public static function getTimeStr(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = int(param1 / 60);
         var _loc4_:int = param1 - _loc3_ * 60;
         return String(_loc3_) + ":" + (_loc4_ > 9 ? String(_loc4_) : "0" + String(_loc4_));
      }
   }
}

