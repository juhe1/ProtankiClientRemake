package projects.tanks.client.battleservice.model.statistics
{
   public class UserStat
   {
      private var newname_11729__END:int;
      
      private var newname_3284__END:int;
      
      private var newname_3285__END:int;
      
      private var newname_3287__END:String;
      
      public function UserStat(param1:int = 0, param2:int = 0, param3:int = 0, param4:String = null)
      {
         super();
         this.newname_11729__END = param1;
         this.newname_3284__END = param2;
         this.newname_3285__END = param3;
         this.newname_3287__END = param4;
      }
      
      public function get deaths() : int
      {
         return this.newname_11729__END;
      }
      
      public function set deaths(param1:int) : void
      {
         this.newname_11729__END = param1;
      }
      
      public function get kills() : int
      {
         return this.newname_3284__END;
      }
      
      public function set kills(param1:int) : void
      {
         this.newname_3284__END = param1;
      }
      
      public function get score() : int
      {
         return this.newname_3285__END;
      }
      
      public function set score(param1:int) : void
      {
         this.newname_3285__END = param1;
      }
      
      public function get user() : String
      {
         return this.newname_3287__END;
      }
      
      public function set user(param1:String) : void
      {
         this.newname_3287__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "UserStat [";
         _loc1_ += "deaths = " + this.newname_11729__END + " ";
         _loc1_ += "Kills = " + this.newname_3284__END + " ";
         _loc1_ += "Score = " + this.newname_3285__END + " ";
         _loc1_ += "user = " + this.newname_3287__END + " ";
         return _loc1_ + "]";
      }
   }
}

