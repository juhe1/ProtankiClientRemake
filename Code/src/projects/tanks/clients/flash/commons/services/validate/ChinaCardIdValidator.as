package projects.tanks.clients.flash.commons.services.validate
{
   public class ChinaCardIdValidator
   {
      
      private static const KEY:Vector.<int> = Vector.<int>([7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2]);
      
      private static const AUTH:Vector.<String> = Vector.<String>(["1","0","x","9","8","7","6","5","4","3","2"]);
      
      private static const REGIONS_LIST:Vector.<String> = Vector.<String>(["11","12","13","14","15","21","22","23","31","32","33","34","35","36","37","41","42","43","44","45","46","50","51","52","53","54","61","62","63","64","65","71","81","82","91"]);
      
      private static const VALID_ID_LENGTH:int = 18;
      
      private static const MOD_CHECK_SUM:int = 11;
      
      public function ChinaCardIdValidator()
      {
         super();
      }
      
      public static function isValidIdNumber(param1:String) : Boolean
      {
         var _loc13_:Number = NaN;
         var _loc2_:int = param1.length;
         if(_loc2_ != VALID_ID_LENGTH)
         {
            return false;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc13_ = Number(param1.charCodeAt(_loc3_));
            if(_loc13_ < 48 || _loc13_ > 57)
            {
               return false;
            }
            _loc3_++;
         }
         var _loc4_:String = param1.substr(0,2);
         if(REGIONS_LIST.indexOf(_loc4_) == -1)
         {
            return false;
         }
         var _loc5_:Date = new Date();
         var _loc6_:Number = _loc5_.fullYear;
         var _loc7_:int = parseInt(param1.substr(6,4));
         if(_loc7_ < 1900 || _loc7_ > _loc6_)
         {
            return false;
         }
         var _loc8_:int = parseInt(param1.substr(10,2));
         var _loc9_:int = parseInt(param1.substr(12,2));
         if(_loc8_ < 1 || _loc8_ > 12 || _loc9_ < 1 || _loc9_ > 31)
         {
            return false;
         }
         var _loc10_:int = 0;
         var _loc11_:int = _loc2_ - 1;
         var _loc12_:int = 0;
         while(_loc12_ < _loc11_)
         {
            _loc10_ += KEY[_loc12_] * parseInt(param1.substr(_loc12_,1));
            _loc12_++;
         }
         if(param1.charAt(_loc11_).toLowerCase() != AUTH[_loc10_ % MOD_CHECK_SUM])
         {
            return false;
         }
         return true;
      }
   }
}

