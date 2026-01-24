package alternativa.tanks.service.dailyquest
{
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadPostListener;
   import projects.tanks.client.panel.model.dailyquest.notifier.DailyQuestNotifierModelBase;
   import projects.tanks.client.panel.model.dailyquest.notifier.IDailyQuestNotifierModelBase;
   
   [ModelInfo]
   public class DailyQuestNotifierModel extends DailyQuestNotifierModelBase implements IDailyQuestNotifierModelBase, ObjectLoadPostListener, ObjectUnloadPostListener
   {
      
      [Inject] // added
      public static var dailyQuestNotifierService:DailyQuestNotifierService;
      
      public function DailyQuestNotifierModel()
      {
         super();
      }
      
      public function notifyDailyQuestCompleted() : void
      {
         dailyQuestNotifierService.showNotification();
      }
      
      public function objectLoadedPost() : void
      {
         dailyQuestNotifierService.addEventListener(DailyQuestNotificationEvent.HIDE_NOTIFICATION,this.onDailyQuestChangesViewed);
      }
      
      private function onDailyQuestChangesViewed(param1:DailyQuestNotificationEvent) : void
      {
         server.notifyDailyQuestChangesViewed();
      }
      
      public function objectUnloadedPost() : void
      {
         dailyQuestNotifierService.removeEventListener(DailyQuestNotificationEvent.HIDE_NOTIFICATION,this.onDailyQuestChangesViewed);
      }
      
      public function notifyDailyQuestGenerated() : void
      {
         dailyQuestNotifierService.showNotification();
      }
   }
}

