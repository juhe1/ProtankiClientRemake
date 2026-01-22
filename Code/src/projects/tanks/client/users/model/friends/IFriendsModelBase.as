package projects.tanks.client.users.model.friends
{
   
   public interface IFriendsModelBase
   {
      
      function acceptSuccess(param1:String) : void;
      
      function acceptedLimitExceeded(param1:String) : void;
      
      function alreadyInAcceptedFriends(param1:String) : void;
      
      function alreadyInIncomingFriends(param1:String, param2:String) : void;
      
      function alreadyInOutgoingFriends(param1:String) : void;
      
      function incomingLimitExceeded() : void;
      
      function yourAcceptedLimitExceeded() : void;
   }
}

