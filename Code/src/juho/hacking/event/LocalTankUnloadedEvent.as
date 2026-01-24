package juho.hacking.event {
   
   import flash.events.Event;
   
	/**
    * ...
    * @author juhe
    */
   
   public class LocalTankUnloadedEvent extends Event {
      
      public static const LOCAL_TANK_UNLOADED_EVENT:String = "LocalTankUnloadedEvent";
      
      public function LocalTankUnloadedEvent(bubbles:Boolean = false, cancelable:Boolean = false) {
         super(LOCAL_TANK_UNLOADED_EVENT, bubbles, cancelable);
      }
      
      override public function clone():Event {
        return new LocalTankUnloadedEvent(this.bubbles, this.cancelable);
      }
      
   }

}