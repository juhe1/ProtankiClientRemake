package alternativa.tanks.service.battle
{
   import alternativa.tanks.model.item.BattleFriendsListener;
   import alternativa.types.Long;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendStateChangeEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
   
   public class BattleFriendNotifier
   {
      
      [Inject] // added
      public static var friendsInfoService:IFriendInfoService;
      
      [Inject] // added
      public static var battleUserInfoService:IBattleUserInfoService;
      
      public function BattleFriendNotifier()
      {
         super();
         friendsInfoService.addEventListener(FriendStateChangeEvent.CHANGE,this.onChangeFriendState);
      }
      
      public function destroy() : void
      {
         friendsInfoService.removeEventListener(FriendStateChangeEvent.CHANGE,this.onChangeFriendState);
      }
      
      private function onChangeFriendState(param1:FriendStateChangeEvent) : void
      {
         var _loc5_:BattleFriendsListener = null;
         var _loc2_:String = param1.userId;
         var _loc3_:FriendState = param1.state;
         var _loc4_:FriendState = param1.prevState;
         if(battleUserInfoService.userInBattle(_loc2_))
         {
            _loc5_ = BattleFriendsListener(battleUserInfoService.getBattle(_loc2_).adapt(BattleFriendsListener));
            if(_loc3_ == FriendState.ACCEPTED)
            {
               _loc5_.onAddFriend(_loc2_);
            }
            if(_loc3_ == FriendState.UNKNOWN && _loc4_ == FriendState.ACCEPTED)
            {
               _loc5_.onDeleteFriend(_loc2_);
            }
         }
      }
   }
}

