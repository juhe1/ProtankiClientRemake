package projects.tanks.clients.fp10.libraries.tanksservices.service.servername
{
   public interface ServerNumberToLocaleServerService
   {
      
      function isLocalServer() : Boolean;
      
      function getCurrentServerCode() : String;
      
      function getServerCode(param1:int) : String;
      
      function getServerName(param1:int) : String;
      
      function getServerLocale(param1:int) : String;
      
      function getServerNumber(param1:String) : int;
      
      function getLocaleServerNumber(param1:int) : int;
      
      function isValidName(param1:String) : Boolean;
   }
}

