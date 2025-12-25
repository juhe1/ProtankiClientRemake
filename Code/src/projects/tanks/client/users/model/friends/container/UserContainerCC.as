package projects.tanks.client.users.model.friends.container
{
   public class UserContainerCC
   {
      private var newname_7667__END:Vector.<String>;
      
      public function UserContainerCC(param1:Vector.<String> = null)
      {
         super();
         this.newname_7667__END = param1;
      }
      
      public function get users() : Vector.<String>
      {
         return this.newname_7667__END;
      }
      
      public function set users(param1:Vector.<String>) : void
      {
         this.newname_7667__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "UserContainerCC [";
         _loc1_ += "users = " + this.newname_7667__END + " ";
         return _loc1_ + "]";
      }
   }
}

