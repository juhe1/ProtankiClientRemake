package projects.tanks.clients.fp10.libraries.tanksservices.service.friend
{
   import flash.events.IEventDispatcher;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
   
   public interface IFriendInfoService extends IEventDispatcher
   {
      
      function setFriendState(param1:String, param2:FriendState) : void;
      
      function isFriendsInState(param1:String, param2:FriendState) : Boolean;
      
      function isNewFriend(param1:String) : Boolean;
      
      function getFriendsIdByState(param1:FriendState) : Vector.<String>;
      
      function deleteFriend(param1:String, param2:FriendState) : void;
      
      function getOrCreateUpdater(param1:String) : IFriendsInfoLabelUpdater;
      
      function get acceptedFriendsLength() : int;
      
      function get incomingFriendsLength() : int;
      
      function onAddNewAcceptedFriend(param1:String) : void;
      
      function onRemoveNewAcceptedFriend(param1:String) : void;
      
      function removeNewAcceptedFriend(param1:String) : void;
      
      function isNewAcceptedFriend(param1:String) : Boolean;
      
      function get newAcceptedFriendsLength() : int;
      
      function onAddNewIncomingFriend(param1:String) : void;
      
      function onRemoveNewIncomingFriend(param1:String) : void;
      
      function removeNewIncomingFriend(param1:String) : void;
      
      function isNewIncomingFriend(param1:String) : Boolean;
      
      function get newIncomingFriendsLength() : int;
   }
}

