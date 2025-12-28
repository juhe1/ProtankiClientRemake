package projects.tanks.clients.fp10.libraries.tanksservices.service.friend
{
   import alternativa.types.Long;
   import flash.events.IEventDispatcher;
   
   public interface IFriendActionService extends IEventDispatcher
   {
      
      function add(param1:String) : void;
      
      function addByUid(param1:String) : void;
      
      function accept(param1:String) : void;
      
      function breakItOff(param1:String) : void;
      
      function reject(param1:String) : void;
      
      function rejectAllIncoming() : void;
      
      function alreadyInIncomingFriends(param1:String, param2:String) : void;
      
      function alreadyInAcceptedFriends(param1:String) : void;
      
      function alreadyInOutgoingFriends(param1:String) : void;
      
      function incomingLimitExceeded() : void;
      
      function acceptedLimitExceeded(param1:String) : void;
      
      function requestAccepted(param1:String) : void;
      
      function yourAcceptedLimitExceeded() : void;
   }
}

