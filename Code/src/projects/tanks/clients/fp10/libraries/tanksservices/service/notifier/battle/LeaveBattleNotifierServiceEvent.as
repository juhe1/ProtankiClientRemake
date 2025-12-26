package projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle
{
   import flash.events.Event;
   
   public class LeaveBattleNotifierServiceEvent extends Event
   {
      
      public static const LEAVE:String = "LeaveBattleNotifierServiceEvent.LEAVE_BATTLE";
      
      public var userId:String;
      
      public function LeaveBattleNotifierServiceEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         this.userId = param2;
         super(param1,param3,param4);
      }
   }
}

