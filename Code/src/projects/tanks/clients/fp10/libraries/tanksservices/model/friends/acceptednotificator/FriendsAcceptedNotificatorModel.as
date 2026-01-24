package projects.tanks.clients.fp10.libraries.tanksservices.model.friends.acceptednotificator
{
   import alternativa.osgi.service.logging.LogService;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.users.model.friends.acceptednotificator.FriendsAcceptedNotificatorModelBase;
   import projects.tanks.client.users.model.friends.acceptednotificator.IFriendsAcceptedNotificatorModelBase;
   import projects.tanks.client.users.model.friends.container.UserContainerCC;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.IFriends;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.NewFriendRemoveEvent;
   
   [ModelInfo]
   public class FriendsAcceptedNotificatorModel extends FriendsAcceptedNotificatorModelBase implements IFriendsAcceptedNotificatorModelBase, ObjectLoadListener, ObjectUnloadListener
   {
      
      [Inject] // added
      public static var logService:LogService;
      
      [Inject] // added
      public static var friendsInfoService:IFriendInfoService;
      
      public function FriendsAcceptedNotificatorModel()
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
               logService.getLogger("fcounter").debug("FriendsAcceptedNotificatorModel newFriendsAccepted userId=%1",[_loc2_]);
               friendsInfoService.onAddNewAcceptedFriend(_loc2_);
            }
            friendsInfoService.addEventListener(NewFriendRemoveEvent.ACCEPTED,getFunctionWrapper(this.remove));
         }
      }
      
      private function remove(param1:NewFriendRemoveEvent) : void
      {
         if(IFriends(object.adapt(IFriends)).isLocal())
         {
            logService.getLogger("fcounter").debug("FriendsAcceptedNotificatorModel remove userId=%1",[param1.userId]);
            server.remove(param1.userId);
         }
      }
      
      public function onAdding(param1:String) : void
      {
         if(IFriends(object.adapt(IFriends)).isLocal())
         {
            logService.getLogger("fcounter").debug("FriendsAcceptedNotificatorModel onAdding userId=%1",[param1]);
            friendsInfoService.onAddNewAcceptedFriend(param1);
         }
      }
      
      public function onRemoved(param1:String) : void
      {
         if(IFriends(object.adapt(IFriends)).isLocal())
         {
            logService.getLogger("fcounter").debug("FriendsAcceptedNotificatorModel onRemoved userId=%1",[param1]);
            friendsInfoService.onRemoveNewAcceptedFriend(param1);
         }
      }
      
      public function objectUnloaded() : void
      {
         if(IFriends(object.adapt(IFriends)).isLocal())
         {
            logService.getLogger("fcounter").debug("FriendsAcceptedNotificatorModel objectUnloaded");
            friendsInfoService.removeEventListener(NewFriendRemoveEvent.ACCEPTED,getFunctionWrapper(this.remove));
         }
      }
   }
}

