package projects.tanks.client.battleservice
{
   public class Range
   {
      
      private var _max:int;
      
      private var _min:int;
      
      public function Range(__max:int = 0, __min:int = 0)
      {
         super();
         this._max = __max;
         this._min = __min;
      }
      
      public function get max() : int
      {
         return this._max;
      }
      
      public function set max(param1:int) : void
      {
         this._max = param1;
      }
      
      public function get min() : int
      {
         return this._min;
      }
      
      public function set min(param1:int) : void
      {
         this._min = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "Range [";
         _loc1_ += "max = " + this.max + " ";
         _loc1_ += "min = " + this.min + " ";
         return _loc1_ + "]";
      }
   }
}

