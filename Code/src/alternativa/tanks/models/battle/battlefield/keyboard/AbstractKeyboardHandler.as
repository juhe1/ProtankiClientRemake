package alternativa.tanks.models.battle.battlefield.keyboard
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.services.battleinput.BattleInputLockEvent;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import flash.events.KeyboardEvent;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class AbstractKeyboardHandler implements AutoClosable
   {
      
      [Inject]
      public static var battleInputService:BattleInputService;
      
      [Inject]
      public static var display:IDisplay;
      
      public function AbstractKeyboardHandler()
      {
         super();
         display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.handleKeyboardEvent);
         display.stage.addEventListener(KeyboardEvent.KEY_UP,this.handleKeyboardEvent);
         battleInputService.addEventListener(BattleInputLockEvent.INPUT_LOCKED,this.handleLock);
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         battleInputService.removeEventListener(BattleInputLockEvent.INPUT_LOCKED,this.handleLock);
         display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.handleKeyboardEvent);
         display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.handleKeyboardEvent);
      }
      
      protected function handleLock(param1:BattleInputLockEvent = null) : void
      {
      }
      
      protected function handleKeyboardEvent(param1:KeyboardEvent = null) : void
      {
      }
   }
}

