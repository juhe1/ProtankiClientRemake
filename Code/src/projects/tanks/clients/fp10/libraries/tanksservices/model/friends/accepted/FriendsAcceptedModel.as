package projects.tanks.clients.fp10.libraries.tanksservices.model.friends.accepted
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.users.model.friends.accepted.FriendsAcceptedModelBase;
   import projects.tanks.client.users.model.friends.accepted.IFriendsAcceptedModelBase;
   import projects.tanks.client.users.model.friends.container.UserContainerCC;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.IFriends;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
   
   [ModelInfo]
   public class FriendsAcceptedModel extends FriendsAcceptedModelBase implements IFriendsAcceptedModelBase, ObjectLoadListener
   {
      
      [Inject]
      public static var friendsInfoService:IFriendInfoService;
      
      public function FriendsAcceptedModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         var _loc1_:UserContainerCC = null;
         var _loc2_:Long = null;
         if(IFriends(object.adapt(IFriends)).isLocal())
         {
            _loc1_ = getInitParam();
            for each(_loc2_ in _loc1_.users)
            {
               friendsInfoService.setFriendState(_loc2_,FriendState.ACCEPTED);
            }
         }
      }
      
      public function onAdding(param1:Long) : void
      {
         if(IFriends(object.adapt(IFriends)).isLocal())
         {
            friendsInfoService.setFriendState(param1,FriendState.ACCEPTED);
         }
      }
      
      public function onRemoved(param1:Long) : void
      {
         if(IFriends(object.adapt(IFriends)).isLocal())
         {
            friendsInfoService.deleteFriend(param1,FriendState.ACCEPTED);
         }
      }
   }
}

