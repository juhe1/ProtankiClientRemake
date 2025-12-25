package projects.tanks.client.tanksservices.model.notifier
{   
   public class AbstractNotifier
   {
      
      private var _userId:String;
      
      public function AbstractNotifier(param1:String = null)
      {
         super();
         this._userId = param1;
      }
      
      public function get userId() : String
      {
         return this._userId;
      }
      
      public function set userId(param1:String) : void
      {
         this._userId = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "AbstractNotifier [";
         _loc1_ += "userId = " + this.userId + " ";
         return _loc1_ + "]";
      }
   }
}

