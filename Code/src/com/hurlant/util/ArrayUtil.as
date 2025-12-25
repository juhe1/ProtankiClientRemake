package com.hurlant.util
{
   import flash.utils.ByteArray;
   
   public class ArrayUtil
   {
      
      public function ArrayUtil()
      {
         super();
      }
      
      public static function equals(param1:ByteArray, param2:ByteArray) : Boolean
      {
         if(param1.length != param2.length)
         {
            return false;
         }
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_] != param2[_loc4_])
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
   }
}

