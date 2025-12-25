package projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties
{
   public class UserProperties
   {
      private var userIdValue:String;
      
      private var userNameValue:String;
      
      private var scoreValue:int;
      
      private var rankValue:int;
      
      public function UserProperties(param1:String, param2:String, param3:int, param4:int)
      {
         super();
         this.userIdValue = param1;
         this.userNameValue = param2;
         this.scoreValue = param3;
         this.rankValue = param4;
      }
      
      public function get userId() : String
      {
         return this.userIdValue;
      }
      
      public function set userId(param1:String) : void
      {
         this.userIdValue = param1;
      }
      
      public function get userName() : String
      {
         return this.userNameValue;
      }
      
      public function set userName(param1:String) : void
      {
         this.userNameValue = param1;
      }
      
      public function get score() : int
      {
         return this.scoreValue;
      }
      
      public function set score(param1:int) : void
      {
         this.scoreValue = param1;
      }
      
      public function get rank() : int
      {
         return this.rankValue;
      }
      
      public function set rank(param1:int) : void
      {
         this.rankValue = param1;
      }
   }
}

