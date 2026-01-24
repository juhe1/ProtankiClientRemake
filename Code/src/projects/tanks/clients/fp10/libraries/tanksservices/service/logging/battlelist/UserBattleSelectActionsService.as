package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist
{
   import flash.events.IEventDispatcher;
   import projects.tanks.client.battleservice.BattleMode;
   
   public interface UserBattleSelectActionsService extends IEventDispatcher
   {
      
      function battleSelected(param1:BattleMode, param2:String) : void;
      
      function turnOnBattleMode(param1:BattleMode) : void;
      
      function turnOffBattleMode(param1:BattleMode) : void;
      
      function createBattle(param1:BattleMode) : void;
      
      function enterToBattle(param1:BattleMode, param2:String) : void;
      
      function copyBattleLink(param1:BattleMode, param2:String) : void;
   }
}

