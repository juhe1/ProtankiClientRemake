package projects.tanks.client.users.model.friends
{
   public class FriendsCC
   {
      
      private var _acceptedLimit:int;
      
      private var _incomingLimit:int;
      
      private var _local:Boolean;
      
      public function FriendsCC(acceptedLimitParam:int = 0, incomingLimitParam:int = 0, localParam:Boolean = false)
      {
         super();
         this._acceptedLimit = acceptedLimitParam;
         this._incomingLimit = incomingLimitParam;
         this._local = localParam;
      }
      
      public function get acceptedLimit() : int
      {
         return this._acceptedLimit;
      }
      
      public function set acceptedLimit(param1:int) : void
      {
         this._acceptedLimit = param1;
      }
      
      public function get incomingLimit() : int
      {
         return this._incomingLimit;
      }
      
      public function set incomingLimit(param1:int) : void
      {
         this._incomingLimit = param1;
      }
      
      public function get local() : Boolean
      {
         return this._local;
      }
      
      public function set local(param1:Boolean) : void
      {
         this._local = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "FriendsCC [";
         _loc1_ += "acceptedLimit = " + this.acceptedLimit + " ";
         _loc1_ += "incomingLimit = " + this.incomingLimit + " ";
         _loc1_ += "local = " + this.local + " ";
         return _loc1_ + "]";
      }
   }
}

