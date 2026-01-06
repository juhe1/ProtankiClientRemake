package alternativa.tanks.models.battle.battlefield
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class SpectatorFogToggleSupport implements AutoClosable
   {
      
      [Inject]
      public static var dislpay:IDisplay;
      
      [Inject]
      public static var battleInputService:BattleInputService;
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const FOG_TOGGLE_KEY:uint = Keyboard.F8;
      
      public function SpectatorFogToggleSupport()
      {
         super();
         dislpay.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == FOG_TOGGLE_KEY && !battleInputService.isInputLocked())
         {
            battleService.getBattleScene3D().toggleFog();
         }
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         dislpay.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
   }
}

