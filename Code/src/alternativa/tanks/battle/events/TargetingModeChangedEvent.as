package alternativa.tanks.battle.events
{
   public class TargetingModeChangedEvent
   {
      
      public var targetingMode:int = 0;
      
      public function TargetingModeChangedEvent(param1:int)
      {
         super();
         this.targetingMode = param1;
      }
   }
}

