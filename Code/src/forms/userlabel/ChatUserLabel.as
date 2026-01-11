package forms.userlabel
{
   import alternativa.types.Long;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   
   public class ChatUserLabel extends UserLabel
   {
      
      public static const CHAT_MODERATOR_STATUS_ICON_CONT_WIDTH:int = 16;
      
      private static const cmStatusIconClass:Class = ChatUserLabel_cmStatusIconClass;
      
      private static const goldBattleStatusIconClass:Class = ChatUserLabel_goldBattleStatusIconClass;
      
      private static const silverBattleStatusIconClass:Class = ChatUserLabel_silverBattleStatusIconClass;
      
      private static const bronzeBattleStatusIconClass:Class = ChatUserLabel_bronzeBattleStatusIconClass;
      
      private static const goldStatusIconClass:Class = ChatUserLabel_goldStatusIconClass;
      
      private static const silverStatusIconClass:Class = ChatUserLabel_silverStatusIconClass;
      
      private static const bronzeStatusIconClass:Class = ChatUserLabel_bronzeStatusIconClass;
      
      private static const eventGoldStatusIconClass:Class = ChatUserLabel_eventGoldStatusIconClass;
      
      private static const eventSilverStatusIconClass:Class = ChatUserLabel_eventSilverStatusIconClass;
      
      private static const eventBronzeStatusIconClass:Class = ChatUserLabel_eventBronzeStatusIconClass;
      
      private static const bitmapDatas:Dictionary = new Dictionary();
      
      bitmapDatas[ChatModeratorLevel.COMMUNITY_MANAGER] = new cmStatusIconClass().bitmapData;
      //bitmapDatas[ChatModeratorLevel.BATTLE_ADMINISTRATOR] = new goldBattleStatusIconClass().bitmapData;
      //bitmapDatas[ChatModeratorLevel.BATTLE_MODERATOR] = new silverBattleStatusIconClass().bitmapData;
      //bitmapDatas[ChatModeratorLevel.BATTLE_CANDIDATE] = new bronzeBattleStatusIconClass().bitmapData;
      bitmapDatas[ChatModeratorLevel.ADMINISTRATOR] = new goldStatusIconClass().bitmapData;
      bitmapDatas[ChatModeratorLevel.MODERATOR] = new silverStatusIconClass().bitmapData;
      bitmapDatas[ChatModeratorLevel.CANDIDATE] = new bronzeStatusIconClass().bitmapData;
      //bitmapDatas[ChatModeratorLevel.EVENT_CHAT_ADMIN] = new eventGoldStatusIconClass().bitmapData;
      //bitmapDatas[ChatModeratorLevel.EVENT_CHAT_MODERATOR] = new eventSilverStatusIconClass().bitmapData;
      //bitmapDatas[ChatModeratorLevel.EVENT_CHAT_CANDIDATE] = new eventBronzeStatusIconClass().bitmapData;
      
      protected var _chatModeratorLevel:ChatModeratorLevel;
      
      protected var _needDrawAdditionalIcons:Boolean;
      
      public function ChatUserLabel(param1:String, param2:Boolean = true)
      {
         super(param1,param2);
         _needDrawAdditionalIcons = this._chatModeratorLevel != ChatModeratorLevel.NONE;
      }
      
      override protected function createAdditionalIcons() : void
      {
         var _loc1_:Bitmap = null;
         if(this._needDrawAdditionalIcons)
         {
            _loc1_ = new Bitmap(bitmapDatas[this._chatModeratorLevel]);
            _loc1_.x = RANK_ICON_CONT_WIDTH + 1;
            _loc1_.y = 3;
            shadowContainer.addChild(_loc1_);
         }
      }
      
      override protected function getAdditionalIconsWidth() : Number
      {
         return this._needDrawAdditionalIcons ? CHAT_MODERATOR_STATUS_ICON_CONT_WIDTH : 0;
      }
   }
}

