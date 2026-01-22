package projects.tanks.client.panel.model.battleinvite
{
   import alternativa.types.Long;
   
   public interface IBattleInviteModelBase
   {
      
      function accepted(param1:String) : void;
      
      function notify(param1:String, param2:BattleInviteMessage) : void;
      
      function rejected(param1:String) : void;
      
      function rejectedBattleNotFound(param1:String) : void;
      
      function rejectedInvitationToBattleDisabled(param1:String) : void;
      
      function rejectedPanelNotLoaded(param1:String) : void;
      
      function rejectedUserAlreadyInBattle(param1:String) : void;
      
      function rejectedUserInMatchBattle(param1:String) : void;
      
      function rejectedUserOffline(param1:String) : void;
   }
}

