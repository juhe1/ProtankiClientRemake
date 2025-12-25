package alternativa.tanks.loader
{
   import flash.events.Event;
   
   public class TipsLoadingCompletedEvent extends Event
   {
      
      public static const TIPS_LOADING_COMPLETED_EVENT:String = "tipsLoadingCompleted";
      
      public function TipsLoadingCompletedEvent(param1:String)
      {
         super(param1,true);
      }
   }
}

