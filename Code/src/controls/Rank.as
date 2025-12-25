package controls
{
   import alternativa.osgi.service.locale.ILocaleService;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class Rank
   {
      
      private static var _ranks:Array;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      public function Rank()
      {
         super();
      }
      
      public static function name(param1:int) : String
      {
         return ranks[param1 - 1];
      }
      
      public static function get ranks() : Array
      {
         var _loc1_:String = null;
         if(_ranks == null)
         {
            _loc1_ = localeService.getText(TanksLocale.TEXT_RANK_NAMES);
            _ranks = _loc1_.split(",");
         }
         return _ranks;
      }
   }
}

