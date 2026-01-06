package projects.tanks.client.battlefield.models.tankparts.gearscore
{
   public class BattleGearScoreCC
   {
      
      private var _score:int;
      
      public function BattleGearScoreCC(param1:int = 0)
      {
         super();
         this._score = param1;
      }
      
      public function get score() : int
      {
         return this._score;
      }
      
      public function set score(param1:int) : void
      {
         this._score = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleGearScoreCC [";
         _loc1_ += "score = " + this.score + " ";
         return _loc1_ + "]";
      }
   }
}

