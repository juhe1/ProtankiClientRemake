package alternativa.tanks.help
{
   import alternativa.osgi.service.locale.ILocaleService;
   import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class DateTimeHelper
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private static const MILLISECONDS_IN_SECOND:int = 1000;
      
      private static const DAY_IN_MILLISECONDS:int = 24 * 60 * 60 * MILLISECONDS_IN_SECOND;
      
      public function DateTimeHelper()
      {
         super();
      }
      
      public static function formatDateTimeWithExpiredLabel(param1:Date) : String
      {
         var _loc3_:Number = NaN;
         var _loc2_:String = " ";
         if(!isNaN(param1.date))
         {
            _loc3_ = param1.getTime() - new Date().getTime();
            if(_loc3_ < DAY_IN_MILLISECONDS)
            {
               _loc2_ = localeService.getText(TanksLocale.TEXT_PREMIUM_COMPLETION_IN) + DateFormatter.formatTime(param1);
            }
            else
            {
               _loc2_ = localeService.getText(TanksLocale.TEXT_PREMIUM_COMPLETION) + DateFormatter.formatDateToLocalized(param1);
            }
         }
         return _loc2_;
      }
      
      public static function convertSecondsToMilliseconds(param1:int) : Number
      {
         return Number(param1) * MILLISECONDS_IN_SECOND;
      }
   }
}

