package projects.tanks.client.battleselect.model.info
{
   public class BattleInfoUser
   {
      private var newname_3284__END:int;
      
      private var newname_3285__END:int;
      
      private var newname_3286__END:Boolean;
      
      private var newname_3287__END:String;
      
      public function BattleInfoUser(param1:int = 0, param2:int = 0, param3:Boolean = false, param4:String = null)
      {
         super();
         this.newname_3284__END = param1;
         this.newname_3285__END = param2;
         this.newname_3286__END = param3;
         this.newname_3287__END = param4;
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
      
      public function get suspicious() : Boolean
      {
         return this.newname_3286__END;
      }
      
      public function set suspicious(param1:Boolean) : void
      {
         this.newname_3286__END = param1;
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
         var _loc1_:String = "BattleInfoUser [";
         _loc1_ += "Kills = " + this.newname_3284__END + " ";
         _loc1_ += "Score = " + this.newname_3285__END + " ";
         _loc1_ += "suspicious = " + this.newname_3286__END + " ";
         _loc1_ += "user = " + this.newname_3287__END + " ";
         return _loc1_ + "]";
      }
   }
}

