package alternativa.tanks.service.dailyquest
{
   import flash.events.IEventDispatcher;
   
   public interface DailyQuestNotifierService extends IEventDispatcher
   {
      
      function showNotification() : void;
      
      function hideNotification() : void;
   }
}

