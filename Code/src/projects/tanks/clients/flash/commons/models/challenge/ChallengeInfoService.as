package projects.tanks.clients.flash.commons.models.challenge
{
   import platform.client.fp10.core.type.IGameObject;
   
   public interface ChallengeInfoService
   {
      
      function isInTime() : Boolean;
      
      function getEndTime() : Number;
      
      function startEvent(param1:int) : void;
      
      function get shopItem() : IGameObject;
      
      function set shopItem(param1:IGameObject) : void;
   }
}

