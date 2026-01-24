package alternativa.tanks.gui.chat
{
   import flash.events.MouseEvent;
   import forms.userlabel.ChatUserLabel;
   import forms.userlabel.UserLabelClickWithCtrlEvent;
   import projects.tanks.client.chat.types.UserStatus;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.UidUtil;
   
   public class LobbyChatUserLabel extends ChatUserLabel
   {
      
      public function LobbyChatUserLabel(param1:UserStatus, param2:Boolean, param3:String, param4:Boolean = true)
      {
         _uid = param1.uid;
         _rank = param1.rankIndex;
         _chatModeratorLevel = param1.chatModeratorLevel;
         _writeInPublicChat = param2;
         _writePrivateInChat = param2;
         _forciblySubscribeFriend = true;
         _blockUserEnable = true;
         inviteBattleEnable = true;
         showClanProfile = true;
         _self = param1.uid == param3;
         super(param1.userId,param4);
      }
      
      override protected function initSelf() : void
      {
      }
      
      override protected function updateProperties() : void
      {
         setUid(_uid);
         setRank(_rank);
         setFriendState(_friendInfoUpdater.state);
      }
      
      override protected function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(userPropertiesService.userId == _userId)
         {
            return;
         }
         if(param1.ctrlKey)
         {
            dispatchEvent(new UserLabelClickWithCtrlEvent(UserLabelClickWithCtrlEvent.USER_LABEL_CLICK_WITH_CTRL_EVENT,UidUtil.userNameWithoutClanTag(_uid),param1.shiftKey));
         }
         else
         {
            switch(_friendState)
            {
               case FriendState.ACCEPTED:
                  _loc3_ = true;
                  break;
               case FriendState.INCOMING:
                  _loc4_ = true;
                  _loc5_ = true;
                  break;
               default:
                  _loc2_ = true;
            }
            contextMenuService.show(_userId,_rank,getUidWithClanTag(_uid),_loc2_,_loc3_,_loc4_,_loc5_,_writeInPublicChat,_writePrivateInChat,_blockUserEnable,inviteBattleEnable,false,showClanProfile);
         }
      }
   }
}

