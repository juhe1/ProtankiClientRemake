package projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties
{
   import flash.events.EventDispatcher;
   
   public class UserPropertiesService extends EventDispatcher implements IUserPropertiesService
   {
      private var userIdValue:String;
      
      private var userNameValue:String;
      
      private var scoreValue:int;
      
      private var rankValue:int;
      
      private var userProfileBaseUrl:String;
      
      private var serverNumberValue:int;
      
      private var templateBattlePageValue:String;
      
      private var gameHostValue:String;
      
      public function UserPropertiesService()
      {
         super();
      }
      
      public function get userId() : String
      {
         return this.userIdValue;
      }
      
      public function get userName() : String
      {
         return this.userNameValue;
      }
      
      public function get rank() : int
      {
         return this.rankValue;
      }
      
      public function get score() : int
      {
         return this.scoreValue;
      }
      
      public function getUserProfileUrl(param1:String) : String
      {
         return this.userProfileBaseUrl + param1;
      }
      
      public function get serverNumber() : int
      {
         return this.serverNumberValue;
      }
      
      public function get templateBattlePage() : String
      {
         return this.templateBattlePageValue;
      }
      
      public function get gameHost() : String
      {
         return this.gameHostValue;
      }
      
      public function updateRank(param1:int) : void
      {
         this.rankValue = param1;
         dispatchEvent(new UserPropertiesServiceEvent(UserPropertiesServiceEvent.UPDATE_RANK,new UserProperties(this.userIdValue,this.userNameValue,this.scoreValue,this.rankValue)));
      }
      
      public function updateScore(param1:int) : void
      {
         this.scoreValue = param1;
         dispatchEvent(new UserPropertiesServiceEvent(UserPropertiesServiceEvent.UPDATE_SCORE,new UserProperties(this.userIdValue,this.userNameValue,this.scoreValue,this.rankValue)));
      }
      
      public function init(param1:String, param2:String, param3:int, param4:int, param5:int, param6:String, param7:String, param8:String) : void
      {
         this.userIdValue = param1;
         this.userNameValue = param2;
         this.scoreValue = param3;
         this.rankValue = param4;
         this.serverNumberValue = param5;
         this.templateBattlePageValue = param6;
         this.gameHostValue = param7;
         this.userProfileBaseUrl = param8;
      }
   }
}

