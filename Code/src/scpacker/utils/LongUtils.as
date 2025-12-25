package scpacker.utils
{
   import alternativa.types.Long;
   
   public class LongUtils
   {
      private static const strToIdMap:Object = {};
      
      private static const idToStrMap:Object = {};
      
      public function LongUtils()
      {
         super();
      }
      
      public static function strToId(param1:String) : Long
      {
         var _loc7_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc8_:* = 0;
         var _loc6_:* = 0;
         var _loc2_:Long = strToIdMap[param1];
         if(!_loc2_)
         {
            _loc7_ = 0;
            _loc3_ = param1.length;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = uint(param1.charCodeAt(_loc4_));
               _loc7_ = uint((_loc7_ << 5) - _loc7_ + _loc5_);
               _loc7_ &= _loc7_;
               _loc4_++;
            }
            _loc8_ = _loc7_ >>> 32 & 4294967295 & 2147483647;
            _loc6_ = _loc7_ & 4294967295;
            _loc2_ = Long.getLong(_loc8_,_loc6_);
            strToIdMap[param1] = _loc2_;
            idToStrMap[_loc2_] = param1;
         }
         return _loc2_;
      }
      
      public static function idToStr(param1:Long) : String
      {
         return idToStrMap[param1];
      }
   }
}

