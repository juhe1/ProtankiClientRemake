package projects.tanks.clients.fp10.libraries.tanksservices.utils
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.types.Long;
   import platform.client.fp10.core.service.address.AddressService;
   import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
   
   public class BattleInfoUtils
   {
      
      [Inject] // added
      public static var addressService:AddressService;
      
      [Inject] // added
      public static var partnersService:IPartnerService;
      
      [Inject] // added
      public static var serverNameService:ServerNumberToLocaleServerService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private static const BATTLE_NAME_SEPARATOR:String = " ";
      
      public function BattleInfoUtils()
      {
         super();
      }
      
      public static function getBattleBaseUrl() : String
      {
         var _loc1_:String = "";
         if(!partnersService.isRunningInsidePartnerEnvironment())
         {
            _loc1_ = addressService.getBaseURL();
         }
         return _loc1_;
      }
      
      public static function getBattleIdUhex(param1:String) : String
      {
         return param1;
      }
      
      private static function intToUhex(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc4_:uint = 0;
         if(param1 >= 0)
         {
            _loc2_ = param1.toString(16);
         }
         else
         {
            _loc4_ = uint(param1 & ~2147483648 | 0x80000000);
            _loc2_ = _loc4_.toString(16);
         }
         var _loc3_:int = 8 - _loc2_.length;
         while(_loc3_ > 0)
         {
            _loc2_ = "0" + _loc2_;
            _loc3_--;
         }
         return _loc2_;
      }
      
      public static function buildBattleName(param1:String, param2:String) : String
      {
         return param1 + BATTLE_NAME_SEPARATOR + getShortBattleModeName(param2);
      }
      
      private static function getShortBattleModeName(param1:String) : String
      {
         switch(param1)
         {
            case BattleMode.DM.name:
               return localeService.getText(TanksLocale.TEXT_DM_SHORT_NAME);
            case BattleMode.TDM.name:
               return localeService.getText(TanksLocale.TEXT_TDM_SHORT_NAME);
            case BattleMode.CTF.name:
               return localeService.getText(TanksLocale.TEXT_CTF_SHORT_NAME);
            case BattleMode.CP.name:
               return localeService.getText(TanksLocale.TEXT_CP_SHORT_NAME);
            case BattleMode.AS.name:
               return localeService.getText(TanksLocale.TEXT_AS_SHORT_NAME);
            default:
               return null;
         }
      }
   }
}

