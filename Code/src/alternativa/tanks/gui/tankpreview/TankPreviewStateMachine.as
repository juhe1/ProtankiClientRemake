package alternativa.tanks.gui.tankpreview
{
   import flash.utils.Dictionary;
   
   public class TankPreviewStateMachine
   {
      
      private var eventTransitions:Dictionary = new Dictionary();
      
      private var currentState:TankPreviewState;
      
      public function TankPreviewStateMachine()
      {
         super();
      }
      
      public function addTransition(param1:TankPreviewEvent, param2:TankPreviewState, param3:TankPreviewState) : void
      {
         var _loc4_:Dictionary = this.eventTransitions[param1];
         if(_loc4_ == null)
         {
            _loc4_ = new Dictionary();
            this.eventTransitions[param1] = _loc4_;
         }
         _loc4_[param2] = param3;
      }
      
      public function handleEvent(param1:TankPreviewState, param2:TankPreviewEvent) : void
      {
         var _loc3_:Dictionary = this.eventTransitions[param2];
         if(_loc3_ == null)
         {
            throw new NoTransitionsFoundError();
         }
         var _loc4_:TankPreviewState = _loc3_[param1];
         if(_loc4_ == null)
         {
            throw new NewStateMissingError();
         }
         param1.exit();
         _loc4_.enter();
         this.currentState = _loc4_;
      }
      
      public function setCurrentState(param1:TankPreviewState) : void
      {
         this.currentState = param1;
         this.currentState.enter();
      }
      
      public function updateCurrentState() : void
      {
         this.currentState.update();
      }
   }
}

