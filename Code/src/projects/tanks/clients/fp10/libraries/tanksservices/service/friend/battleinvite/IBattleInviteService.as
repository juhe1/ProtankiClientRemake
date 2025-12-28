package projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite
{
   import alternativa.types.Long;
   import flash.events.IEventDispatcher;
   import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
   
   public interface IBattleInviteService extends IEventDispatcher
   {
      
      function getAvailabilityInviteBattle(param1:String) : Boolean;
      
      function invite(param1:String) : void;
      
      function accept(param1:String, param2:BattleInfoData) : void;
      
      function reject(param1:String) : void;
      
      function get receiveBattleInvite() : Boolean;
      
      function set receiveBattleInvite(param1:Boolean) : void;
      
      function removeInvite(param1:String) : void;
   }
}

