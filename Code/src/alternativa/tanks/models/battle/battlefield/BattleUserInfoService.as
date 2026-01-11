package alternativa.tanks.models.battle.battlefield
{
   import alternativa.types.Long;
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   
   public interface BattleUserInfoService
   {
      
      function getUserName(param1:String) : String;
      
      function getUserRank(param1:String) : int;
      
      function isUserSuspected(param1:String) : Boolean;
      
      function getChatModeratorLevel(param1:String) : ChatModeratorLevel;
      
      function hasUserPremium(param1:String) : Boolean;
      
      function addBattleUserInfoListener(param1:BattleUserInfoListener) : void;
      
      function removeBattleUserInfoListener(param1:BattleUserInfoListener) : void;
   }
}

