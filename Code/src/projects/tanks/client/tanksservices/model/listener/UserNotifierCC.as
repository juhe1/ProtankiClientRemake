package projects.tanks.client.tanksservices.model.listener
{
   import alternativa.types.Long;
   
   public class UserNotifierCC
   {
      
      private var _currentUserId:Long;
      
      public function UserNotifierCC(param1:Long = null)
      {
         super();
         this._currentUserId = param1;
      }
      
      public function get currentUserId() : Long
      {
         return this._currentUserId;
      }
      
      public function set currentUserId(param1:Long) : void
      {
         this._currentUserId = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "UserNotifierCC [";
         _loc1_ += "currentUserId = " + this.currentUserId + " ";
         return _loc1_ + "]";
      }
   }
}

