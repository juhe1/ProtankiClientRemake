package projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect
{
   import projects.tanks.client.tanksservices.model.reconnect.ReconnectCC;
   
   public interface ReconnectService
   {
      
      function isLocalServer(param1:int) : Boolean;
      
      function isEnabled() : Boolean;
      
      function isEnabledChooseServerByRank() : Boolean;
      
      function getCurrentServerNumber() : int;
      
      function getReconnectConfig() : ReconnectCC;
      
      function moveUserToServer(param1:int) : void;
   }
}

