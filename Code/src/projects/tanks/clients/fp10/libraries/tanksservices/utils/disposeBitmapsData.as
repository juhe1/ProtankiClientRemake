package projects.tanks.clients.fp10.libraries.tanksservices.utils
{
   import flash.display.BitmapData;
   
   public function disposeBitmapsData(param1:Array) : void
   {
      var _loc2_:BitmapData = null;
      var _loc3_:int = 0;
      var _loc4_:int = 0;
      if(param1 != null)
      {
         _loc3_ = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1[_loc4_];
            _loc2_.dispose();
            _loc4_++;
         }
         param1 = null;
      }
   }
}

