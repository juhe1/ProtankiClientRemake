package alternativa.tanks.models.battle.battlefield
{
   import alternativa.tanks.camera.controllers.spectator.SpectatorCameraController;
   import alternativa.tanks.services.battleinput.BattleInputLockEvent;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class SpectatorCameraControllerLocker implements AutoClosable
   {
      
      [Inject]
      public static var battleInputLockService:BattleInputService;
      
      private var cameraController:SpectatorCameraController;
      
      public function SpectatorCameraControllerLocker(param1:SpectatorCameraController)
      {
         super();
         this.cameraController = param1;
         battleInputLockService.addEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
         battleInputLockService.addEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
         if(battleInputLockService.isInputLocked())
         {
            param1.deactivateInput();
         }
      }
      
      private function onInputLocked(param1:BattleInputLockEvent) : void
      {
         this.cameraController.deactivateInput();
      }
      
      private function onInputUnlocked(param1:BattleInputLockEvent) : void
      {
         this.cameraController.activateInput();
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.cameraController = null;
         battleInputLockService.removeEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
         battleInputLockService.removeEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
      }
   }
}

