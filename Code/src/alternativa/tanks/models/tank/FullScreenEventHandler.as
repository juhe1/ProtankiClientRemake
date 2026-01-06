package alternativa.tanks.models.tank
{
   import alternativa.tanks.services.targeting.TargetingInputManager;
   import platform.client.fp10.core.type.AutoClosable;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.DialogWindowsDispatcherServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
   
   public class FullScreenEventHandler implements AutoClosable
   {
      
      [Inject]
      public static var dialogWindowsDispatcherService:IDialogWindowsDispatcherService;
      
      [Inject]
      public static var inputManager:TargetingInputManager;
      
      public function FullScreenEventHandler()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         dialogWindowsDispatcherService.addEventListener(DialogWindowsDispatcherServiceEvent.OPEN,this.onWindowOpen);
         dialogWindowsDispatcherService.addEventListener(DialogWindowsDispatcherServiceEvent.CLOSE,this.onWindowClose);
      }
      
      private function onWindowClose(param1:DialogWindowsDispatcherServiceEvent) : void
      {
         inputManager.endDialog();
      }
      
      private function onWindowOpen(param1:DialogWindowsDispatcherServiceEvent) : void
      {
         inputManager.startDialog();
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         dialogWindowsDispatcherService.removeEventListener(DialogWindowsDispatcherServiceEvent.OPEN,this.onWindowOpen);
         dialogWindowsDispatcherService.removeEventListener(DialogWindowsDispatcherServiceEvent.CLOSE,this.onWindowClose);
      }
   }
}

