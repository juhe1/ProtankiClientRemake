package projects.tanks.clients.fp10.libraries.tanksservices.utils
{
   public class UidUtil
   {
      
      public function UidUtil()
      {
         super();
      }
      
      public static function userNameWithoutClanTag(param1:String) : String
      {
         var _loc2_:int = int(param1.indexOf("] "));
         if(_loc2_ > 0)
         {
            return param1.substr(_loc2_ + 2);
         }
         return param1;
      }
   }
}

