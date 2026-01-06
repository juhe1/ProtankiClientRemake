package alternativa.tanks.services.battleinput
{
   import flash.events.IEventDispatcher;
   
   public interface BattleInputService extends IEventDispatcher
   {
      
      function lock(param1:BattleInputLockType) : void;
      
      function unlock(param1:BattleInputLockType) : void;
      
      function isInputLocked() : Boolean;
      
      function isChatLocked() : Boolean;
   }
}

