package projects.tanks.clients.fp10.libraries.tanksservices.model.friends.incoming
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.users.model.friends.container.UserContainerCC;
   import projects.tanks.client.users.model.friends.incoming.FriendsIncomingModelBase;
   import projects.tanks.client.users.model.friends.incoming.IFriendsIncomingModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.IFriends;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
   
   [ModelInfo]
   public class FriendsIncomingModel extends FriendsIncomingModelBase implements IFriendsIncomingModelBase, ObjectLoadListener
   {
      
      [Inject] // added
      public static var friendsInfoService:IFriendInfoService;
      
      public function FriendsIncomingModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         var _loc1_:UserContainerCC = null;
         var _loc2_:String = null;
         if(IFriends(object.adapt(IFriends)).isLocal())
         {
            _loc1_ = getInitParam();
            for each(_loc2_ in _loc1_.users)
            {
               friendsInfoService.setFriendState(_loc2_,FriendState.INCOMING);
            }
         }
      }
      
      public function onAdding(param1:String) : void
      {
         if(IFriends(object.adapt(IFriends)).isLocal())
         {
            friendsInfoService.setFriendState(param1,FriendState.INCOMING);
         }
      }
      
      public function onRemoved(param1:String) : void
      {
         if(IFriends(object.adapt(IFriends)).isLocal())
         {
            friendsInfoService.deleteFriend(param1,FriendState.INCOMING);
         }
      }
   }
}

