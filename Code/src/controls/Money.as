package controls
{
   public class Money
   {
      
      public function Money()
      {
         super();
      }
      
      public static function numToString(param1:Number, param2:Boolean = true) : String
      {
         var _loc3_:Vector.<String> = new Vector.<String>();
         var _loc4_:String = param2 ? String(int(param1)) : String(Math.round(param1));
         var _loc5_:int = _loc4_.length - int(_loc4_.length / 3) * 3;
         if(_loc5_ > 0)
         {
            _loc4_ = (_loc5_ == 1 ? "  " : " ") + _loc4_;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc3_.push(_loc4_.substr(_loc6_,3));
            _loc6_ += 3;
         }
         _loc4_ = _loc3_.join(" ");
         if(_loc5_ > 0)
         {
            _loc4_ = _loc4_.substr(3 - _loc5_);
         }
         return _loc4_ + (param2 ? param1.toFixed(10).substr(-11,3) : "");
      }
   }
}

