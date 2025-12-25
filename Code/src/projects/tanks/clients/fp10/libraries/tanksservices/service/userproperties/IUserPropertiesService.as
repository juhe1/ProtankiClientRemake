package projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties
{
   import flash.events.IEventDispatcher;
   
   public interface IUserPropertiesService extends IEventDispatcher
   {
      function get userId() : String;
      
      function get userName() : String;
      
      function get score() : int;
      
      function get rank() : int;
      
      function getUserProfileUrl(param1:String) : String;
      
      function get serverNumber() : int;
      
      function get templateBattlePage() : String;
      
      function get gameHost() : String;
      
      function init(param1:String, param2:String, param3:int, param4:int, param5:int, param6:String, param7:String, param8:String) : void;
      
      function updateRank(param1:int) : void;
      
      function updateScore(param1:int) : void;
   }
}

