package projects.tanks.client.tanksservices.model.notifier.online
{
   public class OnlineNotifierData
   {
      private var newname_12723__END:Boolean;
      
      private var newname_6979__END:int;
      
      private var newname_3328__END:String;
      
      public function OnlineNotifierData(param1:Boolean = false, param2:int = 0, param3:String = null)
      {
         super();
         this.newname_12723__END = param1;
         this.newname_6979__END = param2;
         this.newname_3328__END = param3;
      }
      
      public function get online() : Boolean
      {
         return this.newname_12723__END;
      }
      
      public function set online(param1:Boolean) : void
      {
         this.newname_12723__END = param1;
      }
      
      public function get serverNumber() : int
      {
         return this.newname_6979__END;
      }
      
      public function set serverNumber(param1:int) : void
      {
         this.newname_6979__END = param1;
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
         var _loc1_:String = "OnlineNotifierData [";
         _loc1_ += "online = " + this.newname_12723__END + " ";
         _loc1_ += "serverNumber = " + this.newname_6979__END + " ";
         _loc1_ += "userId = " + this.newname_3328__END + " ";
         return _loc1_ + "]";
      }
   }
}

