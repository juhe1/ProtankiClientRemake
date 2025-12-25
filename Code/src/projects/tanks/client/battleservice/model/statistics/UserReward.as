package projects.tanks.client.battleservice.model.statistics
{
   public class UserReward
   {
      private var newname_11738__END:int;
      
      private var newname_11739__END:int;
      
      private var newname_11740__END:int;
      
      private var newname_3328__END:String;
      
      public function UserReward(param1:int = 0, param2:int = 0, param3:int = 0, param4:String = null)
      {
         super();
         this.newname_11738__END = param1;
         this.newname_11739__END = param2;
         this.newname_11740__END = param3;
         this.newname_3328__END = param4;
      }
      
      public function get newbiesAbonementBonusReward() : int
      {
         return this.newname_11738__END;
      }
      
      public function set newbiesAbonementBonusReward(param1:int) : void
      {
         this.newname_11738__END = param1;
      }
      
      public function get premiumBonusReward() : int
      {
         return this.newname_11739__END;
      }
      
      public function set premiumBonusReward(param1:int) : void
      {
         this.newname_11739__END = param1;
      }
      
      public function get reward() : int
      {
         return this.newname_11740__END;
      }
      
      public function set reward(param1:int) : void
      {
         this.newname_11740__END = param1;
      }
      
      public function get userId() : String
      {
         return this.newname_3328__END;
      }
      
      public function set userId(param1:String) : void
      {
         this.newname_3328__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "UserReward [";
         _loc1_ += "newbiesAbonementBonusReward = " + this.newname_11738__END + " ";
         _loc1_ += "premiumBonusReward = " + this.newname_11739__END + " ";
         _loc1_ += "Reward = " + this.newname_11740__END + " ";
         _loc1_ += "userId = " + this.newname_3328__END + " ";
         return _loc1_ + "]";
      }
   }
}

