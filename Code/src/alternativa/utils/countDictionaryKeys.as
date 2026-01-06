package alternativa.utils
{
   import flash.utils.Dictionary;
   
   public function countDictionaryKeys(param1:Dictionary) : int
   {
      var _loc3_:* = undefined;
      var _loc2_:int = 0;
      for(_loc3_ in param1)
      {
         _loc2_++;
      }
      return _loc2_;
   }
}

