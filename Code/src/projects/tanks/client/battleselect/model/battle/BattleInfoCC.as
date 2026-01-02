package projects.tanks.client.battleselect.model.battle
{
   import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
   
   public class BattleInfoCC
   {
      
      private var _roundStarted:Boolean;
      
      private var _suspicionLevel:BattleSuspicionLevel;
      
      private var _timeLeftInSec:int;
      
      public function BattleInfoCC(param1:Boolean = false, param2:BattleSuspicionLevel = null, param3:int = 0)
      {
         super();
         this._roundStarted = param1;
         this._suspicionLevel = param2;
         this._timeLeftInSec = param3;
      }
      
      public function get roundStarted() : Boolean
      {
         return this._roundStarted;
      }
      
      public function set roundStarted(param1:Boolean) : void
      {
         this._roundStarted = param1;
      }
      
      public function get suspicionLevel() : BattleSuspicionLevel
      {
         return this._suspicionLevel;
      }
      
      public function set suspicionLevel(param1:BattleSuspicionLevel) : void
      {
         this._suspicionLevel = param1;
      }
      
      public function get timeLeftInSec() : int
      {
         return this._timeLeftInSec;
      }
      
      public function set timeLeftInSec(param1:int) : void
      {
         this._timeLeftInSec = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleInfoCC [";
         _loc1_ += "roundStarted = " + this.roundStarted + " ";
         _loc1_ += "suspicionLevel = " + this.suspicionLevel + " ";
         _loc1_ += "timeLeftInSec = " + this.timeLeftInSec + " ";
         return _loc1_ + "]";
      }
   }
}

