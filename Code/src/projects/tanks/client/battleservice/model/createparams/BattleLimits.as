package projects.tanks.client.battleservice.model.createparams
{
   public class BattleLimits
   {
      private var newname_11811__END:int;
      
      private var newname_11812__END:int;
      
      public function BattleLimits(param1:int = 0, param2:int = 0)
      {
         super();
         this.newname_11811__END = param1;
         this.newname_11812__END = param2;
      }
      
      public function get scoreLimit() : int
      {
         return this.newname_11811__END;
      }
      
      public function set scoreLimit(param1:int) : void
      {
         this.newname_11811__END = param1;
      }
      
      public function get timeLimitInSec() : int
      {
         return this.newname_11812__END;
      }
      
      public function set timeLimitInSec(param1:int) : void
      {
         this.newname_11812__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleLimits [";
         _loc1_ += "scoreLimit = " + this.newname_11811__END + " ";
         _loc1_ += "timeLimitInSec = " + this.newname_11812__END + " ";
         return _loc1_ + "]";
      }
   }
}

