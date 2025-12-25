package projects.tanks.client.chat.types
{
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   
   public class UserStatus
   {
      private var newname_6656__END:ChatModeratorLevel;
      
      private var newname_12578__END:String;
      
      private var newname_12579__END:int;
      
      private var newname_1048__END:String;
      
      private var newname_3328__END:String;
      
      public function UserStatus(param1:ChatModeratorLevel = null, param2:String = null, param3:int = 0, param4:String = null, param5:String = null)
      {
         super();
         this.newname_6656__END = param1;
         this.newname_12578__END = param2;
         this.newname_12579__END = param3;
         this.newname_1048__END = param4;
         this.newname_3328__END = param5;
      }
      
      public function get chatModeratorLevel() : ChatModeratorLevel
      {
         return this.newname_6656__END;
      }
      
      public function set chatModeratorLevel(param1:ChatModeratorLevel) : void
      {
         this.newname_6656__END = param1;
      }
      
      public function get ip() : String
      {
         return this.newname_12578__END;
      }
      
      public function set ip(param1:String) : void
      {
         this.newname_12578__END = param1;
      }
      
      public function get rankIndex() : int
      {
         return this.newname_12579__END;
      }
      
      public function set rankIndex(param1:int) : void
      {
         this.newname_12579__END = param1;
      }
      
      public function get uid() : String
      {
         return this.newname_1048__END;
      }
      
      public function set uid(param1:String) : void
      {
         this.newname_1048__END = param1;
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
         var _loc1_:String = "UserStatus [";
         _loc1_ += "chatModeratorLevel = " + this.newname_6656__END + " ";
         _loc1_ += "ip = " + this.newname_12578__END + " ";
         _loc1_ += "rankIndex = " + this.newname_12579__END + " ";
         _loc1_ += "uid = " + this.newname_1048__END + " ";
         _loc1_ += "userId = " + this.newname_3328__END + " ";
         return _loc1_ + "]";
      }
   }
}

