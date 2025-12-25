package projects.tanks.client.battleservice.model.statistics
{
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   
   public class UserInfo
   {
      private var newname_6656__END:ChatModeratorLevel;
      
      private var newname_11729__END:int;
      
      private var newname_3284__END:int;
      
      private var newname_3533__END:int;
      
      private var newname_3285__END:int;
      
      private var newname_1048__END:String;
      
      private var newname_3287__END:String;
      
      public function UserInfo(param1:ChatModeratorLevel = null, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:String = null, param7:String = null)
      {
         super();
         this.newname_6656__END = param1;
         this.newname_11729__END = param2;
         this.newname_3284__END = param3;
         this.newname_3533__END = param4;
         this.newname_3285__END = param5;
         this.newname_1048__END = param6;
         this.newname_3287__END = param7;
      }
      
      public function get chatModeratorLevel() : ChatModeratorLevel
      {
         return this.newname_6656__END;
      }
      
      public function set chatModeratorLevel(param1:ChatModeratorLevel) : void
      {
         this.newname_6656__END = param1;
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
      
      public function get rank() : int
      {
         return this.newname_3533__END;
      }
      
      public function set rank(param1:int) : void
      {
         this.newname_3533__END = param1;
      }
      
      public function get score() : int
      {
         return this.newname_3285__END;
      }
      
      public function set score(param1:int) : void
      {
         this.newname_3285__END = param1;
      }
      
      public function get uid() : String
      {
         return this.newname_1048__END;
      }
      
      public function set uid(param1:String) : void
      {
         this.newname_1048__END = param1;
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
         var _loc1_:String = "UserInfo [";
         _loc1_ += "chatModeratorLevel = " + this.newname_6656__END + " ";
         _loc1_ += "deaths = " + this.newname_11729__END + " ";
         _loc1_ += "kills = " + this.newname_3284__END + " ";
         _loc1_ += "rank = " + this.newname_3533__END + " ";
         _loc1_ += "score = " + this.newname_3285__END + " ";
         _loc1_ += "uid = " + this.newname_1048__END + " ";
         _loc1_ += "user = " + this.newname_3287__END + " ";
         return _loc1_ + "]";
      }
   }
}

