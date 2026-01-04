package utils
{
   import alternativa.osgi.service.locale.ILocaleService;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class TimeFormatter
   {
      
      [Inject]
      public static var localeService:ILocaleService;
      
      private static const MINUTE:int = 60;
      
      private static const HOUR:int = MINUTE * 60;
      
      private static const DAY:int = HOUR * 24;
      
      public function TimeFormatter()
      {
         super();
      }
      
      public static function format(param1:int) : String
      {
         var _loc2_:int = param1 / DAY;
         param1 %= DAY;
         var _loc3_:int = param1 / HOUR;
         param1 %= HOUR;
         var _loc4_:int = param1 / MINUTE;
         var _loc5_:int = param1 % MINUTE;
         return formatDHMS(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      public static function formatDHMS(param1:int, param2:int, param3:int, param4:int) : String
      {
         var _loc5_:String = "";
         var _loc6_:Boolean = localeService.language == "cn";
         if(param1 > 0)
         {
            _loc5_ = add(param1,TanksLocale.TEXT_TIME_LABEL_DAY,_loc5_);
            if(!_loc6_)
            {
               _loc5_ = add(param2,TanksLocale.TEXT_TIME_LABEL_HOUR,_loc5_);
            }
         }
         else if(param2 > 0)
         {
            _loc5_ = add(param2,TanksLocale.TEXT_TIME_LABEL_HOUR,_loc5_);
            if(!_loc6_)
            {
               _loc5_ = add(param3,TanksLocale.TEXT_TIME_LABEL_MINUTE,_loc5_);
            }
         }
         else if(param3 > 0)
         {
            _loc5_ = add(param3,TanksLocale.TEXT_TIME_LABEL_MINUTE,_loc5_);
            if(!_loc6_)
            {
               _loc5_ = add(param4,TanksLocale.TEXT_TIME_LABEL_SECOND,_loc5_);
            }
         }
         else
         {
            _loc5_ = add(param4,TanksLocale.TEXT_TIME_LABEL_SECOND,_loc5_);
         }
         return _loc5_;
      }
      
      private static function add(param1:int, param2:String, param3:String) : String
      {
         if(param1 > 0)
         {
            if(param3.length > 0)
            {
               param3 += " ";
            }
            param3 += param1 + localeService.getText(param2);
         }
         return param3;
      }
   }
}

