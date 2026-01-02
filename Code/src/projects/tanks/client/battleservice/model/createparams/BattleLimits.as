package projects.tanks.client.battleservice.model.createparams
{
   public class BattleLimits
   {
      private var _scoreLimit:int;
      
      private var _timeLimitInSec:int;
      
      public function BattleLimits(param1:int = 0, param2:int = 0)
      {
         super();
         this._scoreLimit = param1;
         this._timeLimitInSec = param2;
      }
      
      public function get scoreLimit() : int
      {
         return this._scoreLimit;
      }
      
      public function set scoreLimit(param1:int) : void
      {
         this._scoreLimit = param1;
      }
      
      public function get timeLimitInSec() : int
      {
         return this._timeLimitInSec;
      }
      
      public function set timeLimitInSec(param1:int) : void
      {
         this._timeLimitInSec = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleLimits [";
         _loc1_ += "scoreLimit = " + this._scoreLimit + " ";
         _loc1_ += "timeLimitInSec = " + this._timeLimitInSec + " ";
         return _loc1_ + "]";
      }
   }
}

