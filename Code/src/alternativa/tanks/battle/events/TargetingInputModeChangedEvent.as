package alternativa.tanks.battle.events
{
   public class TargetingInputModeChangedEvent
   {
      
      public var enabled:Boolean;
      
      public var allowKeyboard:Boolean;
      
      public function TargetingInputModeChangedEvent(param1:Boolean, param2:Boolean)
      {
         super();
         this.enabled = param1;
         this.allowKeyboard = param2;
      }
   }
}

