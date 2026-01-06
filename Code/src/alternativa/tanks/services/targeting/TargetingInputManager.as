package alternativa.tanks.services.targeting
{
   public interface TargetingInputManager
   {
      
      function init() : void;
      
      function initForSpectator() : void;
      
      function close() : void;
      
      function tick() : void;
      
      function addListener(param1:TargetingInputListener) : void;
      
      function removeListener(param1:TargetingInputListener) : void;
      
      function startDialog() : void;
      
      function startDialogWithAllowedKeyboardInput() : void;
      
      function endDialog() : void;
      
      function requestMouseLock() : void;
      
      function unlockMouse() : void;
      
      function ignoreInput(param1:int = 1) : void;
   }
}

