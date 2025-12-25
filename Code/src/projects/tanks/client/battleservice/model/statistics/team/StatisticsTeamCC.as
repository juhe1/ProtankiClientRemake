package projects.tanks.client.battleservice.model.statistics.team
{
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   
   public class StatisticsTeamCC
   {
      private var newname_10615__END:int;
      
      private var newname_10616__END:int;
      
      private var newname_10617__END:Vector.<UserInfo>;
      
      private var newname_10618__END:Vector.<UserInfo>;
      
      public function StatisticsTeamCC(param1:int = 0, param2:int = 0, param3:Vector.<UserInfo> = null, param4:Vector.<UserInfo> = null)
      {
         super();
         this.newname_10615__END = param1;
         this.newname_10616__END = param2;
         this.newname_10617__END = param3;
         this.newname_10618__END = param4;
      }
      
      public function get blueScore() : int
      {
         return this.newname_10615__END;
      }
      
      public function set blueScore(param1:int) : void
      {
         this.newname_10615__END = param1;
      }
      
      public function get redScore() : int
      {
         return this.newname_10616__END;
      }
      
      public function set redScore(param1:int) : void
      {
         this.newname_10616__END = param1;
      }
      
      public function get usersInfoBlue() : Vector.<UserInfo>
      {
         return this.newname_10617__END;
      }
      
      public function set usersInfoBlue(param1:Vector.<UserInfo>) : void
      {
         this.newname_10617__END = param1;
      }
      
      public function get usersInfoRed() : Vector.<UserInfo>
      {
         return this.newname_10618__END;
      }
      
      public function set usersInfoRed(param1:Vector.<UserInfo>) : void
      {
         this.newname_10618__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "StatisticsTeamCC [";
         _loc1_ += "blueScore = " + this.newname_10615__END + " ";
         _loc1_ += "redScore = " + this.newname_10616__END + " ";
         _loc1_ += "usersInfoBlue = " + this.newname_10617__END + " ";
         _loc1_ += "usersInfoRed = " + this.newname_10618__END + " ";
         return _loc1_ + "]";
      }
   }
}

